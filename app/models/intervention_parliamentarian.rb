# == Schema Information
# Schema version: 20090822224716
#
# Table name: intervention_parliamentarians
#
#  id                 :integer         not null, primary key
#  intervention_id    :integer
#  parliamentarian_id :integer
#  created_at         :datetime
#  updated_at         :datetime
#

class InterventionParliamentarian < ActiveRecord::Base
  belongs_to :intervention
  belongs_to :parliamentarian
end
