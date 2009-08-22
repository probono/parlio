require File.join(File.dirname(__FILE__), 'setup_test')

class SeoUrlsTest < Test::Unit::TestCase  
  
  def test_person_to_params
    assert p = Person.create(:name => "Long John Silver")
    assert_equal p.to_param, "1-long-john-silver" 
  end
  
  def test_post_to_params
    assert p = Post.create(:title => "My first post")
    assert_equal p.to_param, "1-my-first-post" 
  end
  
  def test_animal_to_params
    assert a = Animal.create(:common_name => "Domestic cat")
    assert_equal a.to_param, "1-domestic-cat" 
  end
end
