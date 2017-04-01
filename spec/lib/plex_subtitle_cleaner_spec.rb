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
      path = File.join(PlexSubtitleCleaner.root, 'spec', 'fixtures', 'crapsubs.srt')
      s = File.read(path)
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
        File.join(PlexSubtitleCleaner.root, 'spec', 'fixtures', 'test1.srt')
      end

      it 'cleans a single file' do
        instance.clean_file(test_file1)
      end
    end

  end
end
