module Splintable
  module Generators
    class BloggerGenerator < BasicGenerator
      def get_type
        generator = @page.at('meta[@name="generator"]')
        if generator
          content = generator['content'].downcase
          @type_match = true if content.match(/blogger/i)
        end

        if !@type_match
          @page.search('link[rel="stylesheet"]').each do |link|
            if link['href'].match /blogger.com/
              @type_match = true
              break
            end
          end
        end

        @type_match
      end

      def get_content
        @content = @page.at('div.post')
        @content = @page.at('div.article') if @content.nil?
        @content.search('.date-outer').remove
        @content.search('.post-header').remove
        @content.search('.article-header').remove
        @content.search('.article-footer').remove

        super
      end
    end
  end
end
