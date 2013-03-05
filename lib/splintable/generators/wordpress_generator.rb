module Splintable
  module Generators
    class WordpressGenerator < BasicGenerator
      def get_type
        generator = @page.at('meta[@name="generator"]')
        if generator
          content = generator['content'].downcase
          if content != 'wordpress.com'
            @type_match = true if content.match(/wordpress/i)
          end
        end

        if !@type_match
          @page.search('link[rel="stylesheet"]').each do |link|
            if link['href'].match /wp-content/
              @type_match = true
              break
            end
          end
        end

        @type_match
      end

      def get_content
        @content = @page.at('div.post')
        @content = @page.at('div.entry') if @content.nil?
        @content = @page.at('div#single') if @content.nil?
        @content = @page.at('div.post-wrapper') if @content.nil?
        @content = @page.at('.post-box') if @content.nil?
        @content = @page.at('div#content') if @content.nil?
        @content = @page.at('article') if @content.nil?
        @content = @page.at('.boxLeft') if @content.nil?
        @content = @page.at('div#main') if @content.nil?
        @content = @page.at('div.article-single') if @content.nil?

        @content.search('h1:first').remove
        @content.search('h2:first').remove
        @content.search('.navigation').remove
        @content.search('.social-media').remove
        @content.search('.post-social').remove
        @content.search('.ratingblock').remove
        @content.search('.post_page_navigation').remove
        @content.search('.post-meta').remove
        @content.search('.homepage-widget').remove

        super
      end
    end
  end
end
