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

    def president
      name = parliamentarians.search("td[@headers='header1comision1 header4comision1']")[0]
      date = parliamentarians.search("td[@headers='header3comision1 header4comision1']")[0]
      build_member(name, Member::PRESIDENT, date )
    end
        
    def vicepresident
      name = parliamentarians.search("td[@headers='header1comision1 header5comision1']")[0]
      date = parliamentarians.search("td[@headers='header3comision1 header5comision1']")[0]
      build_member(name, Member::VICEPRESIDENT, date )
    end
    
    def secretary
      name = parliamentarians.search("td[@headers='header1comision1 header6comision1']")[0]
      date = parliamentarians.search("td[@headers='header3comision1 header6comision1']")[0]
      build_member(name, Member::SECRETARY, date )
    end
    
    def vocals
      names = parliamentarians.search("td[@headers='header1comision1 header7comision1']")
      dates = parliamentarians.search("td[@headers='header3comision1 header7comision1']")
      vocals = Array.new
      0.upto(names.size - 1) do |i|
        vocals << build_member(names[i], Member::VOCAL, dates[i])
      end
      vocals
    end

    def document
       @document ||= Nokogiri::HTML(open(self.url).read)
    end
    
    def parliamentarians
      @parlamientarians ||= document.search("table[@class='parlamentarios']/tr")
    end

    protected 
      
      def build_member(name, position, date)
        member = Member.new(name.at("a/@onclick").content.match(/\d+/)[0])
        member.position = Member::VICEPRESIDENT
        member.date = date.content
        member        
      end
  end

  class Member
    attr_accessor :id, :position, :date
    
    PRESIDENT     = 1
    VICEPRESIDENT = 2
    SECRETARY     = 3
    VOCAL         = 4
    
    def initialize(id)
      @id = id
    end
        
    def parliamentarian
      Legebiltzarra::Parliamentarian.new(@id)
    end
    
  end

end