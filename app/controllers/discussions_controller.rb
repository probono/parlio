class DiscussionsController < ApplicationController
  before_filter :find_discussion, :only => [:show, :edit, :update, :destroy]

  # GET /discussions
  # GET /discussions.xml
  def index
    @discussions = Discussion.all

    respond_to do |wants|
      wants.html # index.html.erb
      wants.xml  { render :xml => @discussions }
    end
  end

  # GET /discussions/1
  # GET /discussions/1.xml
  def show
    respond_to do |wants|
      wants.html # show.html.erb
      wants.xml  { render :xml => @discussion }
    end
  end

  # GET /discussions/new
  # GET /discussions/new.xml
  def new
    @discussion = Discussion.new

    respond_to do |wants|
      wants.html # new.html.erb
      wants.xml  { render :xml => @discussion }
    end
  end

  # GET /discussions/1/edit
  def edit
  end

  # POST /discussions
  # POST /discussions.xml
  def create
    @discussion = Discussion.new(params[:discussion])

    respond_to do |wants|
      if @discussion.save
        flash[:notice] = 'Discussion was successfully created.'
        wants.html { redirect_to(@discussion) }
        wants.xml  { render :xml => @discussion, :status => :created, :location => @discussion }
      else
        wants.html { render :action => "new" }
        wants.xml  { render :xml => @discussion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /discussions/1
  # PUT /discussions/1.xml
  def update
    respond_to do |wants|
      if @discussion.update_attributes(params[:discussion])
        flash[:notice] = 'Discussion was successfully updated.'
        wants.html { redirect_to(@discussion) }
        wants.xml  { head :ok }
      else
        wants.html { render :action => "edit" }
        wants.xml  { render :xml => @discussion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /discussions/1
  # DELETE /discussions/1.xml
  def destroy
    @discussion.destroy

    respond_to do |wants|
      wants.html { redirect_to(discussions_url) }
      wants.xml  { head :ok }
    end
  end

  private
    def find_discussion
      @discussion = Discussion.find(params[:id])
    end

end
