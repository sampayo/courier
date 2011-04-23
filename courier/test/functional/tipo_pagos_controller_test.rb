require 'test_helper'

class TipoPagosControllerTest < ActionController::TestCase
  setup do
    @tipo_pago = tipo_pagos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tipo_pagos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tipo_pago" do
    assert_difference('TipoPago.count') do
      post :create, :tipo_pago => @tipo_pago.attributes
    end

    assert_redirected_to tipo_pago_path(assigns(:tipo_pago))
  end

  test "should show tipo_pago" do
    get :show, :id => @tipo_pago.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @tipo_pago.to_param
    assert_response :success
  end

  test "should update tipo_pago" do
    put :update, :id => @tipo_pago.to_param, :tipo_pago => @tipo_pago.attributes
    assert_redirected_to tipo_pago_path(assigns(:tipo_pago))
  end

  test "should destroy tipo_pago" do
    assert_difference('TipoPago.count', -1) do
      delete :destroy, :id => @tipo_pago.to_param
    end

    assert_redirected_to tipo_pagos_path
  end
end
