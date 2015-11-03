$LOAD_PATH.unshift(File.expand_path('../lib', __FILE__))
$LOAD_PATH.unshift(File.expand_path('../app', __FILE__))
$LOAD_PATH.unshift(File.expand_path('../middleware', __FILE__))

ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __FILE__)
ENV['RAILS_ENV'] ||= 'development'
require 'bundler/setup'

require 'yaml'
require 'sequel'
require 'steno'
require 'cloud_controller'
require_relative 'lib/tasks/rake_config'

Dir['lib/tasks/**/*.rake'].each do |tasks|
  load tasks
end

Rails.application.load_tasks

task default: ['spec:all', :rubocop_autocorrect]

task :rubocop_autocorrect do
  require 'rubocop'
  cli = RuboCop::CLI.new
  exit_code = cli.run(%w(--auto-correct))
  exit(exit_code) if exit_code != 0
end
