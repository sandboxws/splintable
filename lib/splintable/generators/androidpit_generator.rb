module Splintable
  module Generators
    class AndroidpitGenerator < BasicGenerator
      def get_type
        @type_match = true if @url.match(/androidpit.com/)
      end

      def get_content
        @content = @page.at('.entry-content')
        super
      end
    end
  end
end
