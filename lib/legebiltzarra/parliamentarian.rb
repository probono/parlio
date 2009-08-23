module Legebiltzarra
  class Parliamentarian
    BASE_URL = "http://www.parlamento.euskadi.net"
    attr_accessor :id, :url, :active, :substitution

    def initialize(id)
      @id = id
      @url = "#{BASE_URL}/fichas/c_#{self.id}_SM.html"
    end
  
    def orig_id
      self.id
    end
    
    def first_name
      self.full_name.split(',').last.strip
    end

    def last_name
      self.full_name.split(',').first.strip
    end     
  
    def full_name                                
      document.at("div[@class='ficha_datos']/span").content.strip rescue nil
    end

    def photo
      BASE_URL + document.at("div[@class='ficha_foto']/img/@src") rescue nil
    end

    def profession
      document.at('dl[@class="tabla"]/[2]').content.strip rescue nil
    end

    def languages
      document.at('dl[@class="tabla"]/[4]').content.strip.scan(/\w+/) rescue []
    end

    def email
      document.at('dl[@class="tabla"]/[6]').content.strip rescue nil
    end   
  
    def posts                        
      document.search('div[@class="indentar2"]//li').map { |l| l.content.strip } rescue []
    end
    
    def active?
      self.active
    end

    def document
       @document ||= Nokogiri::HTML(open(self.url).read)
    end

    def interventions
      begin
        int_url = "#{BASE_URL}/fichas/c_#{self.id}_int_SM.html"
        int_list ||= Nokogiri::HTML(open(int_url).read)
        int_list.search('div[@class="indentar2"]/ul/li/a/@onclick').map{ |p| Intervention.new(p.content.match(/\d+/)[0]) }
      rescue 
        []
      end
    end
      
    def initiatives
      begin
        ini_url = "#{BASE_URL}/fichas/c_#{self.id}_ini_SM.html"
        ini_list ||= Nokogiri::HTML(open(ini_url).read)
        ini_list.search('div[@class="indentar2"]/ul/li/a').map{ |p| Initiative.new( p.content.match(/[0-9\\]+/)[0] ) }
      rescue 
        []
      end
    end
  end
end