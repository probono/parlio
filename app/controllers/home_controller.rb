class HomeController < ApplicationController
  meta :title => "Parlio, la política que se entiende - Actualidad en el Parlamento Vasco"
  
  def index      
    @most_active = Topic.most_active
    tuples = Tagging.count(:all, :group => "tag_id", :order => "count(*) DESC", :limit=> 10)
    returning @most_active_tags = [] do
      tuples.each{|tuple| @most_active_tags << Tag.find(tuple[0])}
    end
    @most_active_parliamentarians= Parliamentarian.most_active
    
    @parlio_activity = Intervention.find(:all, :order=>"session_date DESC" , :limit => 3) + Initiative.find(:all, :order=>"initiative_date DESC" , :limit => 3)
    @parlio_activity = @parlio_activity.sort_by { |e| if e.instance_of? Initiative; e.initiative_date; else e.session_date; end }.reverse.first(3)
  end

end
