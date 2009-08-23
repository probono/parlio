# == Schema Information
# Schema version: 20090823180900
#
# Table name: announcements
#
#  id                :integer         not null, primary key
#  announcement_url  :string(255)
#  initiative_id     :integer
#  summary           :integer
#  announcement_date :date
#  num_exp           :integer
#  number            :integer
#  page              :integer
#  created_at        :datetime
#  updated_at        :datetime
#

class Announcement < ActiveRecord::Base
  
  belongs_to :initiative
  
end
