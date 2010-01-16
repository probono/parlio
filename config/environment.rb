I_KNOW_I_AM_USING_AN_OLD_AND_BUGGY_VERSION_OF_LIBXML2=true

RAILS_GEM_VERSION = '2.3.3' unless defined? RAILS_GEM_VERSION

require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  # config.gem "probono-legebiltzarra", :lib => 'legebiltzarra', :version => '0.1.0', :source => "http://gems.github.com"
  config.gem "mbleigh-acts-as-taggable-on", :source => "http://gems.github.com", :lib => "acts-as-taggable-on"
  config.gem 'mislav-will_paginate', :version => '>=2.3.8', :lib => 'will_paginate', :source => 'http://gems.github.com'
  config.gem 'whenever', :lib => false, :source => 'http://gemcutter.org/'

  config.time_zone = 'UTC'
end
