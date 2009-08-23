class AddDateToProcedure < ActiveRecord::Migration
  
  def self.up
    add_column :procedures, :procedure_date, :date
  end

  def self.down
    remove_column :procedures, :procedure_date
  end
  
end
