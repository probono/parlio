class Updater
  
  YEAR = "09"
  
  def self.all
    self.parliamentarians
    self.parties
    self.comissions
    self.interventions
    self.initiatives
    self.topics
  end

  def self.interventions
    puts "Updating interventions..."
    count = 0
    legislature.parliamentarians.each do |remote_p|
      parliamentarian = Parliamentarian.find_by_orig_id(remote_p.id)
      
      remote_p.interventions.select{|int| int.id.start_with?("20#{YEAR}")}.each do |remote_i|
        feedback(count += 1)
        Translator.intervention(remote_i)
      end      
    end
  end
  
  def self.parliamentarians
    puts "Updating parliamentarians..."
    count = 0
    legislature.parliamentarians.each do |remote_p|
      parliamentarian = Translator.parliamentarian(remote_p)  
    end
    puts "Setting parliamentarians substitutions..."
    legislature.parliamentarians.each do |p|
      if p.substitution
        parlio = Parliamentarian.find_by_full_name(p.full_name)
        tmp = Parliamentarian.find_by_full_name(p.substitution)
        parlio.active = p.active?
        if parlio.active? && parlio.substitute.id != tmp.id
          parlio.substitute = tmp
        elsif parlio.substituted_by.id != tmp.id
          parlio.substituted_by = tmp 
        end
        parlio.save
      end
    end    
  end
  
  def self.initiatives
    puts "Updating initiatives..."
    count = 0
    legislature.parliamentarians.each do |remote_p|
      parliamentarian = Parliamentarian.find_by_orig_id(remote_p.id)
      remote_p.initiatives.select{|ini| ini.num_exp.start_with?(YEAR)}.each do |remote_i|
        feedback(count += 1)
        initiative = Translator.initiative(remote_i)
        initiative.parliamentarian = parliamentarian
        initiative.save
      end    
    end
  end
  
  def self.comissions
    puts "Updating comissions..."
    legislature.comissions.each do |remote_c|
      comission = Translator.comission(remote_c)     
    end
  end
  
  def self.parties
    puts "Updating parties..."
    legislature.parties.each do |remote_p|
      party = Translator.party(remote_p)
      #update parliamentarians' parties
      remote_p.parliamentarians.each do |parla|
        px = Parliamentarian.find_by_orig_id(parla.id)
        if px && px.party != party 
          px.party = party
          updated += 1
          px.save!
        end
      end      
    end
  end
    
  def self.topics
    puts "Updating topics..."
    update_topics(legislature.topics, Initiative::OPEN)
    update_topics(legislature.topics_for_closed_initiatives, Initiative::CLOSE)
  end
  
  private
  
    def self.legislature
      @legislature ||= Legebiltzarra::Legislature.new 
    end
    
  
    def self.update_topics(topics, state_for_initiatives)
      count = 0
      topics.each do |remote_t|
        feedback(count += 1)
        Translator.topic(remote_t)
      end
    
      topics.each do |remote_t|
        topic = Topic.find_by_name(remote_t.name)
        remote_t.initiatives.select{|ini| ini.num_exp.start_with?(YEAR)}.each do |remote_i|
          feedback(count += 1)
          init = Translator.initiative(remote_i)
          init.status = state_for_initiatives
          init.topic = topic
          init.save!        
        end      
      end    
    end    
  
    def self.feedback(count)
      if count % 10 == 0
        print "."
        $stdout.flush
      end          
    end  
  
   
end