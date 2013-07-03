module Splintable
  module Generators
    class NytimesGenerator < BasicGenerator
      def get_type
        @type_match = true if @url.match(/nytimes.com/)
      end

      def get_content
        @content = @page.at('#article > div.columnGroup')
        @content.search('.doubleRule').remove

        super
      end
    end
  end
end
