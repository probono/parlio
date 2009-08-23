class PartiesController < ApplicationController
  before_filter :find_party, :only => [:show, :commissions, :interventions]
  before_filter :load_news, :only => [:show, :commissions, :interventions]

  def show
    
    respond_to do |wants|
      wants.html 
      wants.xml  { render :xml => @party }
    end
  end

  def commissions

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
      appid = "rzAI5ZbV34Frd2_uCqREg14Ui0jflPNwI5ub43vXao6R7fOO8_ciI.cwM7v7b8JToINus3w-"
      output="json"
      name = URI.escape(@party.party_acronym)
      rs = Net::HTTP.get URI.parse("http://search.yahooapis.com/NewsSearchService/V1/newsSearch?appid=#{appid}&query=#{name}&results=2&language=es&output=#{output}")
      puts "http://search.yahooapis.com/NewsSearchService/V1/newsSearch?appid=#{appid}&query=#{name}&results=2&language=es&output=#{output}"
      ActiveSupport::JSON.decode(rs)
    end
end

