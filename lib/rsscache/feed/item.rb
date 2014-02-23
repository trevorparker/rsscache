module RSSCache
  class Feed
    # A single RSS or Atom item/entry
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

      def published
        published = type == 'rss' ? item.date : item.published.content
        published ? published : nil
      end

      def updated
        return published if type == 'rss'
        item.updated.content ? item.updated.content : nil
      end
    end
  end
end
