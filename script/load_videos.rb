puts "Cleaning videos..."
Video.destroy_all

l = Legebiltzarra::Legislature.new 

puts "Loading videos..."
l.parliamentarians.each do |p|
  parliamentarian = Parliamentarian.find_by_orig_id(p.orig_id)

  p.interventions.select{|int| int.id.start_with?("2009")}.each do |i|
    intervention = Intervention.find_by_file_number(i.file_number)
    if intervention && intervention.videos.empty?
      
      i.videos.each do |v|
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
   
      puts "Intervention #{intervention.file_number} (id: #{intervention.id}) has #{intervention.videos.count} videos"
      
    end
  end
  
end