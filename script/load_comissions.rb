puts "Cleaning commissions..."
Commision.destroy_all

l = Legebiltzarra::Legislature.new 

puts "Loading Commissions..."
l.comissions.each do |c|
  commission = Commision.new
  ['name'].each do |a|
    commission.send("#{a}=", c.send(a))
  end
  commission.save!
  puts "#{commission.name}"
  
  parl = Parliamentarian.find_by_orig_id(c.president.id)
  CommissionMember.create(:commision_id => commission.id, :parliamentarian_id => parl.id, :position => CommissionMember::PRESIDENT, :date => c.president.date)
  
  parl = Parliamentarian.find_by_orig_id(c.vicepresident.id)
  CommissionMember.create(:commision_id => commission.id, :parliamentarian_id => parl.id, :position => CommissionMember::VICEPRESIDENT, :date => c.president.date)
  
  parl = Parliamentarian.find_by_orig_id(c.secretary.id)
  CommissionMember.create(:commision_id => commission.id, :parliamentarian_id => parl.id, :position => CommissionMember::SECRETARY, :date => c.president.date)
  
  c.vocals.each do |p|
    parl = Parliamentarian.find_by_orig_id(p.id)
    CommissionMember.create(:commision_id => commission.id, :parliamentarian_id => parl.id, :position => CommissionMember::VOCAL, :date => c.president.date)
  end
  
end

puts "#{Commision.count} commission loaded."
