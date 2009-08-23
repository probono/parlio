# == Schema Information
# Schema version: 20090823151303
#
# Table name: parliamentarians
#
#  id                :integer         not null, primary key
#  full_name         :string(255)
#  photo             :string(255)
#  profession        :string(255)
#  languages         :string(255)
#  email             :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#  orig_id           :string(255)
#  party_id          :integer
#  active            :boolean
#  substitution_id   :integer
#  substitutes_id    :integer
#  substituted_by_id :integer
#  degree            :string(255)
#

class Parliamentarian < ActiveRecord::Base
  seo_urls "full_name"
  
  has_many :initiatives, :dependent => :destroy
  has_many :posts, :dependent => :destroy  
  
  has_many :commission_members
  has_many :commissions, :through => :commission_members, :source => :commision
  
  has_many :intervention_parliamentarians
  has_many :interventions, :through => :intervention_parliamentarians
  
  has_one  :substitute, :class_name => 'Parliamentarian', :foreign_key => :substitutes_id
  has_one  :substituted_by, :class_name => 'Parliamentarian', :foreign_key => :substituted_by_id

  belongs_to :party
  
  named_scope :active,   :conditions => ['active = ?', true]
  named_scope :unactive, :conditions => ['active = ?', false]
  
  def first_name
    self.full_name.split(',').last.strip
  end

  def last_name
    self.full_name.split(',').first.strip
  end  
  
  def active?
    self.active
  end
    
  def self.most_active
    tuples = Initiative.count(:all, :group => "parliamentarian_id", :order => "count(*) DESC", :limit => 5)
    returning most_active = [] do
      tuples.each{|tuple| most_active << Parliamentarian.find(tuple[0])}
    end    
  end
  
  def self.site_search(query)
    sql = "%#{query}%"
    Parliamentarian.find(:all, :conditions => ["full_name like ? or profession like ?", sql, sql])
  end  
end
