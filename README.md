# PlexSubtitleCleaner

A very simple gem that cleans Plex subtitles of advertising and other garbage.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'plex_subtitle_cleaner'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install plex_subtitle_cleaner

## Usage

Run it in your Mac terminal. It assumes the path to your library as: '$HOME/Library/Application Support/Plex Media Server/Media'

    $ ./bin/plex_subtitle_cleaner [-f ]

I plan to allow passing the path at some point.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/plex_subtitle_cleaner/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
