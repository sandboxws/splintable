module Splintable
  module Generators
    class SitepointGenerator < BasicGenerator
      def get_type
        @type_match = true if @url.match(/sitepoint.com/)
      end

      def get_content
        @content = @page.at('.post')
        @content.search('h1:first').remove
        @content.search('.wp-about-author-containter-around').remove
        @content.search('#sharebarx').remove
        @content.search('#sharebar').remove
        @content.search('#similar_posts').remove

        super
      end
    end
  end
end
