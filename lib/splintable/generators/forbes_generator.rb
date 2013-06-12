module Splintable
  module Generators
    class ForbesGenerator < BasicGenerator
      def get_type
        @type_match = true if @url.match(/forbes.com/)
      end

      def get_content
        @content = @page.at('#leftRail')
        @content.search('.event_tracking_scroll_latch has_been_triggered').remove
        @content.search('.related_searches').remove
        @content.search('.comment_bug').remove
        @content.search('.article_actions').remove
        @content.search('.article_lower').remove
        @content.search('.video_promo_block').remove
        @content.search('#comments').remove

        super
      end
    end
  end
end
