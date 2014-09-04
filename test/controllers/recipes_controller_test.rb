require 'test_helper'

class RecipesControllerTest < ActionController::TestCase
  test "should get recipes" do
    get :recipes
    assert_response :success
  end

end
