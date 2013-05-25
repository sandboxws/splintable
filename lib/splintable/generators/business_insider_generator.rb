module Splintable
  module Generators
    class BusinessInsiderGenerator < BasicGenerator
      def preprocess_url
        if @url.match /\?/
          @url += '&op=1'
        else @url += '?op=1'
        end
      end

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
