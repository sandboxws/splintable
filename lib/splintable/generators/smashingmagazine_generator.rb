module Splintable
  module Generators
    class SmashingmagazineGenerator < BasicGenerator
      def get_type
        @type_match = true if @url.match(/smashingmagazine.com/)
      end

      def get_content
        @content = @page.at('article.post')
        @content.at('h2:first').remove

        super
      end
    end
  end
end
