# == Schema Information
# Schema version: 20090822105833
#
# Table name: initiatives
#
#  id                 :integer         not null, primary key
#  num_exp            :string(255)
#  title              :string(255)
#  party              :string(255)
#  type               :string(255)
#  tags               :string(255)
#  procedures         :string(255)
#  votings            :string(255)
#  parliamentarian_id :integer
#  created_at         :datetime
#  updated_at         :datetime
#

class Initiative < ActiveRecord::Base
  belongs_to :parliamentarian
end
