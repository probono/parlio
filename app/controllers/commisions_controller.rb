class CommisionsController < ApplicationController
  before_filter :find_commision, :only => [:show, :edit, :update, :destroy]

  # GET /commisions
  # GET /commisions.xml
  def index
    @commisions = Commision.all

    respond_to do |wants|
      wants.html # index.html.erb
      wants.xml  { render :xml => @commisions }
    end
  end

  # GET /commisions/1
  # GET /commisions/1.xml
  def show
    respond_to do |wants|
      wants.html # show.html.erb
      wants.xml  { render :xml => @commision }
    end
  end

  # GET /commisions/new
  # GET /commisions/new.xml
  def new
    @commision = Commision.new

    respond_to do |wants|
      wants.html # new.html.erb
      wants.xml  { render :xml => @commision }
    end
  end

  # GET /commisions/1/edit
  def edit
  end

  # POST /commisions
  # POST /commisions.xml
  def create
    @commision = Commision.new(params[:commision])

    respond_to do |wants|
      if @commision.save
        flash[:notice] = 'Commision was successfully created.'
        wants.html { redirect_to(@commision) }
        wants.xml  { render :xml => @commision, :status => :created, :location => @commision }
      else
        wants.html { render :action => "new" }
        wants.xml  { render :xml => @commision.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /commisions/1
  # PUT /commisions/1.xml
  def update
    respond_to do |wants|
      if @commision.update_attributes(params[:commision])
        flash[:notice] = 'Commision was successfully updated.'
        wants.html { redirect_to(@commision) }
        wants.xml  { head :ok }
      else
        wants.html { render :action => "edit" }
        wants.xml  { render :xml => @commision.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /commisions/1
  # DELETE /commisions/1.xml
  def destroy
    @commision.destroy

    respond_to do |wants|
      wants.html { redirect_to(commisions_url) }
      wants.xml  { head :ok }
    end
  end

  private
    def find_commision
      @commision = Commision.find(params[:id])
    end

end
