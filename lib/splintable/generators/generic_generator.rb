module Splintable
  module Generators
    class GenericGenerator < BasicGenerator
      def get_type
        @type_match = true
      end

      def get_content
        @content = @page.at('.journal-entry-text')
        @content = @page.at('.post') if @content.nil?
        @content = @page.at('#post') if @content.nil?
        @content = @page.at('.post-wrap') if @content.nil?
        @content = @page.at('.post-box') if @content.nil?
        @content = @page.at('.article') if @content.nil?
        @content = @page.at('.page-body') if @content.nil?
        @content = @page.at('section.content') if @content.nil?
        @content = @page.at('section.container') if @content.nil?
        @content = @page.at('section.main') if @content.nil?
        @content = @page.at('section.post') if @content.nil?
        @content = @page.at('section') if @content.nil?
        @content = @page.at('#content') if @content.nil?
        @content = @page.at('.content') if @content.nil?
        @content = @page.at('#main') if @content.nil?
        @content = @page.at('.main') if @content.nil?

        @content.search('h1:first').remove

        super
      end
    end
  end
end
