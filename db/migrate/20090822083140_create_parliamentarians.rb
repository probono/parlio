class CreateParliamentarians < ActiveRecord::Migration
  def self.up
    create_table :parliamentarians do |t|
      t.string :full_name
      t.string :photo
      t.string :profession
      t.string :languages
      t.string :email
      t.string :posts

      t.timestamps
    end
  end

  def self.down
    drop_table :parliamentarians
  end
end
