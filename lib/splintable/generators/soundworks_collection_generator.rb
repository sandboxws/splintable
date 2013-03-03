module Splintable
  module Generators
    class SoundworksCollectionGenerator < BasicGenerator
      def get_type
        @type_match = true if @url.match(/soundworkscollection.com/)
      end

      def get_content
        @content = @page.at('#main-container')
        @content.search('#main-container h1').remove

        super
      end
    end
  end
end
