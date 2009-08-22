# == Schema Information
# Schema version: 20090822123030
#
# Table name: parliamentarians
#
#  id         :integer         not null, primary key
#  full_name  :string(255)
#  photo      :string(255)
#  profession :string(255)
#  languages  :string(255)
#  email      :string(255)
#  posts      :string(255)
#  created_at :datetime
#  updated_at :datetime
#  orig_id    :string(255)
#

class Parliamentarian < ActiveRecord::Base
  
  has_many :initiatives, :dependent => :destroy
  has_many :interventions, :dependent => :destroy
  
  def first_name
    self.full_name.split(',').last.strip
  end

  def last_name
    self.full_name.split(',').first.strip
  end
end
