# == Schema Information
# Schema version: 20090823125052
#
# Table name: initiatives
#
#  id                 :integer         not null, primary key
#  num_exp            :string(255)
#  title              :string(255)
#  initiative_type    :string(255)
#  votings            :string(255)
#  parliamentarian_id :integer
#  created_at         :datetime
#  updated_at         :datetime
#  status             :string(255)
#  topic_id           :integer
#  proposer           :string(255)
#  recipient          :string(255)
#  initiative_date    :date
#  session_date       :date
#

class Initiative < ActiveRecord::Base
  OPEN  = "open"
  CLOSE = "close"
  
  seo_urls
  
  acts_as_taggable_on :tags
  belongs_to :parliamentarian
  belongs_to :speaker
  belongs_to :commision  
  belongs_to :topic
  has_many :procedures, :dependent => :destroy
  has_many :announcements, :dependent => :destroy
  
  named_scope :with_parliamentarian, :conditions => ['parliamentarian_id <> ""', nil]

  def self.site_search(query)
    sql = "%#{query}%"
    Initiative.find(:all, :conditions => ["num_exp like ? or title like ? or proposer like ? or recipient like ?", sql, sql, sql, sql])
  end
end
