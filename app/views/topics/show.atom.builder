atom_feed(:url => topic_url(@topic, :atom)) do |feed|
  feed.title("Parlio: #{@topic.name}")
  feed.updated(@initiatives.first ? @initiatives.first.initiative_date : Time.now.utc)

  for initiative in @initiatives
    feed.entry(initiative, :url => initiative_url(initiative)) do |entry|
      entry.title(initiative.title)
      entry.content("#{I18n.t('info.por')}: #{initiative_author(initiative)}<br/>
                     #{I18n.t('info.para')}: #{initiative.recipient}", :type => 'html')
    end
  end
end