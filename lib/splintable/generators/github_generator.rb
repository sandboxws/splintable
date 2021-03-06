module Splintable
  module Generators
    class GithubGenerator < BasicGenerator
      def get_type
        @type_match = true if @url.match(/github.com/)
      end

      def get_content
        @content = @page.at('#readme')
        @content = @page.at('.container') if @content.nil?
        @content.search('h1:first').remove
        @content.search('span.name').remove

        super
      end

      def get_description
        super
        if @description.nil? || @description.empty?
          @description = !@page.at('#repository_description').nil? ? @page.at('#repository_description').inner_text : nil
        end
      end
    end
  end
end
