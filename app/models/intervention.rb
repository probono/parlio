# == Schema Information
# Schema version: 20090823125052
#
# Table name: interventions
#
#  id              :integer         not null, primary key
#  file_number     :string(255)
#  commision_id    :integer
#  diary_number    :string(255)
#  subject_number  :string(255)
#  subject_title   :string(255)
#  txt_url         :string(255)
#  full_txt        :text
#  pdf_url         :string(255)
#  videos          :string(255)
#  initiative_id   :integer
#  subject_treated :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  session_date    :date
#

class Intervention < ActiveRecord::Base
  belongs_to :initiative
  belongs_to :commision
  
  has_many :intervention_parliamentarians
  has_many :parliamentarians, :through => :intervention_parliamentarians
  
  has_many :intervention_speakers
  has_many :speakers, :through => :intervention_speakers
  
#  has_many :procedures, :order => 'name asc'
  has_many :videos, :dependent => :destroy
  
  named_scope :by_session_date, lambda { |d|
        { :conditions => { :session_date => d } }
  }
  
  def self.site_search(query)
    sql = "%#{query}%"
    Intervention.find(:all, :conditions => ["file_number like ? or subject_title like ? or full_txt like ? or subject_treated like ?", sql, sql, sql, sql])
  end  
  
end
