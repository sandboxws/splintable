module Splintable
  module Generators
    class VeerleGenerator < BasicGenerator
      def get_type
        @type_match = true if @url.match(/veerle.duoh.com/)
      end

      def get_content
        @content = @page.at('#the-article')
        @content.search('h1:first').remove
        @content.search('.header .date').remove
        @content.search('.header .info-actions').remove
        @content.search('.article-footer').remove
        @content.search('.art-nav').remove
        @content.search('#high-contrast').remove
        @content.search('#art-cmts-switch').remove
        @content.search('#thedeck').remove

        super
      end
    end
  end
end
