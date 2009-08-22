# == Schema Information
# Schema version: 20090822155637
#
# Table name: parliamentarians
#
#  id         :integer         not null, primary key
#  full_name  :string(255)
#  photo      :string(255)
#  profession :string(255)
#  languages  :string(255)
#  email      :string(255)
#  posts      :string(255)
#  created_at :datetime
#  updated_at :datetime
#  orig_id    :string(255)
#  party_id   :integer
#

class Parliamentarian < ActiveRecord::Base
  seo_urls "full_name"
  
  has_many :initiatives, :dependent => :destroy
  has_many :commission_members
  has_many :commissions, :through => :commission_members, :source => :commision
  
  belongs_to :party
  
  def first_name
    self.full_name.split(',').last.strip
  end

  def last_name
    self.full_name.split(',').first.strip
  end
end
