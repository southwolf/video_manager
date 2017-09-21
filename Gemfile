source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.4.1'
gem 'rails', '~> 5.1.3'
gem 'puma', '~> 3.7'
gem 'mongoid', '~> 6.1.0'
gem 'aws-sdk-sns', '~> 1'
gem 'okcomputer', '1.16.0'
gem 'wisper', '2.0.0'
gem 'wisper-celluloid', '0.0.1'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 3.5'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'faker'
  gem 'database_cleaner'
  gem 'wisper-rspec'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# services
gem 'videos', path: 'services/videos'
gem 'comments', path: 'services/comments'
# gem 'activity_stream', path: 'services/activity_stream'