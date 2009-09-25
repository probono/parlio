class TaggingsController < ApplicationController
  before_filter :find_taggings, :only => [:show]

  def show
    @tag = Tag.find_by_name(params[:tag])
    meta :title => "Parlio - Iniciativas etiquetadas con '#{@tag.name}'"
    @most_active_parliamentarians = most_active_parliamentarians(params[:tag])

    respond_to do |wants|
      wants.html
      wants.xml  { render :xml => @tagging }
      wants.atom { render(:layout => false) }
    end
  end

  private
    def most_active_parliamentarians(tag)
      Initiative.with_parliamentarian.find_tagged_with(tag).group_by(&:parliamentarian).sort_by{|x| x[1].size}.reverse.first(3)
    end

    def find_taggings
      @taggings = Initiative.find_tagged_with(params[:tag], :order => "initiative_date desc").paginate :per_page => 5,  :page => params[:page]
    end

end
