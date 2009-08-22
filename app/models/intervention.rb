class Intervention < ActiveRecord::Base
  belongs_to :initiative
  belongs_to :commision
  
  has_many :intervention_parliamentarians
  has_many :parliamentarians, :through => :intervention_parliamentarians
  
  has_many :intervention_speakers
  has_many :speakers, :through => :intervention_speakers
end
