atom_feed(:url => commision_url(@commision, :atom)) do |feed|
  feed.title("Parlio: Comisión #{@commision.name}")
  feed.updated(@activity.first ? @activity.first.created_at : Time.now.utc)

  for t in @activity
    if t.instance_of? Initiative
      feed.entry(t, :url => initiative_url(t), :updated => t.initiative_date) do |entry|
        entry.title("#{I18n.t("asunto")}: #{t.title}")
        entry.content("#{I18n.t('info.por')}: #{initiative_author(t)}<br/>
                       #{I18n.t('info.para')}: #{t.recipient}", :type => 'html')
      end
    else
      feed.entry(t, :url => intervention_url(t), :updated => t.session_date) do |entry|
        entry.title("#{I18n.t("debate")}: #{t.subject_title}")
        entry.content("", :type => 'html')    
      end  
    end
  end
end