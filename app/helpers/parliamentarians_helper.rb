module ParliamentariansHelper

  def parlavatar(p, size=48) 
    content_tag :p, :class => "photo"  do
      link_to image_tag(p.photo, :width => size, :alt => "Foto de #{p.full_name}"), parliamentarian_path(p)
    end
  end
  
  def status_button(parliamentarian)
    css = @parliamentarian.active? ? "active" : "retired"
    status = @parliamentarian.active? ? "En activo" : "Retirado"
    "<p class=\"parliamentarian_status #{css}\"><span>#{status}</span></p>"
  end
    
end
