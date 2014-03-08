require 'simple-rss'

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
        RSSCache::Feed::Item.new item: i
      end
    end

    ##
    # Returns the Feed's link.

    def link
      content.channel.link
    end

    ##
    # Returns the Feed's title.

    def title
      content.channel.title
    end

    ##
    # Updates the Feed.

    def update
      @fetcher.fetch
      @content = SimpleRSS.parse @fetcher.content
    end
  end
end
