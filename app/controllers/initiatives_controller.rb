class InitiativesController < ApplicationController
  before_filter :find_initiative, :only => [:show, :edit, :update, :destroy]

  # GET /initiatives
  # GET /initiatives.xml
  def index
    @initiatives = Initiative.all

    respond_to do |wants|
      wants.html # index.html.erb
      wants.xml  { render :xml => @initiatives }
    end
  end

  # GET /initiatives/1
  # GET /initiatives/1.xml
  def show
    respond_to do |wants|
      wants.html # show.html.erb
      wants.xml  { render :xml => @initiative }
    end
  end

  # GET /initiatives/new
  # GET /initiatives/new.xml
  def new
    @initiative = Initiative.new

    respond_to do |wants|
      wants.html # new.html.erb
      wants.xml  { render :xml => @initiative }
    end
  end

  # GET /initiatives/1/edit
  def edit
  end

  # POST /initiatives
  # POST /initiatives.xml
  def create
    @initiative = Initiative.new(params[:initiative])

    respond_to do |wants|
      if @initiative.save
        flash[:notice] = 'Initiative was successfully created.'
        wants.html { redirect_to(@initiative) }
        wants.xml  { render :xml => @initiative, :status => :created, :location => @initiative }
      else
        wants.html { render :action => "new" }
        wants.xml  { render :xml => @initiative.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /initiatives/1
  # PUT /initiatives/1.xml
  def update
    respond_to do |wants|
      if @initiative.update_attributes(params[:initiative])
        flash[:notice] = 'Initiative was successfully updated.'
        wants.html { redirect_to(@initiative) }
        wants.xml  { head :ok }
      else
        wants.html { render :action => "edit" }
        wants.xml  { render :xml => @initiative.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /initiatives/1
  # DELETE /initiatives/1.xml
  def destroy
    @initiative.destroy

    respond_to do |wants|
      wants.html { redirect_to(initiatives_url) }
      wants.xml  { head :ok }
    end
  end

  private
    def find_initiative
      @initiative = Initiative.find(params[:id])
    end

end

