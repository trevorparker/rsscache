require 'rss'

module RSSCache
  # An RSS feed
  class Feed
    attr_accessor :url

    def initialize(args = {})
      @url ||= args[:url]
      update
    end

    def link
      @feed.feed_type == 'rss' ? @feed.channel.link : @feed.link.href
    end

    def title
      @feed.feed_type == 'rss' ? @feed.channel.title : @feed.title.content
    end

    def update
      f = RSSCache::Fetcher.new url: url
      @feed = RSS::Parser.parse f.fetch
    end
  end
end
