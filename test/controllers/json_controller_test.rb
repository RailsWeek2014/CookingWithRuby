require 'test_helper'

class JsonControllerTest < ActionController::TestCase
  test "should get ingredients" do
    get :ingredients
    assert_response :success
  end

end
