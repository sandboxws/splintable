module Splintable
  module Generators
    class IgnGenerator < BasicGenerator
      def get_type
        @type_match = true if @url.match(/ign.com/)
      end

      def get_content
        @content = @page.at('.article')
        @content.search('h1:first').remove
        @content.search('#article-toolbar').remove
        @content.search('.article-byline').remove
        @content.search('.article-more').remove
        @content.search('.article-meta').remove
        @content.search('#banner_below_post').remove

        super
      end
    end
  end
end
