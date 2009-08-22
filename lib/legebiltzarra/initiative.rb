class Initiative
  BASE_URL = "http://www.parlamento.euskadi.net"
  attr_accessor :id, :url

  def initialize(id)
    @id = id
    @url = "#{BASE_URL}/sm_ainiciac/DDW?W=INI_NUMEXP='#{CGI.escape(self.id)}'"
  end
  
  def title
    document.at("th[text()^='Título iniciativa:']").next_sibling.content.strip rescue nil
  end

  def party
    document.at("th[text()^='Proponentes:']").next_sibling.content.strip rescue nil
  end
  
  def type
    document.at("th[text()^='Tipo iniciativa:']").next_sibling.content.strip rescue nil
  end

  def tags
    document.at("th[text()^='Descriptores:']").next_sibling.inner_html.strip.split('<br>') rescue []
  end

  def procedures
    document.at("th[text()^='Trámites:']").next_sibling.search('a').map { |a| { a.content => BASE_URL + a['href']} } rescue []
  end
  def votings
    document.at("th[text()^='Votaciones:']").next_sibling.search('a').map { |a| { a.content => BASE_URL + a['href']} } rescue []
  end
  def document
    @document ||= Nokogiri::HTML(open(self.url).read)
  end
end
