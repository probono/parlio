# == Schema Information
# Schema version: 20090822155637
#
# Table name: parties
#
#  id         :integer         not null, primary key
#  group_name :string(255)
#  acronym    :string(255)
#  sites      :string(255)
#  name       :string(255)
#  url        :string(255)
#  logo       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Party < ActiveRecord::Base
  seo_urls :party_acronym
  has_many :parliamentarians  
  
  def initiatives
    self.parliamentarians.collect{|p| p.initiatives}.flatten.uniq
  end
  
  def interventions
    self.parliamentarians.collect{|p| p.interventions}.flatten.uniq
  end
  
  def self.most_active
    tuples = Initiative.count(:all, :group => "party_id", :include => [:parliamentarian], :order => "count(*) DESC")
    returning most_active = [] do
      tuples.each{|tuple| most_active << [Party.find(tuple[0]), tuple[1]]}
    end
  end
  
  def more_active_parlamentarians
    Party.most_active_all_parlamentarians.select{|p| p.party==self}.first(3)
  end
  
  def party_acronym
    /\((.*)\)/.match(self.name)[1]  rescue nil
  end
  
  
  private
  def self.most_active_all_parlamentarians
    tuples = Initiative.count(:all, :group => "parliamentarian_id", :order => "count(*) DESC")
    returning most_active = [] do
      tuples.each{|tuple| most_active << Parliamentarian.find(tuple[0])}
    end    
  end
  
end
