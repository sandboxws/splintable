module Splintable
  module Generators
    class WisebreadGenerator < BasicGenerator
      def get_type
        @type_match = true if @url.match(/wisebread.com/)
      end

      def get_content
        @content = @page.at('.node .body')

        super
      end
    end
  end
end
