module Legebiltzarra
  class Initiative
    BASE_URL = "http://www.parlamento.euskadi.net"
    attr_accessor :id, :url

    def initialize(id)
      @id = id
      @url = "#{BASE_URL}/sm_ainiciac/DDW?W=INI_NUMEXP='#{CGI.escape(self.id)}'"
    end

    def num_exp
      self.id
    end

    def title
      document.at("th[text()^='Título iniciativa:']").next_sibling.content.strip rescue nil
    end

    def proposer
      document.at("th[text()^='Proponentes:']").next_sibling.content.strip rescue nil
    end

    def recipient
      document.at("th[text()^='Destinatario:']").next_sibling.content.strip rescue nil
    end
        
    def initiative_date
      value = document.at("th[text()^='Fecha de alta:']").next_sibling.content.strip rescue nil
      Date.strptime(value, "%d.%m.%Y")
    end

    def type
      document.at("th[text()^='Tipo iniciativa:']").next_sibling.content.strip rescue nil
    end

    def tags
      document.at("th[text()^='Descriptores:']").next_sibling.inner_html.strip.split('<br>') rescue []
    end

    def procedures
      procedures = Array.new
      document.at("th[text()^='Trámites:']").next_sibling.search('a').each do |a|
        value = a.content[0, a.content.index('/')]
        procedure_date = Date.strptime(value, "%d.%m.%Y")
        title = a.content[a.content.index('/') + 1, a.content.size - 1]
        url = BASE_URL + a['href']
        procedures << { :title => title, :url => url, :procedure_date => procedure_date}
      end
      procedures
    end

    def announcement
      #FIXME some initiative shas more than one bulletin, in a second row.
      #example: http://parlamento.euskadi.net/BASIS/izaro/webx/sm_iniciac/DDW?W%3Dini_seccion%3D11+and+ini_serie%3D2+and+ini_legis%3D9+and+ini_pendi+ne+0+order+by+ini_numexp%26M%3D9%26K%3D09\11\02\01\0017%26R%3DY%26U%3D1
      begin
        if document.at("th[text()^='Boletines:']")
          docid = document.at("th[text()^='Boletines:']").next_sibling.inner_html.scan(/'(\d+)'/).to_s
          Announcement.new(docid)
        end
      rescue Exception => e
        puts self.url
        puts e.inspect
        nil
      end
    end

    def votings
      document.at("th[text()^='Votaciones:']").next_sibling.search('a').map { |a| { a.content => BASE_URL + a['href']} } rescue []
    end

    def document
      @document ||= Nokogiri::HTML(open(self.url).read)
    end
  end
end
