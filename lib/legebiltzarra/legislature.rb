module Legebiltzarra
  class Legislature                        
    CURRENT_LEGISLATURE="LGA"
    ACTIVE="ACT"
    BASE_URL = "http://www.parlamento.euskadi.net"
    
    attr_accessor :id, :url
  
    def initialize(id=CURRENT_LEGISLATURE)
      @id = id                   
      @url = "#{BASE_URL}/comparla/c_comparla_alf_#{self.id}.html"
    end
  
    def parliamentarians
      #original
#      document.search('td[@class="miembro_persona"]/a/@href').map { |p| Parliamentarian.new(p.content.match(/\/fichas\/c_(.*).html/)[1]) } rescue []

      #get substitutions
      # document.search('p[@class="sustituto"]').each do |row|
      #   if row.content.index('Sustituye a') 
      #     name = row.content.scan(/Sustituye a (.*) \(/)[0]
      #     puts "IN #{row.content}: #{name}"
      #   else
      #     name = row.content.scan(/Sustituid[a-o] por (.*) \(/)[0]
      #     puts "OUT #{row.content}: #{name}"
      #   end
      # end  
      
      parliamentarians = Array.new
      rows = document.search('table[@class="parlamentarios"]/tr')
      if rows
        0.upto(rows.size - 1) do |i|
          r = rows[i]
          if r.search('td[@class="miembro_persona"]').size > 0
            data = r.search('td[@class="miembro_persona"]/a/@onclick')[0]
            p = Parliamentarian.new(data.content.match(/\d+/)[0])
            parliamentarians << p
          elsif r.search('p[@class="sustituto"]').size > 0
            data = r.search('p[@class="sustituto"]')[0]
            if data.content.index('Sustituye a') 
              name = data.content.scan(/Sustituye a (.*) \(/).first
              parliamentarians.last.active = true
              parliamentarians.last.substitution = name.first
              puts "#{name} sustituido por #{parliamentarians.last.full_name}"
            else
              name = data.content.scan(/Sustituid[a-o] por (.*) \(/).first
              parliamentarians.last.active = false
              parliamentarians.last.substitution = name.first
              puts "#{name} sustituye a #{parliamentarians.last.full_name}"
            end          
          end
        end
      end
      
      #fix names for substitutions: Ape1 Ape2, Nombre vs Nombre Ape1, Ape2
      parlas = parliamentarians.select{|p| p.substitution != nil}
      parliamentarians.each do |parliamentarian|
        if parliamentarian.substitution
          tmp = parlas.select{|p| "#{p.first_name} #{p.last_name}" == parliamentarian.substitution}.first
          if tmp
            parliamentarian.substitution = tmp.full_name
            if parliamentarian.active?
              puts "#{parliamentarian.full_name} sustituye a #{tmp.full_name}"
            else
              puts "#{parliamentarian.full_name} sustituido por #{tmp.full_name}"
            end
          else
            puts "---> Who is #{parliamentarian.substitution}?"
          end
        end
      end
          
      parliamentarians
    end
    
    def parties(id=ACTIVE)
      parties_url = "#{BASE_URL}/c_comorga_gru_#{self.id}_SM.html"
      parties_document ||= Nokogiri::HTML(open(parties_url).read)
      parties_document.search('div[@id="grupos"]/table/tr').map { |p| Party.new(p) } rescue []      
    end
    
    def comissions(id=ACTIVE)
      comissions_url = "#{BASE_URL}/comorga/c_comorga_com_#{self.id}.html"
      comissions_document ||= Nokogiri::HTML(open(comissions_url).read)
      comissions_document.search('div[@class="contenido_principal"]/ul[@class="lista_nomargin"]/li/a/@href').map { |c| Comission.new(c.content.match(/\d+/)[0] ) } rescue []
    end

    def topics
      topics_url = "#{BASE_URL}/cuadros/c_cuadros_tema_ENC.html"
      topics_document ||= Nokogiri::HTML(open(topics_url).read)
      topics = Array.new
      topics_document.search('table[@class="tabla_estadisticas"]/tr').each do |row| 
        topic = Topic.new

        #ains, changed classes in html for even/pair
        url_column = row.search('td[@class=tabla_estadisticas1]/a')
        if url_column.size == 0
          url_column = row.search('td[@class=tabla_estadisticas2]/a')
        end

        topic.url  = url_column[0].at('@href').content        
        topic.size = url_column[0].content
        topic.name = row.search('td[@class=tabla_estadisticas1]')[0].content 
        topics << topic
      end
      topics
    end
      
    def topics_for_closed_initiatives
      topics_url = "#{BASE_URL}/cuadros/c_cuadros_tema_CER.html"
      topics_document ||= Nokogiri::HTML(open(topics_url).read)
      topics = Array.new
      topics_document.search('table[@class="tabla_estadisticas"]/tr').each do |row| 
        topic = Topic.new

        #ains, changed classes in html for even/pair
        url_column = row.search('td[@class=tabla_estadisticas1]/a')
        if url_column.size == 0
          url_column = row.search('td[@class=tabla_estadisticas2]/a')
        end

        topic.url  = url_column[0].at('@href').content        
        topic.size = url_column[0].content
        topic.name = row.search('td[@class=tabla_estadisticas1]')[0].content 
        topics << topic
      end
      topics
    end
    

    def document
       @document ||= Nokogiri::HTML(open(self.url).read)
    end
  end
end