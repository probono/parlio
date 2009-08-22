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
  
  has_many :initiatives
  
  def self.most_active
    tuples = Initiative.count(:all, :group => "topic_id", :order => "count(*) DESC", :limit=> 6)
    returning ta = [] do
      tuples.each{|tuple| ta << Topic.find(tuple[0]) if tuple[0]}
    end
  end      
  
end
