module Splintable
  module Generators
    class BasicGenerator
      IMAGE_WIDTH = 400
      attr_reader :page, :url,
        :content, :raw_content,
        :title, :description,
        :images, :type_match

      def initialize(url, page)
        @url = url
        @page = page
        @images = {cover_image: nil, post: []}
      end

      def init
        self.get_type
        if @type_match
          self.get_content
          self.get_title
          self.get_description
          self.get_images
          self.post_handling
        end
      end

      def get_type
        puts '>>>> super'
      end

      def type_match?
        @type_match
      end

      def get_title
        @title = @page.title
      end

      def get_description
        @content.search('p').each do |p|
          if p && p.inner_text && !p.inner_text.empty? && p.inner_text.size > 100
            @description = p.inner_text.gsub(/\n/, '<br>')
            break
          end
        end
      end

      def get_content
        self.remove_common_nodes
        @raw_content = @content.to_s
      end

      def get_images
        self.get_post_images
        self.get_cover_image
      end

      def get_cover_image
        fb_image = @page.at('meta[@property="og:image"]')
        fb_image_size = FastImage.size(URI.encode(fb_image[:content]), { raise_on_failure: false, timeout: 3 }) if fb_image
        fb_image_size = [] if fb_image_size.nil?

        meta_image = @page.at('link[@rel="image_src"]')
        meta_image_size = FastImage.size(URI.encode(meta_image[:href]), { raise_on_failure: false, timeout: 3 }) if meta_image
        meta_image_size = [] if meta_image_size.nil?

        if fb_image_size && fb_image_size.size == 2 && fb_image_size[0] >= IMAGE_WIDTH
          @images[:cover_image] = fb_image[:content]
        elsif meta_image_size && meta_image_size.size == 2 && meta_image_size[0] >= IMAGE_WIDTH
          @images[:cover_image] = meta_image[:href]
        else
          @images[:cover_image] = @images[:post].first
        end
      end

      def get_post_images
        @content.search('img').each do |img|
          puts ">>> #{img[:src]}"
          image_size = FastImage.size(URI.encode(img[:src]), {
            raise_on_failure: false, timeout: 3
          }) if img[:src] && img[:src].match(/^http/)
          @images[:post] << img['src'] if image_size && image_size.size == 2 && image_size[0] >= IMAGE_WIDTH
        end
      end

      def remove_common_nodes
        @page.search('*').each do |node|
          node.remove if node['class'] && node['class'].match(/title/)
          node.remove if node['class'] && node['class'].match(/post_head/)
          node.remove if node['class'] && node['class'].match(/post_type/)
          node.remove if node['class'] && node['class'].match(/post-date/)
          node.remove if node['class'] && node['class'].match(/post_date/)
          node.remove if node['class'] && node['class'].match(/post-categories/)
          node.remove if node['class'] && node['class'].match(/post_categories/)
          node.remove if node['class'] && node['class'].match(/post-info/)
          node.remove if node['class'] && node['class'].match(/article-info/)
          node.remove if node['class'] && node['class'].match(/meta/)
          node.remove if node['class'] && node['class'].match(/sociable/)
          node.remove if node['class'] && node['class'].match(/social4i/)
          node.remove if node['class'] && node['class'].match(/socialbox/)
          node.remove if node['class'] && node['class'].match(/socialbox-container/)
          node.remove if node['class'] && node['class'].match(/socialmedia/)
          node.remove if node['class'] && node['class'].match(/seperator/)
          node.remove if node['class'] && node['class'].match(/subscribe/)
          node.remove if node['class'] && node['class'].match(/comments-section/)
          node.remove if node['class'] && node['class'].match(/comments/)
          node.remove if node['class'] && node['class'].match(/commentwrap/)
          node.remove if node['class'] && node['class'].match(/about-section/)
          node.remove if node['class'] && node['class'].match(/about-box/)
          node.remove if node['class'] && node['class'].match(/addthis/)
          node.remove if node['class'] && node['class'].match(/fb_iframe_widget/)
          node.remove if node['class'] && node['class'].match(/wp-biographia/)
          node.remove if node['class'] && node['class'].match(/fb-recommendations/)
          node.remove if node['class'] && node['class'].match(/post-meta/)
          node.remove if node['class'] && node['class'].match(/byline/)
          node.remove if node['class'] && node['class'].match(/share/)
          node.remove if node['class'] && node['class'].match(/related/)
          node.remove if node['class'] && node['class'].match(/related-posts/)
          node.remove if node['class'] && node['class'].match(/pagination/)
          node.remove if node['class'] && node['class'].match(/prevnext/)
          node.remove if node['class'] && node['class'].match(/post-nav/)
          node.remove if node['class'] && node['class'].match(/paging/)
          node.remove if node['class'] && node['class'].match(/module-crunchbase/)
          node.remove if node['class'] && node['class'].match(/first_ad/)
          node.remove if node['class'] && node['class'].match(/post_ad/)
          node.remove if node['class'] && node['class'].match(/\bad\b/)
          node.remove if node['class'] && node['class'].match(/\badv\b/)
          node.remove if node['class'] && node['class'].match(/\badvertisement\b/)
          node.remove if node['class'] && node['class'].match(/sBF_banner/)
          node.remove if node['class'] && node['class'].match(/twitter-follow-button/)
          node.remove if node['class'] && node['class'].match(/social_heading/)
          node.remove if node['class'] && node['class'].match(/breadcrumb/)
          node.remove if node['class'] && node['class'].match(/breadcrumbs/)
          node.remove if node['class'] && node['class'].match(/wprp_wrapper/)
          node.remove if node['class'] && node['class'].match(/post_taxonomy/)
          node.remove if node['class'] && node['class'].match(/ct-post-prev/)
          node.remove if node['class'] && node['class'].match(/ct-post-next/)
          node.remove if node['class'] && node['class'].match(/entryDate/)
          node.remove if node['class'] && node['class'].match(/entryTags/)
          node.remove if node['class'] && node['class'].match(/tag-links/)
          node.remove if node['class'] && node['class'].match(/entryCategories/)
          node.remove if node['class'] && node['class'].match(/entryExtra/)
          node.remove if node['class'] && node['class'].match(/social_bookmarking_module/)
          node.remove if node['class'] && node['class'].match(/newsletterPost/)
          node.remove if node['class'] && node['class'].match(/printfriendly/)
          node.remove if node['class'] && node['class'].match(/ts-fab-wrapper/)
          node.remove if node['class'] && node['class'].match(/WgtBody208/)
          node.remove if node['class'] && node['class'].match(/WgtBorder208/)
          node.remove if node['class'] && node['class'].match(/WgtBorder208/)
          node.remove if node['class'] && node['class'].match(/theSinglePostMetabox/)
          node.remove if node['class'] && node['class'].match(/scribol/)
          node.remove if node['class'] && node['class'].match(/documentTags/)
          node.remove if node['class'] && node['class'].match(/documentCreatorHistory/)
          node.remove if node['style'] && node['style'].match(/display:\s?none/)
          node.remove if node['style'] && node['style'].match(/clear: both;/)
          node.remove if node['id'] && node['id'].match(/showSomeLove/)
          node.remove if node['id'] && node['id'].match(/postAuthorBox/)
          node.remove if node['id'] && node['id'].match(/share-post/)
          node.remove if node['id'] && node['id'].match(/sharebar/)
          node.remove if node['id'] && node['id'].match(/wdshare-share-box/)
          node.remove if node['id'] && node['id'].match(/wdsb-share-box/)
          node.remove if node['id'] && node['id'].match(/postinfo/)
          node.remove if node['id'] && node['id'].match(/breadcrumbs/)
          node.remove if node['id'] && node['id'].match(/livefyre/)
          node.remove if node['id'] && node['id'].match(/premium/)
          node.remove if node['id'] && node['id'].match(/disqus/)
          node.remove if node['id'] && node['id'].match(/respond/)
          node.remove if node['id'] && node['id'].match(/reply/)
          node.remove if node['id'] && node['id'].match(/comments/)
          node.remove if node['id'] && node['id'].match(/scrollbarbox/)
          node.remove if node['id'] && node['id'].match(/related-posts/)
          node.remove if node['id'] && node['id'].match(/ts-fab-below/)
          node.remove if node['id'] && node['id'] == 'footer'
          node.remove if node.name == 'script'
          node.remove if node.name == 'rdf'
          node.remove if node.name == 'footer'
          node.remove if node.name == 'aside'
          node.remove if node.name == 'br'
          node.remove if node.name == 'a' && node['href'] && node['href'].match(/addtoany/)
          node.remove if node.name == 'a' && node['href'] && node['href'].match(/bs.serving-sys.com/)
          node.remove if node.name == 'iframe' && node['src'] && node['src'].match(/facebook/)
          node.remove if node.name == 'iframe' && node['src'] && node['src'].match(/instapaper/)
          node.remove if node.name == 'iframe' && node['src'] && node['src'].match(/widgets\.awe\.sm/)
          node.remove if node.name == 'iframe' && node['src'] && node['src'].match(/widgets\.fbshare\.me/)

          if node.name == 'p'
            text = node.text
            if text
              text.strip!
              node.remove if text.empty? && node.children.size == 0
            end
          end
          node.remove if node.text.match(/comments/i) && ['h1', 'h2', 'h3', 'h4', 'h5', 'h6'].include?(node.name)
          #node.remove if node.text.size == 0 && node.text.blank? && node.children.size == 0


          node['onclick'] = '' if node['onclick']
          node['width'] = '' if node['width']
          node['height'] = '' if node['height']
          node['id'] = '' if node['id']
          node['class'] = '' if node['class']

          if node.name == 'pre'
            if node.attributes['class']
              node.attributes['class'].value = 'prettyprint'
            else
              node.set_attribute 'class', 'prettyprint'
            end
          end

          if node.attributes['style']
            node.attributes['style'].value = ''
          end

          if node.name == 'iframe' &&
            node.attributes['width'] &&
            node['src'] &&
            node['src'].match(/youtube\.com|vimeo\.com|blip\.tv|viddler\.com|kickstarter\.com|googleads/)
            node.attributes['width'].value = '100%'
            node['class'] = 'external-vid'
          end

          if node.name == 'img' && node['data-lazy-src']
            node['src'] = node['data-lazy-src']
          end
        end
      end

      def post_handling
        #@raw_content = @raw_content.gsub(/(.*)class="[a-zA-Z_\s+]+"(.*)/, '\1\2').gsub(/\s+/, ' ')
        #@raw_content = @raw_content.gsub(/(.*)id="[a-zA-Z_\s+]+"(.*)/, '\1\2').gsub(/\s+/, ' ')

        convert_relative_paths
      end

      def convert_relative_paths
        @raw_content = @raw_content.gsub(/(href=\")(\/.*)\"/, '\1' + "http://#{URI.parse(@url).host}" + '\2' + '"')
        @raw_content = @raw_content.gsub(/(src=\")(\/.*)\"/, '\1' + "http://#{URI.parse(@url).host}" + '\2' + '"')
      end
    end
  end
end
