require 'rss'

module RSSCache
  # An RSS or Atom feed
  class Feed
    attr_reader :feed, :fetcher
    attr_accessor :url

    def initialize(args = {})
      @url     ||= args[:url]
      @fetcher ||= RSSCache::Fetcher.new url: url
      update
    end

    def items
      feed.items.map do |i|
        RSSCache::Feed::Item.new item: i, type: feed.feed_type
      end
    end

    def link
      feed.feed_type == 'rss' ? feed.channel.link : feed.link.href
    end

    def title
      feed.feed_type == 'rss' ? feed.channel.title : feed.title.content
    end

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
