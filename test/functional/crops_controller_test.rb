require 'test_helper'

class CropsControllerTest < ActionController::TestCase
  setup do
    @crop = crops(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:crops)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create crop" do
    assert_difference('Crop.count') do
      post :create, crop: { coverage_number: @crop.coverage_number, coverage_unit: @crop.coverage_unit, date_picked: @crop.date_picked, date_planted: @crop.date_planted, description: @crop.description, plant: @crop.plant, plot_id: @crop.plot_id, price: @crop.price, quantity_number: @crop.quantity_number, quantity_type: @crop.quantity_type, starting_type: @crop.starting_type, type: @crop.type, yield_number: @crop.yield_number, yield_unit: @crop.yield_unit }
    end

    assert_redirected_to crop_path(assigns(:crop))
  end

  test "should show crop" do
    get :show, id: @crop
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @crop
    assert_response :success
  end

  test "should update crop" do
    put :update, id: @crop, crop: { coverage_number: @crop.coverage_number, coverage_unit: @crop.coverage_unit, date_picked: @crop.date_picked, date_planted: @crop.date_planted, description: @crop.description, plant: @crop.plant, plot_id: @crop.plot_id, price: @crop.price, quantity_number: @crop.quantity_number, quantity_type: @crop.quantity_type, starting_type: @crop.starting_type, type: @crop.type, yield_number: @crop.yield_number, yield_unit: @crop.yield_unit }
    assert_redirected_to crop_path(assigns(:crop))
  end

  test "should destroy crop" do
    assert_difference('Crop.count', -1) do
      delete :destroy, id: @crop
    end

    assert_redirected_to crops_path
  end
end
