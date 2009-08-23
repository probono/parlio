module Legebiltzarra
  class Announcement
    
    BASE_URL = "http://www.parlamento.euskadi.net"
    attr_accessor :id, :url

    def initialize(id)
      @id = id
      @url = "#{BASE_URL}/sm_abopvc/DDW?W=boc_clave='#{self.id}'"
    end

    def num_exp
      document.at("th[text()^='Núm. expediente:']").next_sibling.content.strip rescue nil
    end
    
    def announcement_date
      value = document.at("th[text()^='Fecha boletín:']").next_sibling.content.strip rescue nil
      Date.strptime(value, "%d.%m.%Y")
    end

    def summary
      document.at("th[text()^='Sumario:']").next_sibling.content.strip rescue nil
    end
    
    def number
      document.at("th[text()^='Núm. boletín:']").next_sibling.content.strip rescue nil
    end
    
    def page
      document.at("th[text()^='Página boletín:']").next_sibling.content.strip rescue nil
    end

    def announcement_url
      BASE_URL + document.search('div[@class="boton"]/a/@href').first.content.strip rescue nil
    end

    def document
      @document ||= Nokogiri::HTML(open(self.url).read)
    end

  end

end