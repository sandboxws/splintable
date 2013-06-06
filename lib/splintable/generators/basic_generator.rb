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
          self.get_cover_image
          self.get_content
          self.get_title
          self.get_description
          self.get_post_images
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
          node.remove if node['class'] && node['class'].match(/sidebar/i)
          node.remove if node['class'] && node['class'].match(/boilerplate/i)
          node.remove if node['class'] && node['class'].match(/title/i)
          node.remove if node['class'] && node['class'].match(/post_head/i)
          node.remove if node['class'] && node['class'].match(/post_type/i)
          node.remove if node['class'] && node['class'].match(/post-date/i)
          node.remove if node['class'] && node['class'].match(/post_date/i)
          node.remove if node['class'] && node['class'].match(/post-categories/i)
          node.remove if node['class'] && node['class'].match(/post_categories/i)
          node.remove if node['class'] && node['class'].match(/post-info/i)
          node.remove if node['class'] && node['class'].match(/post-footer-actions/i)
          node.remove if node['class'] && node['class'].match(/author/i)
          node.remove if node['class'] && node['class'].match(/article-info/i)
          node.remove if node['class'] && node['class'].match(/article-meta/i)
          node.remove if node['class'] && node['class'].match(/meta/)
          ['twitter', 'facebook', 'pinterest',
           'linkedin', 'googleplus', 'stumbleupon'].each do |sn|
            node.remove if node['class'] && node['class'].match(/#{sn}/i)
          end
          node.remove if node['class'] && node['class'].match(/sociable/i)
          node.remove if node['class'] && node['class'].match(/social4i/i)
          node.remove if node['class'] && node['class'].match(/socialbox/i)
          node.remove if node['class'] && node['class'].match(/socialbox-container/i)
          node.remove if node['class'] && node['class'].match(/socialmedia/i)
          node.remove if node['class'] && node['class'].match(/seperator/i)
          node.remove if node['class'] && node['class'].match(/subscribe/i)
          node.remove if node['class'] && node['class'].match(/comments-section/i)
          node.remove if node['class'] && node['class'].match(/comments/i)
          node.remove if node['class'] && node['class'].match(/commentwrap/i)
          node.remove if node['class'] && node['class'].match(/about-section/i)
          node.remove if node['class'] && node['class'].match(/about-box/i)
          node.remove if node['class'] && node['class'].match(/addthis/i)
          node.remove if node['class'] && node['class'].match(/fb_iframe_widget/i)
          node.remove if node['class'] && node['class'].match(/wp-biographia/i)
          node.remove if node['class'] && node['class'].match(/fb-recommendations/i)
          node.remove if node['class'] && node['class'].match(/post-meta/i)
          node.remove if node['class'] && node['class'].match(/byline/i)
          node.remove if node['class'] && node['class'].match(/share/i)
          node.remove if node['class'] && node['class'].match(/sharing/i)
          node.remove if node['class'] && node['class'].match(/related/i)
          node.remove if node['class'] && node['class'].match(/related-posts/i)
          node.remove if node['class'] && node['class'].match(/pagination/i)
          node.remove if node['class'] && node['class'].match(/prevnext/i)
          node.remove if node['class'] && node['class'].match(/post-nav/i)
          node.remove if node['class'] && node['class'].match(/paging/i)
          node.remove if node['class'] && node['class'].match(/module-crunchbase/i)
          node.remove if node['class'] && node['class'].match(/first_ad/i)
          node.remove if node['class'] && node['class'].match(/post_ad/i)
          node.remove if node['class'] && node['class'].match(/\bad\b/i)
          node.remove if node['class'] && node['class'].match(/\badv\b/i)
          node.remove if node['class'] && node['class'].match(/\badvertisement\b/i)
          node.remove if node['class'] && node['class'].match(/sBF_banner/i)
          node.remove if node['class'] && node['class'].match(/twitter-follow-button/i)
          node.remove if node['class'] && node['class'].match(/social_heading/i)
          node.remove if node['class'] && node['class'].match(/breadcrumb/i)
          node.remove if node['class'] && node['class'].match(/breadcrumbs/i)
          node.remove if node['class'] && node['class'].match(/wprp_wrapper/i)
          node.remove if node['class'] && node['class'].match(/post_taxonomy/i)
          node.remove if node['class'] && node['class'].match(/ct-post-prev/i)
          node.remove if node['class'] && node['class'].match(/ct-post-next/i)
          node.remove if node['class'] && node['class'].match(/entryDate/i)
          node.remove if node['class'] && node['class'].match(/tags/i)
          node.remove if node['class'] && node['class'].match(/tag-links/i)
          node.remove if node['class'] && node['class'].match(/entryCategories/i)
          node.remove if node['class'] && node['class'].match(/entryExtra/i)
          node.remove if node['class'] && node['class'].match(/entry-options/i)
          node.remove if node['class'] && node['class'].match(/social_bookmarking_module/i)
          node.remove if node['class'] && node['class'].match(/newsletterPost/i)
          node.remove if node['class'] && node['class'].match(/printfriendly/i)
          node.remove if node['class'] && node['class'].match(/ts-fab-wrapper/i)
          node.remove if node['class'] && node['class'].match(/WgtBody208/i)
          node.remove if node['class'] && node['class'].match(/WgtBorder208/i)
          node.remove if node['class'] && node['class'].match(/WgtBorder208/i)
          node.remove if node['class'] && node['class'].match(/theSinglePostMetabox/i)
          node.remove if node['class'] && node['class'].match(/scribol/i)
          node.remove if node['class'] && node['class'].match(/documentCreatorHistory/i)
          node.remove if node['style'] && node['style'].match(/display:\s?none/)
          node.remove if node['style'] && node['style'].match(/clear: both;/)
          node.remove if node['id'] && node['id'].match(/tags/i)
          node.remove if node['id'] && node['id'].match(/showSomeLove/)
          node.remove if node['id'] && node['id'].match(/author/i)
          node.remove if node['id'] && node['id'].match(/share-post/i)
          node.remove if node['id'] && node['id'].match(/wdshare-share-box/i)
          node.remove if node['id'] && node['id'].match(/wdsb-share-box/i)
          node.remove if node['id'] && node['id'].match(/postinfo/i)
          node.remove if node['id'] && node['id'].match(/breadcrumbs/i)
          node.remove if node['id'] && node['id'].match(/livefyre/i)
          node.remove if node['id'] && node['id'].match(/premium/i)
          node.remove if node['id'] && node['id'].match(/disqus/i)
          node.remove if node['id'] && node['id'].match(/respond/i)
          node.remove if node['id'] && node['id'].match(/reply/i)
          node.remove if node['id'] && node['id'].match(/comments/i)
          node.remove if node['id'] && node['id'].match(/scrollbarbox/i)
          node.remove if node['id'] && node['id'].match(/related-posts/i)
          node.remove if node['id'] && node['id'].match(/related/i)
          node.remove if node['id'] && node['id'].match(/wpi-related/i)
          node.remove if node['id'] && node['id'].match(/ts-fab-below/i)
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
