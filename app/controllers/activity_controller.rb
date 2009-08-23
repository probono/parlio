class ActivityController < ApplicationController   
  def index
    @topics = Topic.all
    @most_active = Topic.most_active
    tuples = Tagging.count(:all, :group => "tag_id", :order => "count(*) DESC", :limit=> 10)
    returning @most_active_tags = [] do
      tuples.each{|tuple| @most_active_tags << Tag.find(tuple[0])}
    end       
    @most_active_parties= Party.most_active
    @most_active_parliamentarians= Parliamentarian.most_active
    @most_recent_initiatives = Initiative.find(:all, :limit => 3) 
  end
end
