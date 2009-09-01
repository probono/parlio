class UpdateParliamentarians
  
  def self.update
    puts "Updating parliamentarians..."

    l = Legebiltzarra::Legislature.new 
    parliamentarians = l.parliamentarians
    
    updated = 0
    created = 0
    parliamentarians.each do |p|
      local = Parliamentarian.find_by_orig_id(p.orig_id)
      if local && changed?(local, p)
        ['full_name', 'photo', 'profession', 'languages', 'email', 'degree'].each do |a|
          local.send("#{a}=", p.send(a))
        end
        p.posts.destroy_all
        p.posts.each{|po| local.posts.build(:title => po) } 
        updated += 1
      elsif !local
        local = Parliamentarian.new(:active => true)
        ['orig_id', 'full_name', 'photo', 'profession', 'languages', 'email', 'degree'].each do |a|
          local.send("#{a}=", p.send(a))
        end
        p.posts.each{|po| local.posts.build(:title => po) }
        created += 1
      end
      local.save!
    end

    puts "#{updated} parliamentarians updated. #{created} new parliamentarias created.\n"

    puts "Setting substitutions..."
    replaced = 0
    parliamentarians.each do |p|

      if p.substitution
        parlio = Parliamentarian.find_by_full_name(p.full_name)
        tmp = Parliamentarian.find_by_full_name(p.substitution)
        parlio.active = p.active?
        if parlio.active? && parlio.substitute.id != tmp.id
          parlio.substitute = tmp
        elsif parlio.substituted_by.id != tmp.id
          parlio.substituted_by = tmp 
          replaced += 1
        end
        parlio.save
      end
    end

    puts "#{replaced} parliamentarians substituded.\n"
    
  end

  def self.changed?(local, remote)
    return local.full_name != remote.full_name || local.photo != remote.photo ||
           local.profession != remote.profession || local.languages != remote.languages ||
           local.email != remote.email || local.degree != remote.degree
  end  
end