require 'rss'

module RSSCache
  # An RSS or Atom feed.
  class Feed
    # Returns the Feed content; one of RSS::Rss or RSS::Atom.
    attr_reader :feed

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
      feed.items.map do |i|
        RSSCache::Feed::Item.new item: i, type: feed.feed_type
      end
    end

    ##
    # Returns the Feed's link.

    def link
      feed.feed_type == 'rss' ? feed.channel.link : feed.link.href
    end

    ##
    # Returns the Feed's title.

    def title
      feed.feed_type == 'rss' ? feed.channel.title : feed.title.content
    end

    ##
    # Updates the Feed.

    def update
      @fetcher.fetch
      @feed = RSS::Parser.parse @fetcher.content
      unless @feed && %w{rss atom}.include?(@feed.feed_type)
        fail FormatError, 'Unsupported feed format'
      end
    end

    FormatError = Class.new(StandardError)
  end
end
