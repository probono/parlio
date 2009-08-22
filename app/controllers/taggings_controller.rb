class TaggingsController < ApplicationController
  before_filter :find_tagging, :only => [:show]

  def show
    respond_to do |wants|
      wants.html
      wants.xml  { render :xml => @tagging }
    end
  end

  private
    def find_tagging
      @taggings = Initiative.find_tagged_with(params[:tag])
    end

end
