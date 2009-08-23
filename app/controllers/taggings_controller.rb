class TaggingsController < ApplicationController
  before_filter :find_taggings, :only => [:show]

  def show      
    @tag = Tag.find_by_name(params[:tag])
    respond_to do |wants|
      wants.html
      wants.xml  { render :xml => @tagging }
    end
  end

  private
    def find_taggings
      @taggings = Initiative.find_tagged_with(params[:tag]).paginate :per_page => 5,  :page => params[:page]
    end

end
