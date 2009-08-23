puts "Cleaning announcements..."
Announcement.destroy_all

l = Legebiltzarra::Legislature.new 
parliamentarians = l.parliamentarians
puts "Loading initiatives..."
parliamentarians.each do |p|
  parliamentarian = Parliamentarian.find_by_orig_id(p.id)
  
  p.initiatives.select{|ini| ini.num_exp.start_with?("09")}.each do |i|
    
    initiative = Initiative.find_by_num_exp(i.num_exp)
    if initiative && i.announcement
      announcement = initiative.announcements.build
      ['announcement_url', 'summary', 'announcement_date', 'num_exp', 'number', 'page'].each do |m|
        announcement.send("#{m}=", i.announcement.send(m))
      end
      announcement.save
      puts "Initiative #{initiative.id} has an announcement.\n"
    end
    
  end
  
end