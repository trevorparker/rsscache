require 'spec_helper'

describe(RSSCache::Feed::Item) do
  before(:all) do
    @rss_items = @rss_feed.items
    @atom_items = @atom_feed.items
  end

  it 'can load RSS items' do
    expect(@rss_items[0]).to be_a RSSCache::Feed::Item
  end

  it 'can load Atom items' do
    expect(@atom_items[0]).to be_a RSSCache::Feed::Item
  end

  it %q{can provide an RSS item's title} do
    expect(@rss_items[0].title).to be_a String
  end

  it %q{can provide an Atom item's title} do
    expect(@atom_items[0].title).to be_a String
  end

  it %q{can provide an RSS item's author} do
    expect(@rss_items[0].author).to be_a String
  end

  it %q{can provide an Atom item's author} do
    expect(@atom_items[0].author).to be_a String
  end

  it %q{can provide an RSS item's link} do
    expect(@rss_items[0].link).to be_a String
  end

  it %q{can provide an Atom item's link} do
    expect(@atom_items[0].link).to be_a String
  end

  it %q{can provide an RSS item's published date} do
    expect(@rss_items[0].published).to be_a Time
  end

  it %q{can provide an Atom item's published date} do
    expect(@atom_items[0].published).to be_a Time
  end

  it %q{can provide an RSS item's updated date} do
    expect(@rss_items[0].updated).to be_a Time
  end

  it %q{can provide an Atom item's updated date} do
    expect(@atom_items[0].updated).to be_a Time
  end
end
