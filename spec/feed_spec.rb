require 'spec_helper'

describe(RSSCache::Feed) do
  it 'can load an RSS feed' do
    expect(@rss_feed).to be_a RSSCache::Feed
  end

  it 'can load an Atom feed' do
    expect(@atom_feed).to be_a RSSCache::Feed
  end

  it "can provide an RSS feed's items" do
    expect(@rss_feed.items).to be_a Array
    expect(@rss_feed.items[0]).to be_a RSSCache::Feed::Item
  end

  it "can provide an Atom feed's items" do
    expect(@atom_feed.items).to be_a Array
    expect(@atom_feed.items[0]).to be_a RSSCache::Feed::Item
  end

  it "can provide an RSS feed's title" do
    expect(@rss_feed.title).to be_a String
  end

  it "strips leading and trailing whitespace from an RSS feed's title" do
    expect(@rss_feed.title).to eq @rss_feed.title.strip
  end

  it "can provide an Atom feed's title" do
    expect(@atom_feed.title).to be_a String
  end

  it "strips leading and trailing whitespace from an Atom feed's title" do
    expect(@atom_feed.title).to eq @atom_feed.title.strip
  end

  it "can provide empty string as an RSS feed's subtitle" do
    expect(@rss_feed.subtitle).to be_a String
    expect(@rss_feed.subtitle).to eq ''
  end

  it "can provide an Atom feed's subtitle" do
    expect(@atom_feed.subtitle).to be_a String
  end

  it "strips leading and trailing whitespace from an Atom feed's subtitle" do
    expect(@atom_feed.subtitle).to eq @atom_feed.subtitle.strip
  end

  it "can provide an RSS feed's link" do
    expect(@rss_feed.link).to be_a String
  end

  it "strips leading and trailing whitespace from an RSS feed's link" do
    expect(@rss_feed.link).to eq @rss_feed.link.strip
  end

  it "can provide an Atom feed's link" do
    expect(@atom_feed.link).to be_a String
  end

  it "strips leading and trailing whitespace from an Atom feed's link" do
    expect(@atom_feed.link).to eq @atom_feed.link.strip
  end

  it 'reuses a fetcher instead of making a new one' do
    rss = RSSCache::Feed.new url: @rss_feed_url
    fetcher_object_id_1 = rss.fetcher.object_id
    rss.update
    fetcher_object_id_2 = rss.fetcher.object_id
    expect(fetcher_object_id_1).to eq(fetcher_object_id_2)
  end
end
