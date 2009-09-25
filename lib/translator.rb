class Translator

  def self.parliamentarian(remote_p)
    local = Parliamentarian.find_by_orig_id(remote_p.orig_id)
    if local && changed_parliamentarian?(local, remote_p)
      ['full_name', 'photo', 'profession', 'languages', 'email', 'degree'].each do |a|
        local.send("#{a}=", remote_p.send(a))
      end
      #FIXME, check instead of remove&create
      local.posts.destroy_all
      remote_p.posts.each{|po| local.posts.build(:title => po) } 
    elsif !local
      local = Parliamentarian.new(:active => true)
      ['orig_id', 'full_name', 'photo', 'profession', 'languages', 'email', 'degree'].each do |a|
        local.send("#{a}=", remote_p.send(a))
      end
      remote_p.posts.each{|po| local.posts.build(:title => po) }
    end
    local.save!
    local  
  end
  
  def self.party(remote_p)
    party = Party.find_by_acronym(remote_p.acronym)
    if !party
      party = Party.new
      ['group_name', 'acronym', 'sites', 'name', 'url', 'logo'].each do |a|
        party.send("#{a}=", remote_p.send(a))
      end
      party.url = p.url
      party.save!    
    end
    party
  end
  
  def self.comission(remote_c)
    commission = Commision.find_by_name(remote_c.name)
    if commission
      commission.members.delete_all
    else
      commission = Commision.new
      ['name'].each do |a|
        commission.send("#{a}=", c.send(a))
      end      
      created += 1
      commission.save! 
    end
    create_member(commission, remote_c.president.id, CommissionMember::PRESIDENT, remote_c.president.date)
    create_member(commission, remote_c.vicepresident.id, CommissionMember::VICEPRESIDENT, remote_c.vicepresident.date)
    create_member(commission, remote_c.secretary.id, CommissionMember::SECRETARY, remote_c.secretary.date)

    remote_c.vocals.each do |p|
      create_member(commission, p.id, CommissionMember::VOCAL, p.date)
    end    
    commission
  end
    
  def self.topic(remote_t)
    topic = Topic.find_by_name(remote_t.name)
    unless topic
      topic = Topic.new
      ['name'].each do |a|
        topic.send("#{a}=", remote_t.send(a))
      end      
      topic.save! 
    end
    topic
  end

  def self.initiative(remote_i)
    initiative = Initiative.find_by_num_exp(remote_i.num_exp)
    unless initiative 
      initiative = Initiative.new
      initiative.created_at = remote_i.initiative_date
    end
    initiative.commision = find_comission(remote_i.processing) unless remote_i.processing.blank?

    if changed_initiative?(initiative, remote_i)
      ['num_exp', 'title', 'proposer', 'recipient', 'initiative_date'].each do |a|
        initiative.send("#{a}=", remote_i.send(a))
      end
      initiative.votings= remote_i.votings.to_s
      initiative.initiative_type= remote_i.type
      initiative.tag_list = remote_i.tags.join(",")
    end
    
    if parliamentarian = find_parliamentarian(initiative.proposer)
      initiative.parliamentarian = parliamentarian
    else
      initiative.speaker = get_speaker(initiative.proposer)  if initiative.proposer
    end

    #FIXME, comprobar en lugar de cargárnoslos todos
    initiative.procedures.destroy_all
    remote_i.procedures.each do |p|
      initiative.procedures.build(:title => p[:title], :url => p[:url], :procedure_date => p[:procedure_date])
    end
    initiative.save! 
    initiative
  end
    
  def self.intervention(i)
    intervention = Intervention.find_by_file_number(i.file_number)
    unless intervention
      intervention = Intervention.create(:file_number => i.file_number, 
                                         :session_date => i.session_date,
                                         :diary_number => i.diary_number, 
                                         :subject_number => i.subject_number, 
                                         :subject_title => i.subject_title, 
                                         :txt_url => i.txt_url, 
                                         :full_txt => i.full_txt, 
                                         :pdf_url => i.pdf_url,
                                         :subject_treated => i.subject_treated)

      intervention.commision = find_comission(i.commission) unless i.commission.blank?
      intervention.initiative = Initiative.find_by_num_exp(i.original_initiative) unless i.original_initiative.blank?
      intervention.save!                
    end
    
    i.speakers.each do |s|
      
      if parliamentarian = find_parliamentarian(s)
        InterventionParliamentarian.create(:intervention_id => intervention.id, 
                      :parliamentarian_id => parliamentarian.id)  unless intervention.parliamentarians.include?(parliamentarian)
        
      else
        speaker = get_speaker(s)
        InterventionSpeaker.create(:intervention_id => intervention.id, 
                                   :speaker_id => speaker.id) unless intervention.speakers.include?(speaker)
      end      
    end
    
    i.videos.each do |v|
      unless intervention.videos.find_by_video_url(v.video_url)
        video = intervention.videos.build(:duration => v.duration, :title => v.title, :video_url => v.video_url)
        if parl = find_parliamentarian(v.title)
          video.parliamentarian = parl
        end
        if speaker = Speaker.find_by_name(v.title)
          video.speaker = speaker
        end
        puts "Who is '#{video.title}' ?" unless video.parliamentarian || video.speaker
        video.save
      end
    end
  end  
  
  private
  
    def self.find_comission(name)
      name = name.gsub("Comisión de ","")
      Commision.first(:conditions => ["name like ?", name])      
    end
    
    def self.create_member(commission, parlamentarian_id, role, date)
      parl = Parliamentarian.find_by_orig_id(parlamentarian_id)
      CommissionMember.create(:commision_id => commission.id, 
                              :parliamentarian_id => parl.id, 
                              :position => role, :date => date)
    end
    
    def self.get_speaker(name)
      Speaker.find_or_create_by_name(:name => name)
    end
    
    def self.find_parliamentarian(name)
      return unless name
      name = "de Urquijo Valdivielso, Carlos M.ª" if name.index("De Urquijo Valdivielso, Carlos M.ª")
      name = name.gsub(/ \(.*\)/, '')
      Parliamentarian.find_by_full_name(name)
    end
    
    def self.changed_initiative?(local, remote) 
      return local.num_exp != remote.num_exp || local.title != remote.title ||
             local.votings != remote.votings.to_s || local.proposer != remote.proposer ||
             local.recipient != remote.recipient || local.initiative_date != remote.initiative_date ||
             local.initiative_type != remote.type || local.tag_list.to_s != remote.tags.join(", ")
    end
    
    def self.changed_parliamentarian?(local, remote)
      return local.full_name != remote.full_name || local.photo != remote.photo ||
             local.profession != remote.profession || local.languages != remote.languages ||
             local.email != remote.email || local.degree != remote.degree
    end      
   
end