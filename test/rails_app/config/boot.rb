require 'rubygems'
gemfile = File.expand_path('../../../../Gemfile', __FILE__)

unless defined?(VOTABLE_ORM)
  VOTABLE_ORM = (ENV['VOTABLE_ORM'] || :active_record).to_sym
end


if File.exist?(gemfile)
  ENV['BUNDLE_GEMFILE'] = gemfile
  require 'bundler'
  Bundler.setup
end

$:.unshift File.expand_path('../../../../lib', __FILE__)
