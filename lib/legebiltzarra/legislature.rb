module Legebiltzarra
  class Legislature                        
    CURRENT_LEGISLATURE="LGA"
    ACTIVE="ACT"
    BASE_URL = "http://www.parlamento.euskadi.net"
    
    attr_accessor :id, :url
  
    def initialize(id=ACTIVE)
      @id = id                   
      @url = "#{BASE_URL}/comparla/c_comparla_alf_#{self.id}.html"
    end
  
    def parliamentarians
      document.search('td[@class="miembro_persona"]/a/@href').map { |p| Parliamentarian.new(p.content.match(/\/fichas\/c_(.*).html/)[1]) } rescue []
    end
    
    def parties(id=ACTIVE)
      parties_url = "#{BASE_URL}/c_comorga_gru_#{self.id}_SM.html"
      parties_document ||= Nokogiri::HTML(open(parties_url).read)
      parties_document.search('div[@id="grupos"]/table/tr').map { |p| Party.new(p) } rescue []      
    end
  
  
    def document
       @document ||= Nokogiri::HTML(open(self.url).read)
    end
  end
end