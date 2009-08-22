module Legebiltzarra
  class Comission
    BASE_URL = "http://www.parlamento.euskadi.net"
    attr_accessor :id, :url

    def initialize(id)
      @id = id
      @url = "#{BASE_URL}/comorga/c_comorga_com_ACT_#{self.id}.html"
    end

    def name                        
      document.at("div[@class='nivel1_blau']/h2[@class='indentar1']").content.strip rescue nil
    end

    def document
       @document ||= Nokogiri::HTML(open(self.url).read)
    end

  end
end