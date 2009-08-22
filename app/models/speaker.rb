class Speaker < ActiveRecord::Base
  has_many :intervention_speakers
  has_many :interventions, :through => :intervention_speakers
end
