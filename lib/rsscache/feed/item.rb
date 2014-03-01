module RSSCache
  class Feed
    # A single RSS or Atom item/entry.
    class Item
      # Returns either an RSS::Rss::Item or RSS::Atom::Entry depending
      # on the #type of feed.
      attr_reader :item

      # Returns the feed type of an item; one of `rss` or `atom`.
      attr_reader :type

      ##
      # Creates a new instance of Item.

      def initialize(args = {})
        @item ||= args[:item]
        @type ||= args[:type]
      end

      ##
      # Returns the Item's ID or GUID.

      def id
        id = type == 'rss' ? item.guid.content : item.id.content
        id ? id.strip : ''
      end

      alias_method :guid, :id

      ##
      # Returns the Item's title.

      def title
        title = type == 'rss' ? item.title : item.title.content
        title ? title.strip : ''
      end

      ##
      # Returns the Item's author name.

      def author
        author = type == 'rss' ? item.author : item.author.name.content
        author ? author.strip : ''
      end

      ##
      # Returns the Item's link.

      def link
        link = type == 'rss' ? item.link : item.link.href
        link || ''
      end

      ##
      # Returns the Item's published date.

      def published
        published = type == 'rss' ? item.date : item.published.content
        published ? published : nil
      end

      alias_method :pubdate, :published

      ##
      # Returns the Item's updated date; if no updated date is available,
      # it returns the Item's published date.

      def updated
        return published if type == 'rss'
        item.updated.content ? item.updated.content : nil
      end

      ##
      # Returns the Item's description or summary.

      def description
        description = type == 'rss' ? item.description : item.summary
        description || ''
      end

      alias_method :summary, :description
    end
  end
end
