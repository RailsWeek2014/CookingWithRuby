require 'test_helper'

class SearchControllerTest < ActionController::TestCase
  test "should get fuzzy" do
    get :fuzzy
    assert_response :success
  end

  test "should get user" do
    get :user
    assert_response :success
  end

  test "should get recipe" do
    get :recipe
    assert_response :success
  end

  test "should get ingredient" do
    get :ingredient
    assert_response :success
  end

  test "should get cathegory" do
    get :cathegory
    assert_response :success
  end

end
