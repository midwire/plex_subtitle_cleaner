require 'plex_subtitle_cleaner/version'
require 'colored'
require 'trollop'

module PlexSubtitleCleaner
  CRAP_TEXT = [
    /^.*<font.*$/i,
    /^.*opensubtitles.*$/i,
    /^.*sync.+$/i,
    /^.*created .* by .*$/i,
    /^.*resync:.*/i,
    /^.*subtitle.*/i,
    /^.*T.?U.?S.?U.?B.?T.?I.?T.?U.?L.?O*/i,
    /^.*subs from.*/i,
    /^.*subs by.*/i,
    /^.*sourced by.*/i,
    /^.*\;\).*$/i,
    /^.*\:\).*$/i,
    /^.+subtitles/i,
    /^.*www\..*$/
  ]

  def self.root
    Pathname.new(File.dirname(__FILE__)).parent
  end

  class Cleaner
    # include FileUtils

    def self.run(*_args)
      start_time = Time.now
      opts = collect_options

      instance = Cleaner.new(opts)
      instance.process
      instance.elapsed = Time.now - start_time
      instance.report_summary
    end

    def self.collect_options
      dir = starting_directory
      Trollop.options do
        opt(
          :file,
          'A single subtitle file to clean',
          type: :string,
          short: 'f',
          required: false)
        opt(
          :path,
          'Path to the root subtitle directory',
          type: :string,
          short: 'p',
          default: dir.to_s,
          required: false)
        opt(
          :verbose,
          'Be verbose with output',
          type: :boolean,
          required: false,
          short: '-v',
          default: false)
      end
    end

    def self.starting_directory
      path = Pathname.new(ENV['HOME'])
      # Default path on a Mac computer
      path.join('Library/Application Support/Plex Media Server/Media')
    end

    attr_accessor :options, :elapsed

    def initialize(opts)
      self.options = opts
      @file_count = 0
    end

    def report_summary
      puts
      puts("Processed #{@file_count.to_i} files in [#{elapsed}] seconds".yellow)
    end

    def process
      puts('Starting PlexSubtitleCleaner'.green)
      puts('Processing... 1 dot == 100 files, x == cleaned subtitles.')
      if options[:file]
        clean_file(options[:file])
      else
        clean_directory(options[:path])
        puts
      end
    end

    def clean_directory(start_dir)
      path = File.join(start_dir, '**', '*.srt')
      Dir.glob(path).each do |sub|
        clean_file(sub)
      end
    end

    def clean_file(filepath)
      # open file and remove the crap
      print('.') if @file_count % 100 == 0
      @file_count += 1
      return nil unless File.exist?(filepath)
      contents = clean(File.read(filepath))
      File.open(filepath, 'w') { |f| f.write(contents) }
    end

    def clean(content)
      result = content.dup.encode(
        'UTF-8', 'binary', invalid: :replace, undef: :replace, replace: ''
      )
      CRAP_TEXT.each do |regex|
        md = result.match(regex)
        if md
          print('x'.yellow)
          puts(">>> Found #{md[0]}".yellow) if options[:verbose]
          result.gsub!(regex, ' ')
        end
      end
      result
    end
  end
end
