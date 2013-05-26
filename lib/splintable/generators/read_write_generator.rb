module Splintable
  module Generators
    class ReadWriteGenerator < BasicGenerator
      def get_type
        @type_match = true if @url.match(/readwrite.com/)
      end

      def get_content
        @content = @page.at('#article-container')
        @content.search('#article-header-primary-meta').remove
        @content.search('.posted-in').remove
        @content.search('#article-social-bottom').remove
        @content.search('#article-author').remove
        @content.search('#article-ads').remove
        @content.search('#article-comments').remove
        @content.search('#article-fader').remove

        super
      end
    end
  end
end
