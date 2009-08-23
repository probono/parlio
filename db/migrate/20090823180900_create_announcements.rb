class CreateAnnouncements < ActiveRecord::Migration
  def self.up
    create_table :announcements do |t|
      t.string :announcement_url
      t.integer :initiative_id
      t.integer :summary
      t.date :announcement_date
      t.integer :num_exp
      t.integer :number
      t.integer :page

      t.timestamps
    end
  end

  def self.down
    drop_table :announcements
  end
end
