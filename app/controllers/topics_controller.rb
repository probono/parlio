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
    @initiatives = @topic.initiatives.paginate :per_page => 5,  :page => params[:page]
    
    respond_to do |wants|
      wants.html # show.html.erb
      wants.xml  { render :xml => @topic }
    end
  end



  private
    def find_topic
      @topic = Topic.find(params[:id])
    end

end
