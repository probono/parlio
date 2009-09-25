class CommisionsController < ApplicationController
  meta :title => "Parlio - Comisiones Actuales en el Parlamento Vasco"

  before_filter :all_commissions
  before_filter :find_commision, :only => [:show]

  def index
    @commision  = Commision.first

    render :action => :show
  end

  def show
    meta :title => "Parlio - Debates e iniciativas de la comisión de #{@commision.name}"

    @page = params[:page] || 1

    @activity = @commision.interventions + @commision.initiatives
    @activity = @activity.sort_by { |e| if e.instance_of? Initiative; e.initiative_date; else e.session_date; end }.reverse
    @activity = @activity.paginate :page => @page, :per_page => 8

    respond_to do |wants|
      wants.html # show.html.erb
      wants.xml  { render :xml => @commision }
    end
  end

  private
  
    def all_commissions
      @commisions = Commision.all
    end
    
    def find_commision
      @commision = Commision.find(params[:id])
    end

end
