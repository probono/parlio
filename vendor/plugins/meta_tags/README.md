
meta\_tags
============
A rails plugin that gives you control over the xhtml meta tags rendered in your template on a application/controller/action basis.


Install
-------

´sudo gem install linkingpaths-meta\_tags´

The junk
--------

* In your controllers

You can setup a default value for any meta name/content pair in your application controller:

<pre>
class ApplicationController < ActionController::Base
  meta  :title        => "My default page title",
        :description  => "Add a sexy default description here.",
        :keywords     => "sex, lies, video tapes"
end
</pre>

Additionally you can get these values overwrited in any controller/action:

<pre>
class SpecificController < ApplicationController
  meta :title => "This is an app related controller"

  def spice_up
    meta :title => "overwriten in this action",
         :keywords => "p0rn, Jenna Jameson, Kristal Summers"
    render
    # :title => "toverwriten in this action"
    # :keywords => "p0rn, Jenna Jameson, Kristal Summers"
    # :description => "My default page description"
  end

  def not_spice_up
    render
    # :title       => "This is an app related controller"
    # :description => "Add a sexy default description here."
    # :keywords    => "sex, lies, video tapes"
  end

end
</pre>


* In your views

Some helpers are automatically available in your views:

<pre>

<%= title_tag %>
# Should render as <title>This is an app related controller</title>

<%= meta_tag :title %>
# Should render as <meta name="title" content="This is an app related controller" />

<%= meta\_tags %>
# Should render all the meta tags defined
# <meta name="title" content="This is an app related controller" />
# <meta name="description" content="Add a sexy default description here." />
# <meta name="keywords" content="sex, lies, video tapes" />
</pre>

Credits
-------

This one is highly inspired by [merb\_meta](http://github.com/coryodaniel/merb_meta). If you don't like the api you can try [rails-meta\_tags](http://github.com/delynn/rails-meta_tags), [kpumuk's meta-tags](http://github.com/kpumuk/meta-tags) or [meta\_on\_rails](http://github.com/ashchan/meta_on_rails).

More
----

[meta\_tags on github](http://github.com/linkingpaths/meta_tags)

Copyright (c) 2008 Linking Paths, released under the MIT license

