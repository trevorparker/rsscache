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
end
