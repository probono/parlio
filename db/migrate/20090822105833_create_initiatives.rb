class CreateInitiatives < ActiveRecord::Migration
  def self.up
    create_table :initiatives do |t|
      t.string :num_exp
      t.string :title
      t.string :party
      t.string :initiative_type
      t.string :tags
      t.string :procedures
      t.string :votings
      t.integer :parliamentarian_id

      t.timestamps
    end
  end

  def self.down
    drop_table :initiatives
  end
end
