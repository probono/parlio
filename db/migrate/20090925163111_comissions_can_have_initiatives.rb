class ComissionsCanHaveInitiatives < ActiveRecord::Migration
  def self.up
    add_column :initiatives, :commission_id, :integer
  end

  def self.down
    remove_column :initiatives, :commission_id
  end
end
