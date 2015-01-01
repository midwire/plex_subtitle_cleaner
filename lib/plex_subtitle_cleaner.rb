require 'plex_subtitle_cleaner/version'
require 'fileutils'
require 'pry'
require 'colored'
require 'trollop'

module PlexSubtitleCleaner
  CRAP_TEXT = [
    /^.*opensubtitles.*$/i,
    /^.*synced and corrected.*$/i,
    /^.*fixed and synced.*$/i,
    /^.*created .* by .*$/i,
    /^.*resync:.*/i,
    /^.*subtitles by:.*/i,
    /^.*\;\).*$/i,
    /^.*\:\).*$/i,
    /^.+subtitles/i,
    /^.+www\.filebot.*$/
  ]

  def self.root
    Pathname.new(File.dirname(__FILE__)).parent
  end

  class Cleaner
    include FileUtils

    def self.run(*args)
      start_time = Time.now
      opts = Trollop.options do
        opt(:file, 'A single subtitle file to clean', type: :string, short: 'f', required: false)
      end

      instance = Cleaner.new(opts)
      instance.process
      instance.elapsed = Time.now - start_time
      instance.report_summary
    end

    attr_accessor :options, :elapsed, :file_count

    def initialize(opts)
      self.options    = opts
      self.file_count = 0
    end

    def report_summary
      puts
      puts(">>> Processed #{file_count.to_i} files in [#{elapsed}] seconds".yellow)
    end

    def process
      if options[:file]
        clean_file(options[:file])
      else
        clean_directory
      end
    end

    def clean_directory(start_dir = starting_directory)
      cd(start_dir)
      Dir.glob('**/*.srt').each do |sub|
        clean_file(sub)
      end
    end

    def clean_file(filepath)
      # open file and remove the crap
      puts(">>> #{filepath}".yellow)
      contents = clean(File.read(filepath))
      File.open(filepath, 'w') { |f| f.write(contents) }
    end

    def clean(content)
      result = content.dup.encode('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')
      CRAP_TEXT.each do |regex|
        result.gsub!(regex, ' ')
      end
      result
    end

    private

    def starting_directory
      path = Pathname.new(ENV['HOME'])
      path = path.join('Library/Application Support/Plex Media Server/Media')
    end
  end
end
