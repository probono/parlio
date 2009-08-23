# == Schema Information
# Schema version: 20090823153255
#
# Table name: procedures
#
#  id             :integer         not null, primary key
#  initiative_id  :integer
#  title          :string(255)
#  url            :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  procedure_date :date
#

class Procedure < ActiveRecord::Base
  
  belongs_to :initiative
    
end
