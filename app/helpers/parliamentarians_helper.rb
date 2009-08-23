module ParliamentariansHelper
  def parlavatar(p) 
    content_tag :p, :class => "photo"  do
      link_to image_tag(p.photo, :width => "48", :alt => "Foto de #{p.full_name}"), parliamentarian_path(p)
    end
    
  end
end
