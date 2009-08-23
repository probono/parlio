class ParliamentariansController < ApplicationController
  before_filter :find_parliamentarian, :only => [:show, :edit, :update, :destroy]

  def index
    @parliamentarians = Parliamentarian.active

    respond_to do |wants|
      wants.html # index.html.erb
      wants.xml  { render :xml => @parliamentarians }
    end
  end

  def show                
    @activity_data = {}
    
    @parliamentarian.initiatives.group_by(&:initiative_date).each{|date, initiatives|
      @activity_data[date] = {:initiatives => initiatives.size}
    }     
     
    @page = params[:page] || 1
    @initiatives = @parliamentarian.initiatives.paginate :page => @page, :per_page => 5
    
    @parliamentarian.interventions.group_by(&:session_date).each{|date, interventions|
        @activity_data[date] = {:interventions => interventions.size}
    }   
    #@activity_annotations = {
    #  :initiatives => { 
    #    1.day.ago => [["Relativa al colapso funcional de la Administración ambiental"]],
    #    2.day.ago => [["Relativa a situación actual de la gripe A en Euskadi"]], 
    #    3.day.ago => [["Relativa al colapso funcional de la Administración ambiental"]] 
    #  }
    #}                
    
    
    
    respond_to do |wants|
      wants.html # show.html.erb
      wants.xml  { render :xml => @parliamentarian }
    end
  end


  private
    def find_parliamentarian
      @parliamentarian = Parliamentarian.find(params[:id])
    end

end
