module Legebiltzarra
  class Legislature                        
    CURRENT_LEGISLATURE="LGA"
    CURRENT_PARLIAMENTARIANS="ACT"
    BASE_URL = "http://www.parlamento.euskadi.net"
    
    attr_accessor :id, :url
  
    def initialize(id=CURRENT_PARLIAMENTARIANS)
      @id = id                   
      @url = "#{BASE_URL}/comparla/c_comparla_alf_#{self.id}.html"
    end
  
    def parliamentarians
      document.search('td[@class="miembro_persona"]/a/@href').map { |p| Parliamentarian.new(p.content.match(/\/fichas\/c_(.*).html/)[1]) } rescue []
    end
  
  
    def document
       @document ||= Nokogiri::HTML(open(self.url).read)
    end
  end
end