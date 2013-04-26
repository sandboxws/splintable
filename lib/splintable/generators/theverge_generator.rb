module Splintable
  module Generators
    class ThevergeGenerator < BasicGenerator
      def get_type
        @type_match = true if @url.match(/theverge.com/)
      end

      def get_content
        @content = @page.at('div.article-body')
        @content.search('h1:first').remove
        @content.search('.wp-about-author-containter-around').remove
        @content.search('#sharebarx').remove
        @content.search('#sharebar').remove
        @content.search('#similar_posts').remove

        super
      end

      def get_cover_image
        cover_image = @page.at('div.story-image img')
        if cover_image
          @images[:cover_image] = cover_image[:src]
        else
          super
        end
      end
    end
  end
end
