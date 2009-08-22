class Intervention
  BASE_URL = "http://www.parlamento.euskadi.net"
  attr_accessor :id, :url, :txt_url

  def initialize(id)
    @id = id
    @url = "#{BASE_URL}/sm_splenoc/DDW?W=spl_clave='#{self.id}'"
  end
  
  def file_number
    document.at("th[text()^='Núm. expediente']").next_sibling.content.strip rescue nil
  end
  def source_initiative
    document.at("th[text()^='Iniciativa origen']").next_sibling.content.strip rescue nil
  end
  
  def session_date
    document.at("th[text()^='Fecha sesión:']").next_sibling.content.strip rescue nil
  end
    
  def diary_number
    document.at("th[text()^='Número Diario:']").next_sibling.content.strip rescue nil
  end

  def subject_number
    document.at("th[text()^='Número asunto:']").next_sibling.content.strip rescue nil
  end

  def subject_title
    document.at("th[text()^='Título asunto:']").next_sibling.content.strip rescue nil
  end

  def original_initiative
    document.at("th[text()^='Iniciativa origen:']").next_sibling.content.strip rescue nil
  end
  
  def subject_treated
    document.at("th[text()^='Tramit. asunto:']").next_sibling.content.strip rescue nil
  end

  def speakers
    document.at("th[text()^='Oradores:']").next_sibling.inner_html.strip.split('<br>') rescue []
  end

  def txt_url
    BASE_URL + document.at("//img[@alt='TXT']").parent['href'] rescue nil
  end

  def full_txt
    @txt_document ||= open(self.txt_url).read
  end

  def pdf_url
    BASE_URL + document.at("//div[@class='boton']/script").inner_html.match(/href='(.*)' title/)[1]
  end
  def videos
    document.search("//a[text()=' (256 K)']").map { |v| { v.parent.content => v['href']} } rescue []
  end  
  def document
    @document ||= Nokogiri::HTML(open(self.url).read)
  end
end
