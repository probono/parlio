module Legebiltzarra
  class Intervention
    BASE_URL = "http://www.parlamento.euskadi.net"
    attr_accessor :id, :url, :txt_url
  
    def initialize(id)
      @id = id.strip
      #interventions from commissions and congress have different ids size (16 vs 17)
      if @id.size == 16
        @url = "#{BASE_URL}/sm_scomisc/DDW?W=sco_clave='#{self.id}'"
      else
        @url = "#{BASE_URL}/sm_splenoc/DDW?W=spl_clave='#{self.id}'"
      end
    end
    
    def file_number
      document.at("th[text()^='Núm. expediente']").next_sibling.content.strip rescue nil
    end

    def commission 
      name = document.at("th[text()^='Comisión:']").next_sibling.content.strip rescue nil
      name[name.index('Comis'), name.size - 1] if name && name.index('Comis')
    end
    
    def session_date
      value = document.at("th[text()^='Fecha sesión:']").next_sibling.content.strip rescue nil
      Date.strptime(value, "%d.%m.%Y")
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
      @txt_document ||= open(self.txt_url).read rescue ""
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
end