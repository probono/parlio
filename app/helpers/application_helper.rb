# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def main_tab_class(tab)
    c = controller.controller_name
    if tab == 'parliament'
      'class="active"' if ['parliamentarians', 'parties'].include?(c)
    elsif tab == 'activity'
        'class="active"' if ['activity', 'initiatives', 'taggings', 'interventions', 'commisions', 'topics'].include?(c)
    elsif tab == 'about'
      'class="active"' if c == 'page'
    else
      ''
    end
  end
  
end
