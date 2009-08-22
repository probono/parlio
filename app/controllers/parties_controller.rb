class PartiesController < ApplicationController
  before_filter :find_party, :only => [:show, :edit, :update, :destroy]

  # GET /parties
  # GET /parties.xml
  def index
    @parties = Party.all

    respond_to do |wants|
      wants.html # index.html.erb
      wants.xml  { render :xml => @parties }
    end
  end

  # GET /parties/1
  # GET /parties/1.xml
  def show       
    @news = get_news_for_this_party
    
    respond_to do |wants|
      wants.html # show.html.erb
      wants.xml  { render :xml => @party }
    end
  end

  # GET /parties/new
  # GET /parties/new.xml
  def new
    @party = Party.new

    respond_to do |wants|
      wants.html # new.html.erb
      wants.xml  { render :xml => @party }
    end
  end

  # GET /parties/1/edit
  def edit
  end

  # POST /parties
  # POST /parties.xml
  def create
    @party = Partie.new(params[:partie])

    respond_to do |wants|
      if @party.save
        flash[:notice] = 'Partie was successfully created.'
        wants.html { redirect_to(@party) }
        wants.xml  { render :xml => @partie, :status => :created, :location => @party }
      else
        wants.html { render :action => "new" }
        wants.xml  { render :xml => @party.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /parties/1
  # PUT /parties/1.xml
  def update
    respond_to do |wants|
      if @party.update_attributes(params[:partie])
        flash[:notice] = 'Partie was successfully updated.'
        wants.html { redirect_to(@party) }
        wants.xml  { head :ok }
      else
        wants.html { render :action => "edit" }
        wants.xml  { render :xml => @party.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /parties/1
  # DELETE /parties/1.xml
  def destroy
    @party.destroy

    respond_to do |wants|
      wants.html { redirect_to(parties_url) }
      wants.xml  { head :ok }
    end
  end

  private
    def find_party
      @party = Party.find(params[:id])
    end
    
    def get_news_for_this_party
      appid = "rzAI5ZbV34Frd2_uCqREg14Ui0jflPNwI5ub43vXao6R7fOO8_ciI.cwM7v7b8JToINus3w-"
      output="json"
      name = URI.escape(@party.group_name)
      rs = Net::HTTP.get URI.parse("http://search.yahooapis.com/NewsSearchService/V1/newsSearch?appid=#{appid}&query=#{name}&results=2&language=es&output=#{output}")
      ActiveSupport::JSON.decode(rs)
    end
end

