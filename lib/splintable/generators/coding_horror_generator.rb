module Splintable
  module Generators
    class CodingHorrorGenerator < BasicGenerator
      def get_type
        @type_match = true if @url.match(/codinghorror.com/)
      end

      def get_content
        @content = @page.at('.blogbody')
        @content.search('h2:first').remove
        @content.search('.footernav').remove
        @content.search('.nrelate_related_placeholder').remove

        super
      end
    end
  end
end
