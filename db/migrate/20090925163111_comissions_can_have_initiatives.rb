class ComissionsCanHaveInitiatives < ActiveRecord::Migration
  def self.up
    add_column :initiatives, :commision_id, :integer
  end

  def self.down
    remove_column :initiatives, :commision_id
  end
end
