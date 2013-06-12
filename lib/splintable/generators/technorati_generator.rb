module Splintable
  module Generators
    class TechnoratiGenerator < BasicGenerator
      def get_type
        @type_match = true if @url.match(/technorati.com/)
      end

      def get_content
        @content = @page.at('#article-body')
        @content.search('h1').remove
        @content.search('div.emphasis').remove
        @content.search('#article-metadata').remove
        @content.search('#likebuttonarea').remove

        super
      end
    end
  end
end
