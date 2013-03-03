module Splintable
  module Generators
    class MashableGenerator < BasicGenerator
      def get_type
        @type_match = true if @url.match(/mashable.com/)
      end

      def get_content
        @content = @page.at('div.post')
        @content = @page.at('div#post-slider') if @content.nil?
        @content.search('h1:first').remove
        @content.search('.article-content h1:first').remove

        super
      end
    end
  end
end
