require 'test_helper'

class PlotsControllerTest < ActionController::TestCase
  setup do
    @plot = plots(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:plots)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create plot" do
    assert_difference('Plot.count') do
      post :create, plot: { admin_id: @plot.admin_id, city: @plot.city, description: @plot.description, name: @plot.name, state: @plot.state, type: @plot.type, user_id: @plot.user_id, visibility: @plot.visibility, zip: @plot.zip }
    end

    assert_redirected_to plot_path(assigns(:plot))
  end

  test "should show plot" do
    get :show, id: @plot
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @plot
    assert_response :success
  end

  test "should update plot" do
    put :update, id: @plot, plot: { admin_id: @plot.admin_id, city: @plot.city, description: @plot.description, name: @plot.name, state: @plot.state, type: @plot.type, user_id: @plot.user_id, visibility: @plot.visibility, zip: @plot.zip }
    assert_redirected_to plot_path(assigns(:plot))
  end

  test "should destroy plot" do
    assert_difference('Plot.count', -1) do
      delete :destroy, id: @plot
    end

    assert_redirected_to plots_path
  end
end
