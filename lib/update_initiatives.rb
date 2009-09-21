class UpdateInitiatives
  
  def self.update
    puts "Updating initiatives..."

    l = Legebiltzarra::Legislature.new 
    parliamentarians = l.parliamentarians
    
    updated = 0
    created = 0
    count = 0
    
    parliamentarians.each do |remote_p|
      parliamentarian = Parliamentarian.find_by_orig_id(remote_p.id)

      remote_p.initiatives.select{|ini| ini.num_exp.start_with?("09")}.each do |remote_i|
        feedback(count += 1)
        initiative = Translator.initiative(remote_i)
        initiative.parliamentarian = parliamentarian
        initiative.save
      end
    end
    puts "\n#{updated} initiatives updated. #{created} new initiatives created.\n"
  end
  
  def self.feedback(count)
    if count % 10 == 0
      print "."
      $stdout.flush
    end          
  end  
  
  def self.print_values(local, remote)
    puts "+++++++++++++++++++++++++++++++++++++++++++++++++"
    puts "#{local.num_exp} vs #{remote.num_exp} : #{local.num_exp != remote.num_exp}"
    puts "#{local.title} vs #{remote.title} : #{local.title != remote.title}"
    puts "#{local.votings} vs _#{remote.votings.to_s} : #{local.votings != remote.votings.to_s}"
    puts "#{local.proposer} vs #{remote.proposer} : #{local.proposer != remote.proposer}"
    puts "#{local.recipient} vs #{remote.recipient} : #{local.recipient != remote.recipient}"
    puts "#{local.initiative_date} vs #{remote.initiative_date} : #{local.initiative_date != remote.initiative_date}"
    puts "#{local.initiative_type} vs #{remote.type} : #{local.initiative_type != remote.type}"
    puts "#{local.tag_list} vs #{remote.tags.join(', ')} : #{local.tag_list.to_s != remote.tags.join(', ')}"
    puts "+++++++++++++++++++++++++++++++++++++++++++++++++"
  end

 
end