class FixingFieldsFromInitiative < ActiveRecord::Migration

  def self.up
    remove_column :initiatives, :party
    add_column :initiatives, :proposer, :string
    add_column :initiatives, :recipient, :string
    add_column :initiatives, :initiative_date, :date
  end

  def self.down
    add_column :initiatives, :party, :string
    remove_column :initiatives, :proposer
    remove_column :initiatives, :recipient
    remove_column :initiatives, :initiative_date
  end

end
