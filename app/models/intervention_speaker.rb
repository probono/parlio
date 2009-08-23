# == Schema Information
# Schema version: 20090822224716
#
# Table name: intervention_speakers
#
#  id              :integer         not null, primary key
#  intervention_id :integer
#  speaker_id      :integer
#  created_at      :datetime
#  updated_at      :datetime
#

class InterventionSpeaker < ActiveRecord::Base
  belongs_to :intervention
  belongs_to :speaker
end
