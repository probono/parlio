module LinkingPaths
  module MetaTags
    def self.included(base)
      base.extend ClassMethods
    end
    
    module ClassMethods

      def meta(tags = nil)
        include LinkingPaths::MetaTags::InstanceMethods

        if tags.is_a? Hash
          write_inheritable_attribute('meta_data',class_meta.merge(tags))
        elsif tags.is_a? Symbol
          return class_meta[tags]
        end
        class_meta
      end
      
      def class_meta
        read_inheritable_attribute('meta_data') || {}
      end
    end
    
    module InstanceMethods
      def meta(tags = nil)
        @meta_data ||= self.class.meta.clone
        if tags.is_a? Hash
          @meta_data.merge!(tags)
        elsif tags.is_a? Symbol
          return @meta_data[tags]
        end
        @meta_data
      end
    end
    
    module Helpers
      def meta_tag(tag)
        meta_html(tag, meta_data[tag])
      end
      def title_tag
        title = meta_data[:title]
        title ? %{<title>#{title}</title>} : ''
      end
      def meta_tags
        markup = []
        meta_data.each{|name,content|
          markup << meta_html(name, content) + "\n"
        }
        markup
      end

      protected
      
      def meta_html(name, content)
        %{<meta name="#{name}" content="#{content}" />}
      end
      
      def meta_data
        @meta_data || controller.class.meta
      end
      
    end
    
  end

end

ActionController::Base.send :include, LinkingPaths::MetaTags
ActionView::Base.send :include, LinkingPaths::MetaTags::Helpers