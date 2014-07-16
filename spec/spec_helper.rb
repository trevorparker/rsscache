require 'fakeweb'
require 'rsscache'

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  config.before(:all) do
    @mock_last_modified = 'Sat, 15 Feb 2014 19:31:13 GMT'
    @mock_etag = '49e2e8b303e355ff5302feb5ffe2baa2'

    mock_rss_feed = File.read(
      File.join(File.dirname(__FILE__), 'fixtures', 'rss.xml')
    )
    mock_atom_feed = File.read(
      File.join(File.dirname(__FILE__), 'fixtures', 'atom.xml')
    )
    mock_sitemap = File.read(
      File.join(File.dirname(__FILE__), 'fixtures', 'sitemap.xml')
    )

    FakeWeb.register_uri(
      :get, 'http://example.com/mock-rss.xml',
      body: mock_rss_feed,
      last_modified: @mock_last_modified
    )
    FakeWeb.register_uri(
      :get, 'http://example.com/mock-atom.xml',
      body: mock_atom_feed,
      etag: @mock_etag
    )
    FakeWeb.register_uri(
      :get, 'http://example.com/sitemap.xml',
      body: mock_sitemap
    )

    FakeWeb.register_uri(
      :get, 'http://example.com/mock-rss-304.xml',
      [
        {
          body: mock_rss_feed,
          last_modified: @mock_last_modified
        },
        { status: ['304', 'Not Modified'] }
      ]
    )

    FakeWeb.register_uri(
      :get, 'http://example.com/mock-atom-304.xml',
      [
        {
          body: mock_atom_feed,
          etag: @mock_etag
        },
        { status: ['304', 'Not Modified'] }
      ]
    )
    @rss_feed_url  = 'http://example.com/mock-rss.xml'
    @atom_feed_url = 'http://example.com/mock-atom.xml'
    @xml_feed_url  = 'http://example.com/sitemap.xml'

    @rss_feed = RSSCache::Feed.new url: @rss_feed_url
    @atom_feed = RSSCache::Feed.new url: @atom_feed_url
  end
end
