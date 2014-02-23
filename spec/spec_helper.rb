require 'rsscache'

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  config.before(:all) do
    rss_feed_url = 'http://test.trevorparker.com/rss.xml'
    atom_feed_url = 'https://github.com/trevorparker.atom'
    @rss_feed = RSSCache::Feed.new url: rss_feed_url
    @atom_feed = RSSCache::Feed.new url: atom_feed_url
  end
end
