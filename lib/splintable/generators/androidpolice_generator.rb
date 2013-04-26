module Splintable
  module Generators
    class AndroidpoliceGenerator < BasicGenerator
      def get_type
        @type_match = true if @url.match(/androidpolice.com/)
      end

      def get_content
        @content = @page.at('.post_content')
        super
      end
    end
  end
end
