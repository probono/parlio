puts "Cleaning Commission.."
Commision.destroy_all

l = Legebiltzarra::Legislature.new 

puts "\nLoading Commissions..."
l.comissions.each do |c|
  commission = Commision.new
  ['name'].each do |a|
    commission.send("#{a}=", c.send(a))
  end
  commission.save!
  puts "#{commission.name}"
  
#  p.parliamentarians.each do |parla|
#    px = Parliamentarian.find_by_orig_id(parla.id)
#    if px 
#      px.party = party
#      px.save!
#    end
#  end
  
end

puts "#{Commision.count} commission loaded."
