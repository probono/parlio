class ParliamentariansController < ApplicationController
  before_filter :find_parliamentarian, :only => [:show, :edit, :update, :destroy]

  # GET /parliamentarians
  # GET /parliamentarians.xml
  def index
    @parliamentarians = Parliamentarian.active

    respond_to do |wants|
      wants.html # index.html.erb
      wants.xml  { render :xml => @parliamentarians }
    end
  end

  # GET /parliamentarians/1
  # GET /parliamentarians/1.xml
  def show    
    @activity_data = {
      1.day.ago => { :initiatives => 123 },
      2.day.ago => { :initiatives => 345 },  
      3.day.ago => { :initiatives => 165 },  
      4.day.ago => { :initiatives => 308 }  
    }   
    @activity_annotations = {
      :initiatives => { 
        1.day.ago => [["Relativa al colapso funcional de la Administración ambiental"]],
        2.day.ago => [["Relativa a situación actual de la gripe A en Euskadi"]], 
        3.day.ago => [["Relativa al colapso funcional de la Administración ambiental"]] 
      }
      
    }                
    
    
    
    respond_to do |wants|
      wants.html # show.html.erb
      wants.xml  { render :xml => @parliamentarian }
    end
  end

  # GET /parliamentarians/new
  # GET /parliamentarians/new.xml
  def new
    @parliamentarian = Parliamentarian.new

    respond_to do |wants|
      wants.html # new.html.erb
      wants.xml  { render :xml => @parliamentarian }
    end
  end

  # GET /parliamentarians/1/edit
  def edit
  end

  # POST /parliamentarians
  # POST /parliamentarians.xml
  def create
    @parliamentarian = Parliamentarian.new(params[:parliamentarian])

    respond_to do |wants|
      if @parliamentarian.save
        flash[:notice] = 'Parliamentarian was successfully created.'
        wants.html { redirect_to(@parliamentarian) }
        wants.xml  { render :xml => @parliamentarian, :status => :created, :location => @parliamentarian }
      else
        wants.html { render :action => "new" }
        wants.xml  { render :xml => @parliamentarian.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /parliamentarians/1
  # PUT /parliamentarians/1.xml
  def update
    respond_to do |wants|
      if @parliamentarian.update_attributes(params[:parliamentarian])
        flash[:notice] = 'Parliamentarian was successfully updated.'
        wants.html { redirect_to(@parliamentarian) }
        wants.xml  { head :ok }
      else
        wants.html { render :action => "edit" }
        wants.xml  { render :xml => @parliamentarian.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /parliamentarians/1
  # DELETE /parliamentarians/1.xml
  def destroy
    @parliamentarian.destroy

    respond_to do |wants|
      wants.html { redirect_to(parliamentarians_url) }
      wants.xml  { head :ok }
    end
  end

  private
    def find_parliamentarian
      @parliamentarian = Parliamentarian.find(params[:id])
    end

end
