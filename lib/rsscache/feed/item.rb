module RSSCache
  class Feed
    # A single RSS or Atom item/entry.
    class Item
      # Returns either an RSS::Rss::Item or RSS::Atom::Entry depending
      # on the #type of feed.
      attr_reader :item

      ##
      # Creates a new instance of Item.

      def initialize(args = {})
        @item ||= args[:item]
      end

      ##
      # Returns the Item's ID or GUID.

      def id
        item.id ? item.id.strip : ''
      end

      alias_method :guid, :id

      ##
      # Returns the Item's title.

      def title
        item.title ? item.title.strip : ''
      end

      ##
      # Returns the Item's author name.

      def author
        item.author ? item.author.strip : ''
      end

      ##
      # Returns the Item's link.

      def link
        item.link ? item.link.strip : ''
      end

      ##
      # Returns the Item's published date.

      def published
        item.pubDate || item.published
      end

      alias_method :pubdate, :published

      ##
      # Returns the Item's updated date; if no updated date is available,
      # it returns the Item's published date.

      def updated
        item.updated ? item.updated : published
      end

      ##
      # Returns the Item's description or summary.

      def description
        item.description ? item.description.strip : ''
      end

      alias_method :summary, :description

      ##
      # Returns the Item's contents.

      def contents
        item.contents ? item.contents.strip : description
      end

      ##
      # Returns the Item's comments link.

      def comments
        item.comments ? item.comments.strip : ''
      end
    end
  end
end
