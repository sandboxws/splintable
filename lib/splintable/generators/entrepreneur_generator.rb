module Splintable
  module Generators
    class EntrepreneurGenerator < BasicGenerator
      def get_type
        @type_match = true if @url.match(/entrepreneur.com/)
      end

      def get_content
        @content = @page.at('#article')
        @content.search('.cb').remove

        super
      end
    end
  end
end
