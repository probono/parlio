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
    respond_to do |wants|
      wants.html # show.html.erb
      wants.xml  { render :xml => @topic }
    end
  end

  # GET /topics/new
  # GET /topics/new.xml
  def new
    @topic = Topic.new

    respond_to do |wants|
      wants.html # new.html.erb
      wants.xml  { render :xml => @topic }
    end
  end

  # GET /topics/1/edit
  def edit
  end

  # POST /topics
  # POST /topics.xml
  def create
    @topic = Topic.new(params[:topic])

    respond_to do |wants|
      if @topic.save
        flash[:notice] = 'Topic was successfully created.'
        wants.html { redirect_to(@topic) }
        wants.xml  { render :xml => @topic, :status => :created, :location => @topic }
      else
        wants.html { render :action => "new" }
        wants.xml  { render :xml => @topic.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /topics/1
  # PUT /topics/1.xml
  def update
    respond_to do |wants|
      if @topic.update_attributes(params[:topic])
        flash[:notice] = 'Topic was successfully updated.'
        wants.html { redirect_to(@topic) }
        wants.xml  { head :ok }
      else
        wants.html { render :action => "edit" }
        wants.xml  { render :xml => @topic.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.xml
  def destroy
    @topic.destroy

    respond_to do |wants|
      wants.html { redirect_to(topics_url) }
      wants.xml  { head :ok }
    end
  end

  private
    def find_topic
      @topic = Topic.find(params[:id])
    end

end
