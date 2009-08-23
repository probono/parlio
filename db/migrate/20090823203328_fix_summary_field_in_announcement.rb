class FixSummaryFieldInAnnouncement < ActiveRecord::Migration
  def self.up
    change_column :announcements, :summary, :string
  end

  def self.down
  end
end
