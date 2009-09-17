class UpdateParties
  
  def self.update
    puts "Updating parties..."

    l = Legebiltzarra::Legislature.new 
    parties = l.parties
    
    updated = 0
    created = 0
    count = 0
    
    parties.each do |remote_p|
      party = Party.find_by_acronym(remote_p.acronym)

      if !party

        party = Party.new
        ['group_name', 'acronym', 'sites', 'name', 'url', 'logo'].each do |a|
          party.send("#{a}=", remote_p.send(a))
        end
        party.url = p.url
        party.save!    
        created += 1
      end
      
      remote_p.parliamentarians.each do |parla|
        px = Parliamentarian.find_by_orig_id(parla.id)
        if px && px.party != party 
          px.party = party
          updated += 1
          px.save!
        end
      end      

    end
    puts "\n#{updated} parliamentarians updated. #{created} new parties created.\n"
  end
  
  def self.feedback(count)
    if count % 10 == 0
      print "."
      $stdout.flush
    end          
  end  
   
end