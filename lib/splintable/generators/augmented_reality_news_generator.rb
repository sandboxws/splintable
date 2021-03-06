module Splintable
  module Generators
    class AugmentedRealityNewsGenerator < BasicGenerator
      def get_type
        @type_match = true if @url.match(/augmentedrealitynews.org/)
      end

      def get_content
        @content = @page.at('div.content-wrapper')

        @content.search('.author-social').remove
        super
      end
    end
  end
end
