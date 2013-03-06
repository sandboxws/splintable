module Splintable
  module Generators
    class NoupeGenerator < BasicGenerator
      def get_type
        @type_match = true if @url.match(/noupe.com/)
      end

      def get_content
        @content = @page.at('.post')
        @content.search('.date').remove
        @content.search('.post-details').remove
        @content.search('#contentadcontainer').remove

        super
      end
    end
  end
end
