require 'spec_helper'

describe(RSSCache::Feed) do
  before(:all) do
    rss_feed_url = 'http://test.trevorparker.com/rss.xml'
    atom_feed_url = 'https://github.com/trevorparker.atom'
    @rss_feed = RSSCache::Feed.new url: rss_feed_url
    @atom_feed = RSSCache::Feed.new url: atom_feed_url
  end

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
end
