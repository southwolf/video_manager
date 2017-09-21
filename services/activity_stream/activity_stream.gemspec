$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'activity_stream/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'activity_stream'
  s.version     = ActivityStream::VERSION
  s.authors     = ['acopquin']
  s.email       = ['acopquin@xogrp.com']
  s.homepage    = 'http://github.com'
  s.summary     = 'activity stream microservice'
  s.description = 'manages Latest activity on videos and comments CRUD'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'rails', '~> 5.1.3'
  s.add_dependency 'mongoid', '~> 6.1.0'

  s.add_development_dependency 'rspec-rails', '~> 3.5'
  s.add_development_dependency 'faker'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'factory_girl_rails', '~> 4.0'
  s.add_development_dependency 'byebug'
end
