Gem::Specification.new do |s|
  s.version = "0.0.3"
  s.date = %q{2008-12-15}
 
  s.name = %q{meta_tags}
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Linking Paths", "Aitor Garcia"]
  s.description = %q{Get your xHTML meta tags in control.}
  s.email = %q{aitor@linkingpaths.com}
  s.files = ['lib', 'lib/meta_tags.rb', 'MIT-LICENSE', 'rails', 'rails/init.rb', 'Rakefile', 'README.md', 'test', 'test/meta_tags_test.rb']
  
  s.homepage = %q{http://github.com/linkingpaths/meta_tags}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.2.0}
  s.summary = %q{Get your xHTML meta tags in control.}
  s.has_rdoc = true
  
  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2
  end
end
