# == Schema Information
# Schema version: 20090822170451
#
# Table name: commission_members
#
#  id                 :integer         not null, primary key
#  commision_id       :integer
#  parliamentarian_id :integer
#  position           :string(255)
#  date               :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#

class CommissionMember < ActiveRecord::Base
  PRESIDENT     = 1
  VICEPRESIDENT = 2
  SECRETARY     = 3
  VOCAL         = 4
  
  belongs_to :commision
  belongs_to :parliamentarian
end
