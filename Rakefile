require 'foodcritic'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

FoodCritic::Rake::LintTask.new do |task|
  task.options = {
    :fail_tags => ['any'],
    :tags => ['~FC007', '~FC052', '~FC064', '~FC065', '~FC066', '~FC121', '~FC122'],
    :context => true,
    :chef_version => '12.6.0'
  }
end

task :default => [ :foodcritic, :spec ]
