module RSSCache
  class Feed
    class Item
      attr_reader :item, :type

      def initialize(args = {})
        @item ||= args[:item]
        @type ||= args[:type]
      end

      def title
        title = type == 'rss' ? item.title : item.title.content
        title || ''
      end

      def author
        author = type == 'rss' ? item.author : item.author.name.content
        author || ''
      end

      def link
        link = type == 'rss' ? item.link : item.link.href
        link || ''
      end
    end
  end
end
