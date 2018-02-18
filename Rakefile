require 'foodcritic'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

FoodCritic::Rake::LintTask.new do |task|
  task.options = { :fail_tags => ['any'], :tags => ['~FC007', '~FC052', '~FC064', '~FC065', '~FC066'] }
end

task :default => [ :foodcritic, :spec ]
