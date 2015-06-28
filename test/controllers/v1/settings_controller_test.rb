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

    test 'should get all settings' do
      get :index
      assert_response :success
    end

    test 'should update settings' do
      post :update, settings: { starting_date: '09-09-2015',
                                term_length: 48,
                                yearly_mileage: 12_500,
                                starting_mileage: 10 }

      assert_response :success

      user = User.find_by_email('testuser1@user.com')
      assert_equal '09-09-2015', user.starting_date.strftime('%d-%m-%Y')
      assert_equal '48', user.term_length
      assert_equal '12500', user.yearly_mileage
      assert_equal '10', user.starting_mileage
    end
  end
end
