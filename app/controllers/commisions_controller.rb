class CommisionsController < ApplicationController
  meta :title => "Parlio - Comisiones Actuales en el Parlamento Vasco"

  before_filter :find_commision, :only => [:show]

  def index
    @commisions = Commision.all
    @commision  = Commision.first

    render :action => :show
  end

  def show
    @commisions = Commision.all
    meta :title => "Parlio - Debates realizados en la comisión de #{@commision.name}"

    respond_to do |wants|
      wants.html # show.html.erb
      wants.xml  { render :xml => @commision }
    end
  end

  private
    def find_commision
      @commision = Commision.find(params[:id])
    end

end
