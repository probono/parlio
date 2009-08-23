module VideosHelper

  def speaker_name(v)
    if v.parliamentarian
      link_to v.parliamentarian.full_name, v.parliamentarian
    else
      v.title
    end
  end
      
  def speaker_party(v)
    if v.parliamentarian
      link_to v.parliamentarian.party.party_acronym, v.parliamentarian.party, :class => "party_name"
    end
  end
  
end
