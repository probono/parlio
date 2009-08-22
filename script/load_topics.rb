puts "Cleaning topics.."
Topic.destroy_all

l = Legebiltzarra::Legislature.new 

puts "\nLoading topics..."
l.topics.each do |t|
  topic = Topic.new
  ['name'].each do |a|
    topic.send("#{a}=", t.send(a))
  end
  topic.save!
  puts "#{topic.name}"
  
end

puts "#{Topic.count} topics loaded."
