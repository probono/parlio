class UpdateComissions
  
  def self.update
    puts "Updating comissions..."

    l = Legebiltzarra::Legislature.new 
    comissions = l.comissions
    
    updated = 0
    created = 0
    count = 0
    
    comissions.each do |remote_c|
      commission = Commision.find_by_name(remote_c.name)

      if commission
        commission.members.delete_all
      else
        commission = Commision.new
        ['name'].each do |a|
          commission.send("#{a}=", c.send(a))
        end      
        created += 1
        commission.save! 
      end
      
      create_member(commission, remote_c.president.id, CommissionMember::PRESIDENT, remote_c.president.date)
      create_member(commission, remote_c.vicepresident.id, CommissionMember::VICEPRESIDENT, remote_c.vicepresident.date)
      create_member(commission, remote_c.secretary.id, CommissionMember::SECRETARY, remote_c.secretary.date)

      remote_c.vocals.each do |p|
        create_member(commission, p.id, CommissionMember::VOCAL, p.date)
      end
    end
    puts "\n#{updated} comissions updated. #{created} new comissions created.\n"
  end
  
  def self.create_member(commission, parlamentarian_id, role, date)
    parl = Parliamentarian.find_by_orig_id(parlamentarian_id)
    CommissionMember.create(:commision_id => commission.id, 
                            :parliamentarian_id => parl.id, 
                            :position => role, :date => date)
  end
  
  def self.feedback(count)
    if count % 10 == 0
      print "."
      $stdout.flush
    end          
  end  
   
end