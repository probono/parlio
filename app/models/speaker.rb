# == Schema Information
# Schema version: 20090822224716
#
# Table name: speakers
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Speaker < ActiveRecord::Base
  has_many :intervention_speakers
  has_many :interventions, :through => :intervention_speakers
  has_many :initiatives, :order => 'initiative_date desc'
end
