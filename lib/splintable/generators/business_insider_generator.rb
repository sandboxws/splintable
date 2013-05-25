module Splintable
  module Generators
    class BusinessInsiderGenerator < BasicGenerator
      def get_type
        @type_match = true if @url.match(/businessinsider.com/)
      end

      def get_content
        @content = @page.at('#content')
        @content.search('.post-top').remove

        super
      end
    end
  end
end
