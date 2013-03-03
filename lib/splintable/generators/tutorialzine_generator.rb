module Splintable
  module Generators
    class TutorialzineGenerator < BasicGenerator
      def get_type
        @type_match = true if @url.match(/tutorialzine.com/)
      end

      def get_content
        @content = @page.at('#main')

        @content.search('h1:first').remove
        @content.search('#postAuthor').remove
        @content.search('#topMiniShare').remove
        @content.search('#author-info').remove
        @content.search('#newsletterSubscribe').remove
        @content.search('#relatedSection').remove
        @content.search('#comments').remove
        @content.search('#respond').remove

        super
      end

      def get_cover_image
        meta_image = @page.at('link[@rel="image_src"]')
        if meta_image
          @images[:cover_image] = meta_image[:href].gsub(/\/posts\//, '/featured/')
        else
          super
        end
      end
    end
  end
end
