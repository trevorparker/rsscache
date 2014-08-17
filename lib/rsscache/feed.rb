require 'simple-rss'

module RSSCache
  # An RSS or Atom feed.
  class Feed
    # Maximum number of seconds an update will return a
    # cached response.
    MAX_STALENESS = 900

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
      update(true)
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
      content.channel.link ? content.channel.link.strip : ''
    end

    ##
    # Returns the Feed's title.

    def title
      content.channel.title ? content.channel.title.strip : ''
    end

    ##
    # Returns the Feed's subtitle.

    def subtitle
      content.channel.subtitle ? content.channel.subtitle.strip : ''
    end

    ##
    # Returns the Feed's staleness.

    def staleness
      Time.now - @last_fetched
    end

    ##
    # Updates the Feed.

    def update(force = false)
      if force || staleness > MAX_STALENESS
        @fetcher.fetch
        @content = SimpleRSS.parse @fetcher.content
        @last_fetched = Time.now
      end
      true
    end
  end
end
