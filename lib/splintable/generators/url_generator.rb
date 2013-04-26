module Splintable
  module Generators
    class UrlGenerator
      attr_reader :page

      def initialize(url)
        @url = url
        @agent = Mechanize.new
        @type_match = false
      end

      def get_readable
        self.scrap_content
        self.generators.each do |gen|
          generator = eval("Splintable::Generators::#{gen}Generator").new(@url, @page)
          generator.init
          puts "#{generator.type_match} >>>> #{gen}"
          if generator.type_match?
            @readable = Splintable::Readable.new(generator)
            break
          end
        end

        @readable
      end

      def scrap_content
        @page = @agent.get @url
        @url = PostRank::URI.clean( PostRank::URI.normalize(@page.uri.to_s).to_s )
      end

      def generators
        [
          'Smashingmagazine',
          'Andrewchen',
          'Appstorm',
          'Tutsplus',
          'Marco',
          'Tutorialzine',
          'SoundworksCollection',
          'Techcrunch',
          'Mashable',
          'Webappers',
          'Lifehacker',
          'TheNextWeb',
          'Github',
          'Alistapart',
          'Noupe',
          'Sitepoint',
          'Veerle',
          'Wisebread',
          'Entrepreneur',
          'CodingHorror',
          'Blogger',
          'Theverge',
          'WordpressDotCom',
          'Wordpress',
          'Generic',
          #'drupal',
          #'joomla',
          #'cnn'
        ]
      end
    end
  end
end
