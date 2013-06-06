module Splintable
  module Generators
    class MediumGenerator < BasicGenerator
      def get_type
        @type_match = true if @url.match(/medium.com/)
      end

      def get_content
        @content = @page.at('div.post-content')
        @content.search('.other-collections').remove

        super
      end

      def get_cover_image
        post_image = @page.at('img.post-header-image-contain')
        if post_image
          @images[:cover_image] = post_image[:src]
        else
          super
        end
      end
    end
  end
end
