class CommisionsController < ApplicationController
  before_filter :find_commision, :only => [:show]

  def index
    @commisions = Commision.all
    @commision  = Commision.first

    render :action => :show
  end

  def show
    @commisions = Commision.all

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
