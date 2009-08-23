class AddDegreeToParliamentarian < ActiveRecord::Migration
  def self.up
    add_column :parliamentarians, :degree, :string
  end

  def self.down
    remove_column :parliamentarians, :degree
  end
end
