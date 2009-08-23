class FixCreatedAtForOrdering < ActiveRecord::Migration
  def self.up
    Initiative.all.each do |i|
      i.created_at = i.initiative_date
      i.save
    end    
    Intervention.all.each do |i|
      i.created_at = i.session_date
      i.save
    end
  end

  def self.down
  end
end
