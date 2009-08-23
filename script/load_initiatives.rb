puts "Cleaning initiatives..."
Initiative.destroy_all

l = Legebiltzarra::Legislature.new 
parliamentarians = l.parliamentarians
puts "Loading Parliamentarians..."
parliamentarians.each do |p|
  parliamentarian = Parliamentarian.find_by_orig_id(p.id)
  
  p.initiatives.select{|ini| ini.num_exp.start_with?("09")}.each do |i|
    initiative = parliamentarian.initiatives.build
    ['num_exp', 'title', 'procedures', 'votings', 'proposer', 'recipient', 'initiative_date'].each do |a|
      initiative.send("#{a}=", i.send(a))
    end
    initiative.initiative_type=i.type
    initiative.tag_list = i.tags.join(",")
  end
  
  parliamentarian.save!
  
  puts "#{parliamentarian.orig_id} - #{parliamentarian.full_name} - #{parliamentarian.initiatives.count}"
end
