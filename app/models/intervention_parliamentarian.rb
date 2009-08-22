class InterventionParliamentarian < ActiveRecord::Base
  belongs_to :intervention
  belongs_to :parliamentarian
end
