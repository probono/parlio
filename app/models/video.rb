class Video < ActiveRecord::Base
  
  belongs_to :intervention
  belongs_to :parliamentarian
  belongs_to :speaker
  
end
