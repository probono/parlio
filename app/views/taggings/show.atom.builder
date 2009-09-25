atom_feed(:url => initiatives_by_tag_url(@tag.name, :format => :atom)) do |feed|
  feed.title("Parlio: #{I18n.t('taggings.etiquetadas_con')} #{@tag.name}")
  feed.updated(@taggings.first ? @taggings.first.initiative_date : Time.now.utc)

  for initiative in @taggings
    feed.entry(initiative, :url => initiative_url(initiative), :updated => initiative.initiative_date) do |entry|
      entry.title(initiative.title)
      entry.content("#{I18n.t('info.por')}: #{initiative_author(initiative)}<br/>
                     #{I18n.t('info.para')}: #{initiative.recipient}", :type => 'html')
    end
  end
end