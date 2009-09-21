module InitiativeHelper
  
  def initiative_author(i)
    if i.parliamentarian
      "#{link_to i.parliamentarian.full_name, parliamentarian_path(i.parliamentarian), :class=>"author"}" +
        "  #{I18n.t("info.de")} #{link_to i.parliamentarian.party.party_acronym, party_path(i.parliamentarian.party), :class=>"party_name"}"
    elsif i.speaker
      i.speaker.name
    end
  end
end
