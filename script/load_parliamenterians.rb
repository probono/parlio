puts "Cleaning parliamentarians..."
Parliamentarian.destroy_all

l = Legebiltzarra::Legislature.new 
parliamentarians = l.parliamentarians
puts "Loading parliamentarians..."
parliamentarians.each do |p|
  parliamentarian = Parliamentarian.new(:active => true)
  ['orig_id', 'full_name', 'photo', 'profession', 'languages', 'email', 'degree'].each do |a|
    parliamentarian.send("#{a}=", p.send(a))
  end
  
  p.posts.each{|po| parliamentarian.posts.build(:title => po) }
  
  parliamentarian.save!
  
  puts "#{parliamentarian.orig_id} - #{parliamentarian.full_name}"
end

puts "#{Parliamentarian.count} parliamentarians loaded.\n"

puts "Setting substitutions..."
parliamentarians.each do |p|
  
  if p.substitution
    parlio = Parliamentarian.find_by_full_name(p.full_name)
    
    tmp = Parliamentarian.find_by_full_name(p.substitution)
    parlio.active = p.active?
    if parlio.active?
      parlio.substitute = tmp
      puts "#{parlio.full_name} sustituye a #{parlio.substitute.full_name}" 
    else
      parlio.substituted_by = tmp
      puts "#{parlio.full_name} sustituido por #{parlio.substituted_by.full_name}" 
    end
    parlio.save!
  end
end

puts "#{Parliamentarian.unactive.count} parliamentarians substituded.\n"