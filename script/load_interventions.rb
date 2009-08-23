puts "Cleaning interventions..."
Intervention.destroy_all
InterventionParliamentarian.destroy_all
Speaker.destroy_all
InterventionSpeaker.destroy_all

l = Legebiltzarra::Legislature.new 

puts "Loading Interventions..."
l.parliamentarians.each do |p|
  parliamentarian = Parliamentarian.find_by_orig_id(p.orig_id)

  p.interventions.select{|int| int.id.start_with?("2009")}.each do |i|
    intervention = Intervention.create(:file_number => i.file_number, 
                                       :session_date => i.session_date,
                                        :diary_number => i.diary_number, 
                                        :subject_number => i.subject_number, 
                                        :subject_title => i.subject_title, 
                                        :txt_url => i.txt_url, 
                                        :full_txt => i.full_txt, 
                                        :pdf_url => i.pdf_url, 
                                        :videos => i.videos, 
                                        :subject_treated => i.subject_treated)
    intervention.commision = Commision.first(:conditions => ["name like ?", i.commission]) unless i.commission.blank?
    intervention.initiative = Initiative.find_by_num_exp(i.original_initiative) unless i.original_initiative.blank?
    intervention.save! 
    
    i.speakers.each do |s|
      s = s.gsub(/ \(.*\)/, '')
      parl = Parliamentarian.first(:conditions => ["full_name like ?", s])
      if parl
        puts "  Parliamentarian - #{intervention.id} - #{parl.full_name} (#{parl.id})"
        InterventionParliamentarian.create(:intervention_id => intervention.id, :parliamentarian_id => parl.id)
      else
        speaker = Speaker.first(:conditions => ["name like ?", s])
        speaker = Speaker.create(:name=>s) unless speaker
        puts "  Speaker - #{intervention.id} - #{speaker.name} (#{speaker.id})"
        InterventionSpeaker.create(:intervention_id => intervention.id, :speaker_id => speaker.id)
      end
    end
  end
  
  puts "#{parliamentarian.orig_id} - #{parliamentarian.full_name} - #{parliamentarian.interventions.count}"
end

puts "#{Intervention.count} interventions loaded."