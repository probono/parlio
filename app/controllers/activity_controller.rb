class ActivityController < ApplicationController   
  def index
    @ins = Initiative.all
    @topics = @ins.map{|i| i.type}.uniq
    @tags = @ins.map{|i| i.tags}.uniq
  end
end
