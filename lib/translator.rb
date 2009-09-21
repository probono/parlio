class Translator
  
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
  
  private
    def self.get_speaker(name)
      Speaker.find_or_create_by_name(:name => name)
    end
    
    def self.find_parliamentarian(name)
      return unless name
      name = "de Urquijo Valdivielso, Carlos M.ª" if name.index("De Urquijo Valdivielso, Carlos M.ª")
      name = name[0, name.index('(')].strip if name.index('(')
      Parliamentarian.find_by_full_name(name)
    end
    
    def self.changed_initiative?(local, remote) 
      return local.num_exp != remote.num_exp || local.title != remote.title ||
             local.votings != remote.votings.to_s || local.proposer != remote.proposer ||
             local.recipient != remote.recipient || local.initiative_date != remote.initiative_date ||
             local.initiative_type != remote.type || local.tag_list.to_s != remote.tags.join(", ")
    end  
   
end