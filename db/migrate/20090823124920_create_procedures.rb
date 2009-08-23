class CreateProcedures < ActiveRecord::Migration
  def self.up
    create_table :procedures do |t|
      t.integer :initiative_id
      t.string :title
      t.string :url
      t.timestamps
    end
  end

  def self.down
    drop_table :procedures
  end
end
