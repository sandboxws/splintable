module Splintable
  module Generators
    class TutsplusGenerator < BasicGenerator
      def get_type
        @type_match = true if @url.match(/tutsplus.com/)
      end

      def get_content
        @content = @page.at('div#page')

        @content.search('h1.post_title').remove

        @content.search('.tut_bottom').remove
        @content.search('.post_footer').remove
        @content.search('.extra_posts').remove
        @content.search('.discus-note').remove
        @content.search('.comments').remove
        @content.search('#tag-list').remove

        super
      end
    end
  end
end
