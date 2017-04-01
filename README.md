# PlexSubtitleCleaner

A very simple gem that cleans Plex subtitles of advertising and other garbage.

## So What!

If you are a [Plex](https://www.plex.tv/) user, you may have noticed the subtitles that get downloaded from [opensubtitles.org](https://opensubtitles.org) often have annoying advertisements for websites or *"Subtitles By MeBecauseINeedValidation"* as the movie or TV show plays.  This gem simply removes that garbage so you don't have to see it.

## Installation

    $ gem install plex_subtitle_cleaner

## Usage

Run it in your Mac terminal (Windows is untested but let me know how it goes). It defaults the path to your library as: '$HOME/Library/Application Support/Plex Media Server/Media' (MacOS). **NOTE: Any Winblows user out there who wants to tell me the default directory for Plex subtitles, and I'll set the default when running Windows so you don't have to pass it on the command line.**

    $ ./bin/plex_subtitle_cleaner [-fpvh]

    $ ./bin/plex_subtitle_cleaner --help
    Options:
      -f, --file=<s>    A single subtitle file to clean
      -p, --path=<s>    Path to the root subtitle directory (default: /Users/cblackburn/Library/Application Support/Plex Media Server/Media)
      -v, --verbose     Be verbose with output
      -h, --help        Show this message

To set the path:

    $ ./bin/plex_subtitle_cleaner -p /Users/myname/mypath

To clean a single file:

    $ ./bin/plex_subtitle_cleaner -f /Users/myname/mypath/mysubtitle.srt

## Contributing

1. Fork it ( https://github.com/midwire/plex_subtitle_cleaner/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
