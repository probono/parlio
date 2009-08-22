puts "Cleaning topics..."
Topic.destroy_all

l = Legebiltzarra::Legislature.new 

puts "Loading topics..."
l.topics.each do |t|
  topic = Topic.new
  ['name'].each do |a|
    topic.send("#{a}=", t.send(a))
  end
  topic.save!
  
  t.initiatives.each do |i|
    init = Initiative.find_by_num_exp(i.id)
    if init
      init.status = Initiative::OPEN
      init.topic = topic
      init.save!
    end
  end

  puts "#{topic.name}"  
end

puts "\nClosing initiatives..."
l.topics_for_closed_initiatives.each do |t|
  topic = Topic.find_by_name(t.name)
  puts "#{topic.name}"  
  t.initiatives.each do |i|
    init = Initiative.find_by_num_exp(i.id)
    if init
      init.status = Initiative::CLOSE
      init.topic = topic
      init.save!
    end
  end
end

puts "#{Topic.count} topics loaded."
