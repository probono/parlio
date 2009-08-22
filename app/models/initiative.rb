# == Schema Information
# Schema version: 20090822155637
#
# Table name: initiatives
#
#  id                 :integer         not null, primary key
#  num_exp            :string(255)
#  title              :string(255)
#  party              :string(255)
#  initiative_type    :string(255)
#  procedures         :string(255)
#  votings            :string(255)
#  parliamentarian_id :integer
#  created_at         :datetime
#  updated_at         :datetime
#

class Initiative < ActiveRecord::Base
  seo_urls
  
  acts_as_taggable_on :tags
  belongs_to :parliamentarian
end
