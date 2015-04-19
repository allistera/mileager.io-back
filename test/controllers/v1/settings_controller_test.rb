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
      @user = User.first
      request.headers.merge!(@user.create_new_auth_token)
    end

    test 'should update settings' do
      put :update, settings: { YEARLY_MILEAGE: 12_000, STARTING_MILEAGE: 45 }
      assert_response :success
    end
  end
end
