require 'test_helper'

class CompaniaControllerTest < ActionController::TestCase
  setup do
    @companium = compania(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:compania)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create companium" do
    assert_difference('Companium.count') do
      post :create, :companium => @companium.attributes
    end

    assert_redirected_to companium_path(assigns(:companium))
  end

  test "should show companium" do
    get :show, :id => @companium.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @companium.to_param
    assert_response :success
  end

  test "should update companium" do
    put :update, :id => @companium.to_param, :companium => @companium.attributes
    assert_redirected_to companium_path(assigns(:companium))
  end

  test "should destroy companium" do
    assert_difference('Companium.count', -1) do
      delete :destroy, :id => @companium.to_param
    end

    assert_redirected_to compania_path
  end
end
