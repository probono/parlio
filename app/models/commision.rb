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
  
  has_many :interventions, :order => 'session_date desc'
  has_many :initiatives, :order => 'initiative_date desc'
  
  
  has_many :commission_members_as_president, :class_name => "CommissionMember", :conditions => ["commission_members.position = ?", CommissionMember::PRESIDENT]
  has_many :members_as_president, :through => :commission_members_as_president, :source => :parliamentarian
  
  has_many :commission_members_as_vicepresident, :class_name => "CommissionMember", :conditions => ["commission_members.position = ?", CommissionMember::VICEPRESIDENT]
  has_many :members_as_vicepresident, :through => :commission_members_as_vicepresident, :source => :parliamentarian
  
  has_many :commission_members_as_secretary, :class_name => "CommissionMember", :conditions => ["commission_members.position = ?", CommissionMember::SECRETARY]
  has_many :members_as_secretary, :through => :commission_members_as_secretary, :source => :parliamentarian
  
  has_many :commission_members_as_vocal, :class_name => "CommissionMember", :conditions => ["commission_members.position = ?", CommissionMember::VOCAL]
  has_many :members_as_vocal, :through => :commission_members_as_vocal, :source => :parliamentarian
  
end
