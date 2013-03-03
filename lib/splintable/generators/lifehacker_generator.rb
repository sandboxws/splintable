module Splintable
  module Generators
    class LifehackerGenerator < BasicGenerator
      def get_type
        @type_match = true if @url.match(/lifehacker.com/)
      end

      def get_content
        post_selector = '.post-body'

        # remove first h1
        if @page.at("#{post_selector} h1")
          @page.at("#{post_selector} h1").remove
        end

        @page.search('.nodebyline.modfont').remove
        @content = @page.at(post_selector)

        super
      end

      def get_cover_image
        @images[:cover_image] = @page.at('.illustration.top').at('img')[:src]
      end
    end
  end
end
