module InitiativeHelper
  
  def initiative_author(i)
    "#{link_to i.parliamentarian.full_name, parliamentarian_path(i.parliamentarian), :class=>"author"}" +
       "  #{I18n.t("info.de")} #{link_to i.parliamentarian.party.party_acronym, party_path(i.parliamentarian.party), :class=>"party_name"}" if i.parliamentarian
  end
end
