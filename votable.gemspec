$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "votable/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "votable"
  s.version     = Votable::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Votable."
  s.description = "TODO: Description of Votable."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.3"
  #s.add_dependency "orm_adapter", "~> 0.1.0"
end
