require 'test_helper'

module V1
  ##
  # Mileages controller tests
  #
  # Checks the mileage API endpoints are accessable using the expected
  # inputs and request types
  #
  class MileagesControllerTest < ActionController::TestCase
    include Devise::Test::ControllerHelpers

    setup do
      @user = User.first
      @request.headers['Authorization'] = %(Token token="eMWzxCSpqs8APQ1sbLhz", email="testuser1@user.com")
    end

    test 'should get index' do
      get :index, format: :json
      assert_response :success
    end

    test 'should get index as csv' do
      get :index, format: :csv
      assert_response :success
    end

    test 'should get monthly' do
      get :monthly
      assert_response :success
    end

    test 'should get graph data' do
      get :graph_data
      assert_response :success
    end

    test 'should create new mileage' do
      post :index, mileage: { date: Time.now, amount: 100, user_id: @user.id }, format: :json
      assert_response :success
    end

    test 'should delete mileage' do
      delete :index, id: Mileage.last.id, format: :json
      assert_response :success
    end
  end
end
