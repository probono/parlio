module ParliamentariansHelper
  def parlavatar(p)
    image_tag p.photo, :size => "32x32", :alt => p.full_name
  end
end
