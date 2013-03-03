module Splintable
  module Generators
    class MarcoGenerator < BasicGenerator
      def get_type
        @type_match = true if @url.match(/marco.org/)
      end

      def get_content
        @content = @page.at('article')
        @content.search('header').remove
        @content.search('#masthead').remove

        super
      end
    end
  end
end
