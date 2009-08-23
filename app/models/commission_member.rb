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
  
  POSITIONS = ['Presidente/a', 'Vicepresidente/a', 'Secretario/a', 'Vocal']
  
  belongs_to :commision
  belongs_to :parliamentarian
  
  def position2text
    POSITIONS[(self.position.to_i - 1)]
  end
end
