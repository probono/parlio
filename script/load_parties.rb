puts "Cleaning party..."
Party.destroy_all

puts "Loading Parties..."
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

puts "#{Partie.count} parties loaded."