# == Schema Information
# Schema version: 20090823151303
#
# Table name: posts
#
#  id                 :integer         not null, primary key
#  title              :string(255)
#  parliamentarian_id :integer
#  created_at         :datetime
#  updated_at         :datetime
#

class Post < ActiveRecord::Base
  belongs_to :parliamentarian
end
