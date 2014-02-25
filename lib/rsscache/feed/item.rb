module RSSCache
  class Feed
    # A single RSS or Atom item/entry
    class Item
      attr_reader :item, :type

      def initialize(args = {})
        @item ||= args[:item]
        @type ||= args[:type]
      end

      def id
        id = type == 'rss' ? item.guid.content : item.id.content
        id || ''
      end

      alias_method :guid, :id

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

      alias_method :pubdate, :published

      def updated
        return published if type == 'rss'
        item.updated.content ? item.updated.content : nil
      end

      def description
        description = type == 'rss' ? item.description : item.summary
        description || ''
      end

      alias_method :summary, :description
    end
  end
end
