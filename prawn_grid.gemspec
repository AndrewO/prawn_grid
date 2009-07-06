Gem::Specification.new do |s|
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