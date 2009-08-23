class DropProceduresFieldFromInitiative < ActiveRecord::Migration
  def self.up
    remove_column :initiatives, :procedures
  end

  def self.down
    add_column :initiatives, :procedures, :string
  end
end
