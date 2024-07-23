$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'futurex_rails/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'futurex_rails'
  s.version     = FutureXRails::VERSION
  s.authors     = ['Talha Ijaz']
  s.email       = ['talhaijaz123451@gmail.com']
  s.homepage    = 'https://github.com/talhaijaz/futurex_rails'
  s.summary     = 'FutureX API wrapper'
  # s.description = 'Abstracted Autotask API 1.5 wrapper'

  s.files = Dir['{app,config,db,lib}/**/*', 'Rakefile', 'README.md']

  s.add_dependency 'rest-client'
end
