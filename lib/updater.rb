class Updater
  
  def self.all
    self.topics
  end
  
  def self.topics
    puts "Updating topics..."
    l = Legebiltzarra::Legislature.new 
    update_topics(l.topics, Initiative::OPEN)
    update_topics(l.topics_for_closed_initiatives, Initiative::CLOSE)
  end
  
  private
  
    def self.update_topics(topics, state_for_initiatives)
      count = 0
      topics.each do |remote_t|
        feedback(count += 1)
        Translator.topic(remote_t)
      end
    
      topics.each do |remote_t|
        topic = Topic.find_by_name(remote_t.name)
        remote_t.initiatives.select{|ini| ini.num_exp.start_with?("09")}.each do |remote_i|
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