class InterventionSpeaker < ActiveRecord::Base
  belongs_to :intervention
  belongs_to :speaker
end
