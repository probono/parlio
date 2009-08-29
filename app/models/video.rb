# == Schema Information
# Schema version: 20090823212248
#
# Table name: videos
#
#  id                 :integer         not null, primary key
#  parliamentarian_id :integer
#  speaker_id         :integer
#  title              :string(255)
#  video_url          :string(255)
#  duration           :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  intervention_id    :integer
#

class Video < ActiveRecord::Base
  
  belongs_to :intervention
  belongs_to :parliamentarian
  belongs_to :speaker
  
  
  def vote?
    self.title.index("Votación") != nil
  end
end
