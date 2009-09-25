class TopicsController < ApplicationController
  before_filter :find_topic, :only => [:show, :edit, :update, :destroy]

  # GET /topics
  # GET /topics.xml
  def index
    @topics = Topic.all

    respond_to do |wants|
      wants.html # index.html.erb
      wants.xml  { render :xml => @topics }
    end
  end

  # GET /topics/1
  # GET /topics/1.xml
  def show                   
    meta :title => "Parlio - Iniciativas relacionadas con #{@topic.name}"
    @initiatives = @topic.initiatives.paginate :per_page => 5,  :page => params[:page]
    @tags = @topic.initiatives.map{|i| i.tags}.flatten.uniq
    @most_active_parliamentarians = @topic.most_active_parliamentarians
    
    respond_to do |wants|
      wants.html # show.html.erb
      wants.xml  { render :xml => @topic }
      wants.atom { render(:layout => false) }
    end
  end



  private
    def find_topic
      @topic = Topic.find(params[:id])
    end

end
