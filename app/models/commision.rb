# == Schema Information
# Schema version: 20090822155637
#
# Table name: commisions
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Commision < ActiveRecord::Base
  seo_urls
  
  has_many :commission_members
  has_many :members, :through => :commission_members, :source => :parliamentarian
  
end
