module Splintable
  module Generators
    class AlistapartGenerator < BasicGenerator
      def get_type
        @type_match = true if @url.match(/alistapart.com/)
      end

      def get_content
        @content = @page.at('.main-content')
        @content.search('aside').remove

        super
      end
    end
  end
end
