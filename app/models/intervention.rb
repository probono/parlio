# == Schema Information
# Schema version: 20090822224716
#
# Table name: interventions
#
#  id              :integer         not null, primary key
#  file_number     :string(255)
#  commision_id    :integer
#  session_date    :string(255)
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
#

class Intervention < ActiveRecord::Base
  belongs_to :initiative
  belongs_to :commision
  
  has_many :intervention_parliamentarians
  has_many :parliamentarians, :through => :intervention_parliamentarians
  
  has_many :intervention_speakers
  has_many :speakers, :through => :intervention_speakers
  
  has_many :procedures, :order => 'name asc'
end
