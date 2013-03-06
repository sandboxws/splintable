module Splintable
  module Generators
    class AlistapartGenerator < BasicGenerator
      def get_type
        @type_match = true if @url.match(/alistapart.com/)
      end

      def get_content
        @content = @page.at('.main-content')
        @content.search('aside').remove

        super
      end

      def get_cover_image
        wide_hero = @page.at('figure')
        if wide_hero
          @images[:cover_image] = wide_hero.at('img')['src']
        else
          super
        end
      end
    end
  end
end
