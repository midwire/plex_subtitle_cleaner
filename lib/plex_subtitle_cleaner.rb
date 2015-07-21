require 'plex_subtitle_cleaner/version'
require 'fileutils'
require 'pry'
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
    include FileUtils

    def self.run(*_args)
      start_time = Time.now
      opts = collect_options

      instance = Cleaner.new(opts)
      instance.process
      instance.elapsed = Time.now - start_time
      instance.report_summary
    end

    attr_accessor :options, :elapsed

    def initialize(opts)
      self.options = opts
      @file_count = 0
    end

    def report_summary
      puts
      puts(">>> Processed #{@file_count.to_i} files in [#{elapsed}] seconds".yellow)
    end

    def process
      puts(">>> Processing... 1 dot == 100 files.")
      if options[:file]
        clean_file(options[:file])
      else
        clean_directory(options[:path])
      end
    end

    def clean_directory(start_dir)
      cd(start_dir)
      Dir.glob('**/*.srt').each do |sub|
        clean_file(sub)
      end
      puts
    end

    def clean_file(filepath)
      # open file and remove the crap
      print('.') if @file_count % 100 == 0
      @file_count += 1
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
          puts(">>> Found #{md[0]}".yellow)
          result.gsub!(regex, ' ')
        end
      end
      result
    end

    private

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
      end
    end

    def self.starting_directory
      path = Pathname.new(ENV['HOME'])
      path.join('Library/Application Support/Plex Media Server/Media')
    end
  end
end
