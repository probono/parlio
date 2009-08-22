# == Schema Information
# Schema version: 20090822155637
#
# Table name: topics
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Topic < ActiveRecord::Base
  seo_urls
end
