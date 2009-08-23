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
