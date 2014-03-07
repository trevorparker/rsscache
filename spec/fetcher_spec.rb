require 'spec_helper'

describe(RSSCache::Fetcher) do
  let(:last_modified_feed_url) { 'http://example.com/mock-rss-304.xml' }
  let(:etag_feed_url) { 'http://example.com/mock-atom-304.xml' }

  it 'can stash Last-Modified header' do
    f = RSSCache::Fetcher.new url: @rss_feed_url
    f.fetch
    expect(f.last_modified).to be_a String
  end

  it 'can stash etag' do
    f = RSSCache::Fetcher.new url: @atom_feed_url
    f.fetch
    expect(f.etag).to be_a String
  end

  it 'can honor a 304 Not Modified response' do
    f = RSSCache::Fetcher.new url: last_modified_feed_url
    2.times { f.fetch }
    expect(FakeWeb.last_request['If-Modified-Since']).to eq @mock_last_modified
    expect(f.status).to eq 304
  end

  it 'can honor a 304 Not Modified response' do
    f = RSSCache::Fetcher.new url: etag_feed_url
    2.times { f.fetch }
    expect(FakeWeb.last_request['If-None-Match']).to eq @mock_etag
    expect(f.status).to eq 304
  end
end
