class CreateVideos < ActiveRecord::Migration
  def self.up
    create_table :videos do |t|
      t.integer :parliamentarian_id
      t.integer :speaker_id
      t.string :title
      t.string :video_url
      t.string :duration

      t.timestamps
    end
  end

  def self.down
    drop_table :videos
  end
end
