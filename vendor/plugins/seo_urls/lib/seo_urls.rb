module Rsm
  module SeoUrls
    def self.included(klass)
      klass.extend ClassMethods
    end

    module ClassMethods
      def seo_urls(attribute_for_url=nil)
        write_inheritable_attribute(:attribute_for_url, attribute_for_url)
        class_inheritable_reader :attribute_for_url
        include Rsm::SeoUrls::InstanceMethods
      end
    end

    module InstanceMethods
      
      def to_param
        self.id.to_s+self.seo_urls_permalink
      end
      
      def seo_urls_permalink
        if !self.attributes[attribute_for_url]
          begin
            string=self.title
          rescue
            begin
              string=self.name
            rescue
              raise("No attribute was specified for seo_urls to use and 'name' and 'title' weren't available")
            end
          end
        else
          string=self.attributes[attribute_for_url]
        end
        if string.nil?
          return ""
        else
          t = "-"+(string.to_s.downcase.strip.gsub(/[^-_\s[:alnum:]]/, '').squeeze(' ').tr(' ', '-'))
        end
      end
      
    end
    
    
    
  end
end

