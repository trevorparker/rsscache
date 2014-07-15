require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

desc 'RSSCache spec'
RSpec::Core::RakeTask.new(:spec)

desc 'Validate against rubocop'
RuboCop::RakeTask.new(:rubocop) do |task|
  task.fail_on_error = true
end

task default: [:spec, :rubocop]
