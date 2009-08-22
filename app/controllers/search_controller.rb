class SearchController < ApplicationController

  SOURCES = ['Parliamentarian']

  def search
    @page = params[:page] || '1'
    @term = params[:search_term]
    @matches = Array.new
    SOURCES.each do |s|
      source = s.constantize
      @matches << source.site_search(@term)
    end
    @matches = @matches.flatten.paginate :page => @page, :per_page => 2
    respond_to do |format|
      format.html 
      format.xml  { render :xml => @matches }
    end
  end  
  
end
