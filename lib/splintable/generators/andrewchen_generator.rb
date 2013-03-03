module Splintable
  module Generators
    class AndrewchenGenerator < BasicGenerator
      def get_type
        @type_match = true if @url.match(/andrewchen.co/)
      end

      def get_content
        @content = @page.at('div.main')
        @content.search('h2:first').remove

        super
      end
    end
  end
end
