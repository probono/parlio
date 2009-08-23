# == Schema Information
# Schema version: 20090823125052
#
# Table name: procedures
#
#  id            :integer         not null, primary key
#  initiative_id :integer
#  title         :string(255)
#  url           :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

class Procedure < ActiveRecord::Base
  
  belongs_to :initiative
  
  def procedure_date
    value = self.title[0, self.title.index('/')]
    Date.strptime(value, "%d.%m.%Y")
  end

  def name
    self.title[self.title.index('/') + 1, self.title.size - 1]
  end
    
end
