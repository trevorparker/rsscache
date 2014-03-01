require 'rss'

module RSSCache
  # An RSS or Atom feed.
  class Feed
    # Returns the Feed content; one of RSS::Rss or RSS::Atom.
    attr_reader :content

    # Returns the RSSCache::Fetcher for the Feed.
    attr_reader :fetcher

    # Returns or sets the URL for the Feed.
    attr_accessor :url

    ##
    # Creates a new instance of Feed.

    def initialize(args = {})
      @url     ||= args[:url]
      @fetcher ||= RSSCache::Fetcher.new url: url
      update
    end

    ##
    # Returns the Feed's items/entries in the for of an array of
    # RSSCache::Feed::Item.

    def items
      content.items.map do |i|
        RSSCache::Feed::Item.new item: i, type: content.feed_type
      end
    end

    ##
    # Returns the Feed's link.

    def link
      content.feed_type == 'rss' ? content.channel.link : content.link.href
    end

    ##
    # Returns the Feed's title.

    def title
      return content.channel.title if content.feed_type == 'rss'
      content.title.content
    end

    ##
    # Updates the Feed.

    def update
      @fetcher.fetch
      @content = RSS::Parser.parse @fetcher.content
      unless @content && %w{rss atom}.include?(@content.feed_type)
        fail FormatError, 'Unsupported feed format'
      end
    end

    FormatError = Class.new(StandardError)
  end
end
