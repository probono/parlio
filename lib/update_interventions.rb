class UpdateInterventions
  
  def self.update
    puts "Updating interventions..."

    l = Legebiltzarra::Legislature.new 
    parliamentarians = l.parliamentarians
    
    updated = 0
    created = 0
    count = 0
    
    parliamentarians.each do |remote_p|
      
      parliamentarian = Parliamentarian.find_by_orig_id(remote_p.id)



      remote_p.interventions.select{|int| int.id.start_with?("2009")}.each do |i|
        feedback(count += 1)
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

          intervention.commision = Commision.first(:conditions => ["name like ?", i.commission.gsub("Comisión de ","")]) unless i.commission.blank?
          intervention.initiative = Initiative.find_by_num_exp(i.original_initiative) unless i.original_initiative.blank?
          intervention.save! 
          
          created += 1                  
        end
        
        i.speakers.each do |s|
          s = s.gsub(/ \(.*\)/, '')
          parl = Parliamentarian.first(:conditions => ["full_name like ?", s])
          if parl
            InterventionParliamentarian.create(:intervention_id => intervention.id, :parliamentarian_id => parl.id) unless intervention.parliamentarians.include?(parl)
          else
            speaker = Speaker.find_or_create_by_name(:name => s)
            InterventionSpeaker.create(:intervention_id => intervention.id, :speaker_id => speaker.id) unless intervention.speakers.include?(speaker)
          end
        end
        
        i.videos.each do |v|
          unless intervention.videos.find_by_video_url(v.video_url)
            video = intervention.videos.build(:duration => v.duration, :title => v.title, :video_url => v.video_url)
            if parl = Parliamentarian.find(:first, :conditions => ['full_name like ?', v.title])
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
    end
    puts "\n#{updated} initiatives updated. #{created} new initiatives created.\n"
  end
    
  def self.feedback(count)
    if count % 10 == 0
      print "."
      $stdout.flush
    end          
  end  
  
end