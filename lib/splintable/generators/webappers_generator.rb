module Splintable
  module Generators
    class WebappersGenerator < BasicGenerator
      def get_type
        @type_match = true if @url.match(/webappers.com/)
        if !@type_match
          idx = @page.at('link[@rel="index"]')
          if idx
            @type_match = true if idx['title'] == 'WebAppers'
          end
        end

        @type_match
      end

      def get_content
        @content = @page.at('div.post')
        @content = @page.at('div.entry') if @content.nil?
        @content.search('h1:first').remove

        super
      end
    end
  end
end
