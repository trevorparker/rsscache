require 'open-uri'
require 'time'

module RSSCache
  # Fetches an RSS or Atom feed
  class Fetcher
    attr_reader :content, :status, :last_modified, :etag, :rss
    attr_accessor :url

    def initialize(args = {})
      @url ||= args[:url]
    end

    def fetch
      begin
        @content = open(url, request_headers) do |f|
          parse_headers f
          f.read
        end
      rescue OpenURI::HTTPError => e
        @status = e.message[/^\d{3}/].to_i
        (@content && @status == 304) ? (return @content) : (raise e)
      end

      @content
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
