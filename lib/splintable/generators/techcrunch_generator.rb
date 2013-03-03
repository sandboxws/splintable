module Splintable
  module Generators
    class TechcrunchGenerator < BasicGenerator
      def get_type
        @type_match = true if @url.match(/techcrunch.com/)
      end

      def get_content
        @content = @page.at('div.post')
        @content = @page.at('div#module-post-detail') if @content.nil?
        @content.search('h1:first').remove

        super
      end
    end
  end
end
