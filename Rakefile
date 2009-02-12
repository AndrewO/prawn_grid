begin
  require 'rubygems'
rescue LoadError
end
require 'rake'
require 'rake/testtask'
require "rake/rdoctask"
require 'rake/gempackagetask'

PRAWN_GRID_VERSION = '0.4.1'

desc 'Run all tests'
Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = Dir["test/*_test.rb"]
  t.verbose = true
end

desc "Genrate documentation"
Rake::RDocTask.new do |rdoc|
  rdoc.rdoc_files.include( "README",
                           "LICENSE", 
                           "lib/" )
  rdoc.main     = "README"
  rdoc.rdoc_dir = "doc/html"
  rdoc.title    = "Prawn Grid Documentation"
end

spec = Gem::Specification.new do |s|
  s.name = "prawn_grid"
  s.version = PRAWN_GRID_VERSION
  s.platform = Gem::Platform::RUBY
  s.summary = "A simple way to build grid layouts for Prawn"
  s.files = Dir.glob("{examples,lib,test}/**/*") + ["Rakefile"]
  s.require_path = "lib"
  s.add_dependency("prawn")
  s.test_files = Dir["test/*_test.rb"]
  s.has_rdoc = true
  s.rdoc_options << '--title' << 'Prawn Grid Documentation' <<
                       '--main'  << 'README' << '-q'
  s.author = "Andrew O'Brien"
  s.email = "andrew@econify.com"
  s.homepage = "http://github.com/AndrewO/prawn_grid"
  s.description = <<END_DESC
Prawn grid adds functionality to prawn to enable easy access to Page Grid coordinates
END_DESC
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.need_zip = true
  pkg.need_tar = true
end