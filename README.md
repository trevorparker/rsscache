rsscache
========

[![Build Status](http://img.shields.io/travis/trevorparker/rsscache.svg)](https://travis-ci.org/trevorparker/rsscache)

An RSS fetching and caching library.

Usage
-----

The most direct way to use rsscache is by loading up an RSS or Atom feed:

```ruby
require 'rsscache'
url = 'https://github.com/trevorparker/rsscache/commits/master.atom'
feed = RSSCache::Feed.new url: url
```

`RSSCache::Feed` exposes metadata about the feed itself with `#title` and `#link`. You can update a feed with `#update`.

Feed items/entries (`RSSCache::Feed::Item`) are available with `#items`. Each item exposes `#id`, `#title`, `#author`, `#link`, `#published`, `#updated`, and `#description`. Aliases for more familiar RSS- or Atom-specific terminology are also available (e.g.: `#pubdate`, `#summary`).

Caching
-------

The long-term goal of rsscache is to provide a simple and intuitive interface to fetching and consuming RSS and Atom feeds.

Currently, caching is extremely lazy and simply relies on a `304` response code from the server to indicate that the content has not changed.

Eventually, other factors will weigh in on whether or not to do an HTTP request at all. For instance, the update frequency of a feed or the publication date of the most recent item relative to the current time may influence whether or not a hard pull is needed.

The goal for any sort of aggressive caching at this level is to remove the need to think about *updating*. Rather, update operations will be interwoven with listing operations so that lazy-updating of feeds can happen.

The ability to manually update or to forcefully refresh the cache will always be available.

License
-------

rsscache is released under the 3-clause "Modified" BSD License. See `LICENSE.txt`.
