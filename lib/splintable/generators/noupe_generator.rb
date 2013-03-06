module Splintable
  module Generators
    class NoupeGenerator < BasicGenerator
      def get_type
        @type_match = true if @url.match(/noupe.com/)
      end

      def get_content
        @content = @page.at('.post')
        @content.search('h1:first').remove
        @content.search('.date').remove
        @content.search('.post-details').remove
        @content.search('#contentadcontainer').remove
        @content.search('#acom').remove
        @content.search('#commentadcontainer').remove
        @content.search('h2').each do |h2|
          h2.remove if h2.inner_text == 'Comments and Discussions'
        end

        super
      end
    end
  end
end
