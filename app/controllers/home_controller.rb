class HomeController < ApplicationController
  def index      
    @most_active = Topic.most_active
    tuples = Tagging.count(:all, :group => "tag_id", :order => "count(*) DESC", :limit=> 10)
    returning @most_active_tags = [] do
      tuples.each{|tuple| @most_active_tags << Tag.find(tuple[0])}
    end
    @most_active_parliamentarians= Parliamentarian.most_active
  end

end
