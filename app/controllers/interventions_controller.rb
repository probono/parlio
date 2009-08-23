class InterventionsController < ApplicationController
  before_filter :find_intervention, :only => [:show, :edit, :update, :destroy]

  def index

    @interventions = Intervention.find(:all, :order=> "session_date desc")
    @sessions_date = @interventions.map{|i| i.session_date}.uniq.sort.reverse
    @interventions = @interventions.paginate :per_page => 10,  :page => params[:page]

    respond_to do |wants|
      wants.html # index.html.erb
      wants.xml  { render :xml => @interventions }
    end
  end

  def show
    respond_to do |wants|
      wants.html # show.html.erb
      wants.xml  { render :xml => @intervention }
    end
  end

  def by_session_date
    sd = params[:session_date].split '-'
    @session_date = Date.new(sd[0].to_i, sd[1].to_i, sd[2].to_i)
    @interventions = Intervention.by_session_date(@session_date).all
  end


  private
    def find_intervention
      @intervention = Intervention.find(params[:id])
    end

end


