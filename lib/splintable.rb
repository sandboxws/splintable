require 'mechanize'
require 'postrank-uri'
require 'fastimage'

module Splintable
    autoload :Readable, "splintable/readable"

    def self.readable(url)
      Splintable::Generators::UrlGenerator.new(url).get_readable
    end

  module Generators
    autoload :UrlGenerator, "splintable/generators/url_generator"
    autoload :BasicGenerator, "splintable/generators/basic_generator"
    autoload :WordpressGenerator, "splintable/generators/wordpress_generator"
    autoload :WordpressDotComGenerator, "splintable/generators/wordpress_dot_com_generator"
    autoload :WebappersGenerator, "splintable/generators/webappers_generator"
    autoload :TechcrunchGenerator, "splintable/generators/techcrunch_generator"
    autoload :MashableGenerator, "splintable/generators/mashable_generator"
    autoload :SmashingmagazineGenerator, "splintable/generators/smashingmagazine_generator"
    autoload :AndrewchenGenerator, "splintable/generators/andrewchen_generator"
    autoload :AppstormGenerator, "splintable/generators/appstorm_generator"
    autoload :TutsplusGenerator, "splintable/generators/tutsplus_generator"
    autoload :MarcoGenerator, "splintable/generators/marco_generator"
    autoload :LifehackerGenerator, "splintable/generators/lifehacker_generator"
    autoload :TutorialzineGenerator, "splintable/generators/tutorialzine_generator"
    autoload :SoundworksCollectionGenerator, "splintable/generators/soundworks_collection_generator"
    autoload :GithubGenerator, "splintable/generators/github_generator"
    autoload :TheNextWebGenerator, "splintable/generators/the_next_web_generator"
    autoload :AlistapartGenerator, "splintable/generators/alistapart_generator"
    autoload :NoupeGenerator, "splintable/generators/noupe_generator"
    autoload :SitepointGenerator, "splintable/generators/sitepoint_generator"
    autoload :VeerleGenerator, "splintable/generators/veerle_generator"
    autoload :WisebreadGenerator, "splintable/generators/wisebread_generator"
    autoload :EntrepreneurGenerator, "splintable/generators/entrepreneur_generator"
    autoload :CodingHorrorGenerator, "splintable/generators/coding_horror_generator"
    autoload :BloggerGenerator, "splintable/generators/blogger_generator"
    autoload :GenericGenerator, "splintable/generators/generic_generator"
  end
end
