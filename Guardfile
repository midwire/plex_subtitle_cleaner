# rubocop:disable Style/RegexpLiteral
CLI = 'bundle exec rspec --format doc --color'

def rspec_watchers
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})           { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch(%r{^providers/(.+)\.rb$})     { |m| "spec/providers/#{m[1]}_spec.rb" }
  watch(%r{^spec/support/(.+)\.rb$})  { 'spec' }
  watch('spec/spec_helper.rb')        { 'spec' }
end

guard :rspec, cmd: CLI do
  rspec_watchers
end
# rubocop:enable Style/RegexpLiteral
