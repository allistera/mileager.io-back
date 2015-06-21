require 'test_helper'

module V1
  ##
  # Settings controller tests
  #
  # Checks the setting API endpoints are accessable using the expected
  # inputs and request types
  #
  class SettingsControllerTest < ActionController::TestCase
    include Devise::TestHelpers

    setup do
      @request.headers["Authorization"] = %{Token token="eMWzxCSpqs8APQ1sbLhz", email="testuser1@user.com"}
    end

    test 'should get all users settings' do
      get :index
      assert_response :success
    end

    test 'should get all settings' do
      get :index
      assert_response :success
    end
  end
end
