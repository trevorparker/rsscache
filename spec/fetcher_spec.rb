require 'spec_helper'

describe(RSSCache::Fetcher) do
  let(:last_modified_feed_url) { 'http://test.trevorparker.com/rss.xml' }
  let(:etag_feed_url) { 'https://github.com/trevorparker.atom' }

  it 'can stash Last-Modified header' do
    f = RSSCache::Fetcher.new(url: last_modified_feed_url)
    f.fetch
    expect(f.last_modified).to be_a String
  end

  it 'can stash etag' do
    f = RSSCache::Fetcher.new(url: etag_feed_url)
    f.fetch
    expect(f.etag).to be_a String
  end

  it 'can pass If-Modified-Since and honor 304 Not Modified response' do
    f = RSSCache::Fetcher.new(url: last_modified_feed_url)
    2.times { f.fetch }
    expect(f.status).to eq 304
  end

  it 'can pass If-None-Match and honor 304 Not Modified response' do
    f = RSSCache::Fetcher.new(url: etag_feed_url)
    2.times { f.fetch }
    expect(f.status).to eq 304
  end
end
