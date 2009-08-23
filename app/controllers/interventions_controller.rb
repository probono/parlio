class InterventionsController < ApplicationController
  before_filter :find_intervention, :only => [:show, :edit, :update, :destroy]

  # GET /interventions
  # GET /interventions.xml
  def index
    @interventions = Intervention.all

    respond_to do |wants|
      wants.html # index.html.erb
      wants.xml  { render :xml => @interventions }
    end
  end

  # GET /interventions/1
  # GET /interventions/1.xml
  def show
    respond_to do |wants|
      wants.html # show.html.erb
      wants.xml  { render :xml => @intervention }
    end
  end

  # GET /interventions/new
  # GET /interventions/new.xml
  def new
    @intervention = Intervention.new

    respond_to do |wants|
      wants.html # new.html.erb
      wants.xml  { render :xml => @intervention }
    end
  end

  # GET /interventions/1/edit
  def edit
  end

  # POST /interventions
  # POST /interventions.xml
  def create
    @intervention = Intervention.new(params[:intervention])

    respond_to do |wants|
      if @intervention.save
        flash[:notice] = 'Intervention was successfully created.'
        wants.html { redirect_to(@intervention) }
        wants.xml  { render :xml => @intervention, :status => :created, :location => @intervention }
      else
        wants.html { render :action => "new" }
        wants.xml  { render :xml => @intervention.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /interventions/1
  # PUT /interventions/1.xml
  def update
    respond_to do |wants|
      if @intervention.update_attributes(params[:intervention])
        flash[:notice] = 'Intervention was successfully updated.'
        wants.html { redirect_to(@intervention) }
        wants.xml  { head :ok }
      else
        wants.html { render :action => "edit" }
        wants.xml  { render :xml => @intervention.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /interventions/1
  # DELETE /interventions/1.xml
  def destroy
    @intervention.destroy

    respond_to do |wants|
      wants.html { redirect_to(interventions_url) }
      wants.xml  { head :ok }
    end
  end

  private
    def find_intervention
      @intervention = Intervention.find(params[:id])
    end

end


