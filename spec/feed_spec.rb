require 'spec_helper'

describe(RSSCache::Feed) do
  it 'can load an RSS feed' do
    expect(@rss_feed).to be_a RSSCache::Feed
  end

  it 'can load an Atom feed' do
    expect(@rss_feed).to be_a RSSCache::Feed
  end

  it %q{can provide an RSS feed's title} do
    expect(@rss_feed.title).to be_a String
  end

  it %q{can provide an Atom feed's title} do
    expect(@atom_feed.title).to be_a String
  end

  it %q{can provide an RSS feed's link} do
    expect(@rss_feed.link).to be_a String
  end

  it %q{can provide an Atom feed's link} do
    expect(@atom_feed.link).to be_a String
  end

  it 'reuses a fetcher instead of making a new one' do
    rss = RSSCache::Feed.new url: @rss_feed_url
    fetcher_object_id_1 = rss.fetcher.object_id
    rss.update
    fetcher_object_id_2 = rss.fetcher.object_id
    expect(fetcher_object_id_1).to eq(fetcher_object_id_2)
  end

  it 'raises RSSCache::Feed::FormatError on non-RSS and non-Atom feeds' do
    error = RSSCache::Feed::FormatError
    expect { RSSCache::Feed.new url: @xml_feed_url }.to raise_error(error)
  end
end
