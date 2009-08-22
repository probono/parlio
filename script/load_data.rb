puts "Cleaning DB..."
Parliamentarian.destroy_all
Initiative.destroy_all

l = Legebiltzarra::Legislature.new 

puts "Loading Parliamentarians..."
l.parliamentarians.each do |p|
  parliamentarian = Parliamentarian.new
  ['id', 'full_name', 'photo', 'profession', 'languages', 'email', 'posts'].each do |a|
    parliamentarian.send("#{a}=", p.send(a))
  end
  
  p.initiatives.select{|ini| ini.num_exp.start_with?("09")}.each do |i|
    initiative = parliamentarian.initiatives.build
    puts i.num_exp
    ['num_exp', 'title', 'party', 'tags', 'procedures', 'votings'].each do |a|
      initiative.send("#{a}=", i.send(a))
    end
    initiative.initiative_type=i.type
  end
  
  parliamentarian.save!
  puts "#{parliamentarian.id} - #{parliamentarian.full_name} - #{parliamentarian.initiatives.count}"
end

puts "\n#{Parliamentarian.count} parliamentarians loaded."
puts "\n#{Initiative.count} initiatives loaded."

