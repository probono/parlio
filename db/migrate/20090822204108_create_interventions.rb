class CreateInterventions < ActiveRecord::Migration
  def self.up
    create_table :interventions do |t|
      t.string :file_number
      t.integer :commision_id
      t.string :session_date
      t.string :diary_number
      t.string :subject_number
      t.string :subject_title
      t.string :txt_url
      t.text :full_txt
      t.string :pdf_url
      t.string :videos
      t.integer :initiative_id
      t.string :subject_treated

      t.timestamps
    end
  end

  def self.down
    drop_table :interventions
  end
end
