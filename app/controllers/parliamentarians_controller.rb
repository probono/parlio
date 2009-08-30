class ParliamentariansController < ApplicationController
  
  before_filter :find_parliamentarian, :except => [:index]
  before_filter :calculate_activity_data, :except => [:index]

  def index
    @parliamentarians = Parliamentarian.active

    respond_to do |wants|
      wants.html # index.html.erb
      wants.xml  { render :xml => @parliamentarians }
    end
  end

  def show                
    @page = params[:page] || 1
    @initiatives = @parliamentarian.initiatives.paginate :page => @page, :per_page => 5
    
    respond_to do |wants|
      wants.html # show.html.erb
      wants.xml  { render :xml => @parliamentarian }
    end
  end
  
  def initiatives
    meta :title => "Parlio - Iniciativas del parlamentario #{@parliamentarian.full_name}"
    @page = params[:page] || 1
    @initiatives = @parliamentarian.initiatives.paginate :page => @page, :per_page => 5
    
    respond_to do |wants|
      wants.html { render :template => '/parliamentarians/show' } 
      wants.xml  { render :xml => @initiatives }
    end    
  end
  def interventions
    meta :title => "Parlio - Intervenciones del parlamentario #{@parliamentarian.full_name}"
    @page = params[:page] || 1
    @interventions = @parliamentarian.interventions.paginate :page => @page, :per_page => 5
    
    respond_to do |wants|
      wants.html { render :template => '/parliamentarians/show' }
      wants.xml  { render :xml => @interventions }
    end    
  end
  def commisions
    meta :title => "Parlio - Comisiones en las que participa el parlamentario #{@parliamentarian.full_name}"
    
    @commission_members = @parliamentarian.commission_members
    
    respond_to do |wants|
      wants.html { render :template => '/parliamentarians/show' }
      wants.xml  { render :xml => @commission_members }
    end    
  end


  private
    def find_parliamentarian
      @parliamentarian = Parliamentarian.find(params[:id])
      meta :title => "Parlio - Parlamentario #{@parliamentarian.full_name}"
    end
    
    def calculate_activity_data
      @activity_data = {}
      @parliamentarian.initiatives.group_by(&:initiative_date).each{|date, initiatives|
        @activity_data[date] = {:iniciativas => initiatives.size}
      }      
      @parliamentarian.interventions.group_by(&:session_date).each{|date, interventions|
          @activity_data[date] = {:intervenciones => interventions.size}
      }   
      #@activity_annotations = {
      #  :initiatives => { 
      #    1.day.ago => [["Relativa al colapso funcional de la Administración ambiental"]],
      #    2.day.ago => [["Relativa a situación actual de la gripe A en Euskadi"]], 
      #    3.day.ago => [["Relativa al colapso funcional de la Administración ambiental"]] 
      #  }
      #}                
    end

end
