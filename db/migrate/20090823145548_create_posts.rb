class CreatePosts < ActiveRecord::Migration
  def self.up
    remove_column :parliamentarians, :posts
    
    create_table :posts do |t|
      t.string :title
      t.integer :parliamentarian_id

      t.timestamps
    end
  end

  def self.down
    drop_table :posts
    
    add_column :parliamentarians, :posts, :string
  end
end
