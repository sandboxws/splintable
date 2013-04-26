module Splintable
  module Generators
    class ThevergeGenerator < BasicGenerator
      def get_type
        @type_match = true if @url.match(/theverge.com/)
      end

      def get_content
        @content = @page.at('div.article-body')
        super
      end
    end
  end
end
