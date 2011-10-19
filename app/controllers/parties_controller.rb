class PartiesController < ApplicationController
  before_filter :find_party, :only => [:show, :commissions, :interventions]
  before_filter :load_news, :only => [:show, :commissions, :interventions]

  def show
    meta :title => "Parlio - #{@party.name} en el Parlamento Vasco"
    
    respond_to do |wants|
      wants.html 
      wants.xml  { render :xml => @party }
    end
  end

  def commissions
    
    @commissions = @party.parliamentarians.map{|parla|parla.commissions}.flatten
    
    respond_to do |wants|
      wants.html 
      wants.xml  { render :xml => @party }
    end
  end

  def interventions

    respond_to do |wants|
      wants.html 
      wants.xml  { render :xml => @party }
    end
  end


  private
    def find_party
      @party = Party.find(params[:id])
    end

    def load_news
      @news = get_news_for_this_party
    end

    def get_news_for_this_party
      appid = "CD341340140122006521FEEE3D7AB8591B6D5351"
      name = URI.escape(@party.party_acronym)
      url = "http://api.bing.net/json.aspx?AppId=#{appid}&Query=#{name}&Sources=News&Version=2.0&Market=es-es&News.Count=2&News.SortBy=Date"
      rs = Net::HTTP.get(URI.parse(url))
      puts url
      ActiveSupport::JSON.decode(rs)["SearchResponse"]["News"]
    end
end

