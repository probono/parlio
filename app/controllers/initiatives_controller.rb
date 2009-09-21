class InitiativesController < ApplicationController

  meta :title => "Parlio - Últimos asuntos tratados en el Parlamento Vasco"
  before_filter :find_initiative, :only => [:show, :edit, :update, :destroy]

  def index
    @most_active = Topic.most_active
    tuples = Tagging.count(:all, :group => "tag_id", :order => "count(*) DESC", :limit=> 10)
    returning @most_active_tags = [] do
      tuples.each{|tuple| @most_active_tags << Tag.find(tuple[0])}
    end       
    @most_active_parties= Party.most_active
    @most_active_parliamentarians= Parliamentarian.most_active
    @most_recent_initiatives = Initiative.find(:all, :limit => 3, :order => 'initiative_date desc')

    respond_to do |wants|
      wants.html # index.html.erb
      wants.xml  { render :xml => @initiatives }
    end
  end

  def show
    meta :title => "Parlio - #{@initiative.initiative_type} - #{@initiative.title}"
    respond_to do |wants|
      wants.html # show.html.erb
      wants.xml  { render :xml => @initiative }
    end
  end

  private
    def find_initiative
      @initiative = Initiative.find(params[:id])
    end

end

