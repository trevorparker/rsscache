require 'open-uri'
require 'time'

module RSSCache
  # Fetches an RSS or Atom feed.
  class Fetcher
    # Returns the content of a Feed; one of RSS::Rss or RSS::Atom.
    attr_reader :content

    # Returns the HTTP status of the last request.
    attr_reader :status

    # Returns the `Last-Modified` response header received, if any.
    attr_reader :last_modified

    # Returns the `etag` response header recieved, if any.
    attr_reader :etag

    # Returns or sets the URL to fetch.
    attr_accessor :url

    ##
    # Creates a new instance of Fetcher.

    def initialize(args = {})
      @url ||= args[:url]
    end

    ##
    # Fetches the RSS or Atom URL and places the feed content in
    # #content.

    def fetch
      @content = open(url, request_headers) do |f|
        parse_headers f
        f.read
      end
    rescue OpenURI::HTTPError => e
      @status = e.message[/^\d{3}/].to_i
      (@content && @status == 304) ? (return @content) : (raise e)
    end

    private

    def parse_headers(f)
      @status = f.status[0].to_i
      @last_modified = f.last_modified.httpdate if f.last_modified
      @etag = f.meta['etag'] if f.meta['etag']
    end

    def request_headers
      h = { 'User-Agent' => RSSCache::UserAgent::STRING }
      h['If-None-Match'] = @etag if @etag
      h['If-Modified-Since'] = @last_modified if @last_modified

      h
    end
  end
end
