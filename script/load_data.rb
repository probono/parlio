puts "Cleaning DB..."
Party.destroy_all
Parliamentarian.destroy_all

l = Legebiltzarra::Legislature.new 

puts "Loading Parliamentarians..."
l.parliamentarians.each do |p|
  parliamentarian = Parliamentarian.new
  ['orig_id', 'full_name', 'photo', 'profession', 'languages', 'email', 'posts'].each do |a|
    parliamentarian.send("#{a}=", p.send(a))
  end
  
  p.initiatives.select{|ini| ini.num_exp.start_with?("09")}.each do |i|
    initiative = parliamentarian.initiatives.build
    ['num_exp', 'title', 'party', 'procedures', 'votings'].each do |a|
      initiative.send("#{a}=", i.send(a))
    end
    initiative.initiative_type=i.type
    initiative.tag_list = i.tags.join(",")
  end
  
  parliamentarian.save!
  puts "#{parliamentarian.orig_id} - #{parliamentarian.full_name} - #{parliamentarian.initiatives.count}"
end

puts "#{Parliamentarian.count} parliamentarians loaded."


puts "Loading Parties"
l.parties.each do |p|
  party = Party.new
  ['group_name', 'acronym', 'sites', 'name', 'url', 'logo'].each do |a|
    party.send("#{a}=", p.send(a))
  end
  party.save!
  
  p.parliamentarians.each do |parla|
    px = Parliamentarian.find_by_orig_id(parla.id)
    if px 
      px.party = party
      px.save!
    end
  end
  
  puts "#{party.name} - #{party.parliamentarians.count}"
end