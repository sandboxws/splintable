module Splintable
  module Generators
    class AppstormGenerator < BasicGenerator
      def get_type
        @type_match = true if @url.match(/appstorm.net/)
      end

      def get_content
        @content = @page.at('div.entry')

        @content.search('div.postmetadata h1').remove
        @content.search('#bookmarks_wrap').remove
        @content.search('#tabs').remove

        super
      end
    end
  end
end
