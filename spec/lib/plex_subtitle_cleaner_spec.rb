require 'spec_helper'
require 'midwire_common/string'

module PlexSubtitleCleaner
  RSpec.describe Cleaner, type: :lib do

    let(:opts) do
      {
      }
    end
    let(:instance) { Cleaner.new(opts) }

    let(:test1) do
      s = <<-string.here_with_pipe("\r\n")
        |1
        |00:00:05,000 --> 00:00:15,000
        |Created and Encoded by --  Bokutox -- of  www.YIFY-TORRENTS.com. The Best 720p/1080p/3d movies with the lowest file size on the internet.
        |
        |2
        |00:00:16,000 --> 00:00:22,074
        |Subtitles downloaded from www.OpenSubtitles.org
        |Check out www.filebot.net today ;)\255
        |
        |3
        |00:00:50,000 --> 00:00:55,000
        |Resync: Xenzai[NEF]
        |Subtitles by: Reklame
        |
        |4
        |00:01:05,591 --> 00:01:10,562
        |Only time can teach us what
        |is truth and what is legend.
        |
        |5
        |00:01:05,591 --> 00:01:10,562
        |Sync by
        |is truth and what is legend.
      string
      s.force_encoding('UTF-8')
    end

    context '.clean' do
      it 'removes CRAP_TEXT' do
        result = instance.clean(test1)
        CRAP_TEXT.each do |regex|
          expect(result.match(regex)).to eq(nil)
        end
      end
    end

    context '.clean_file' do
      let(:test_file1) do
        '/Users/cblackburn/Library/Application Support/Plex Media Server/Media/localhost/a/9723f3a373dd4c759d50a9bc6d9eeafb1b2061b.bundle/Contents/Subtitles/en/com.plexapp.agents.opensubtitles_e013fa7858bf9964666b6a02ff820eb81bbdf86d.srt'
      end

      let(:test_file2) do
        '/Users/cblackburn/Library/Application Support/Plex Media Server/Media/localhost/a/9723f3a373dd4c759d50a9bc6d9eeafb1b2061b.bundle/Contents/Subtitles/en/com.plexapp.agents.opensubtitles_26b8e75fa43b75bb8ac6cc0291b68a8f6aadf799.srt'
      end

      let(:test_file3) do
        '/Users/cblackburn/Library/Application Support/Plex Media Server/Media/localhost/a/9723f3a373dd4c759d50a9bc6d9eeafb1b2061b.bundle/Contents/Subtitles/en/com.plexapp.agents.opensubtitles_4a4a43d32d44252271cb96c6e9076aa97021a4dc.srt'
      end

      it 'cleans a single file' do
        instance.clean_file(test_file1)
        instance.clean_file(test_file2)
        instance.clean_file(test_file3)
      end
    end

  end
end
