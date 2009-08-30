require 'test/unit'
require 'rubygems'
require 'shoulda'
require 'action_controller'
require 'action_controller/test_process'

require File.join(File.dirname(__FILE__), "..", "lib", "meta_tags")
begin require 'redgreen'; rescue LoadError; end

APP_TITLE = 'My default title'
APP_DESCR = 'An awesome description'
APP_KEYWO = 'awesome, test, controller'

class ApplicationController < ActionController::Base
  meta :title       => APP_TITLE, 
       :description => APP_DESCR,
       :keywords    => APP_KEYWO
end

DEF_TITLE = 'Woo, the Internet!!!'
DEF_DESCR = "its a fun place to make fun of people and find pr0n"
DEF_KEYWO = "fun,place,people,pr0n"
class DefaultPerController < ApplicationController
  meta :title       => DEF_TITLE,
       :description => DEF_DESCR,
       :keywords    => DEF_KEYWO
end

OVER_TITLE = "This is different, Arbys is different"
class OverrideSomeController < ApplicationController
  meta :title     => OVER_TITLE
end

ACTI_TITLE = 'Override this plz.'
ACTI_KEYWO = "something fantastic"
class OverridePerActionController < ApplicationController
  meta :title => ACTI_TITLE
  def index
    meta :keywords => ACTI_KEYWO
  end
end

class MetaTagsTest < Test::Unit::TestCase
  
  include LinkingPaths::MetaTags::Helpers
  
  def request(controller = nil, action = nil, method = :get)
    @request = ActionController::TestRequest.new({
      "controller" => controller.to_s,
      "action"     => action ? action.to_s : "index",
      "_method"    => method.to_s
    })
    @response = ActionController::TestResponse.new
    controller.process(@request, @response)
    controller
  end

  context "meta_tags" do
    setup do
      @app_controller = ApplicationController.new
      @default_per_controller = DefaultPerController.new
      @override_some_controller = OverrideSomeController.new
      @override_per_action_controller = OverridePerActionController.new
    end
     
    should "be able to have default meta information for all controllers" do
      assert_equal ApplicationController.meta.class, Hash
      assert_equal ApplicationController.meta(:title), APP_TITLE
    end
    should "be able to retrieve meta data for a specific tag" do
      [:keywords, :title, :description].each { |meta| 
        assert_instance_of String, DefaultPerController.meta(meta)
      }
      assert_equal DefaultPerController.meta(:title), DEF_TITLE
      assert_equal DefaultPerController.meta(:description), DEF_DESCR
      assert_equal DefaultPerController.meta(:keywords), DEF_KEYWO
    end
    should "be able to have default meta information for a controller" do
      assert_equal ApplicationController.meta(:keywords), APP_KEYWO
      assert_equal DefaultPerController.meta(:keywords), DEF_KEYWO  
      default_per_controller = request(@default_per_controller)
      assert_equal default_per_controller.meta(:keywords), DEF_KEYWO
    end

    should "be able to override meta info on a tag-by-tag basis" do
      assert_equal ApplicationController.meta(:title), APP_TITLE
      assert_equal OverrideSomeController.meta(:title), OVER_TITLE
      override_some = request(@override_some_controller)
      assert_equal override_some.meta(:title), OverrideSomeController.meta(:title)
      override_some.meta :keywords => "super, awesome, keywords"
      assert_equal override_some.meta(:keywords), "super, awesome, keywords"
      assert_equal OverrideSomeController.meta(:keywords), APP_KEYWO
    end
    
    should "default meta tags to that of the parent class" do
      assert_equal ApplicationController.meta(:keywords), APP_KEYWO
      assert_equal OverrideSomeController.meta(:keywords), ApplicationController.meta(:keywords)
    end    
    
    should "be able to have meta information on an action-by-action basis" do
      override_per_action = request(@override_per_action_controller, "index")
      assert_equal ACTI_KEYWO, override_per_action.meta(:keywords)

    end
    should "render the html tags correctly" do
      default_per_controller = request(@default_per_controller)
      @meta_data = default_per_controller.meta
      title_tag = %{<title>#{DEF_TITLE}</title>}
      title = %{<meta name="title" content="#{DEF_TITLE}" />}
      descr = %{<meta name="description" content="#{DEF_DESCR}" />}
      keywo = %{<meta name="keywords" content="#{DEF_KEYWO}" />}
      
      assert_equal title_tag, title_tag
      assert_equal title, meta_tag(:title)
      assert_equal descr, meta_tag(:description)
      assert_equal keywo, meta_tag(:keywords)
      [title, descr, keywo].each{|tag|
        assert_contains(meta_tags, tag)
      }

    end
  end
  
end
