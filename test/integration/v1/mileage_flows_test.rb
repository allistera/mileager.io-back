require 'test_helper'

module V1
  ##
  # Mileage integration tests
  #
  # Testing the returned data from the mileage API endpoints is formatted
  # correctly
  #
  class MileageFlowsTest < ActionDispatch::IntegrationTest
    setup do
      @user = User.first
      @auth_headers = {Authorization: %{Token token="eMWzxCSpqs8APQ1sbLhz", email="testuser1@user.com"}}
    end

    test 'should get all mileage entries' do
      get '/v1/mileages', {}, @auth_headers
      assert_response :success
      assert_equal JSON.parse(body)['mileages'].count, 5
    end

    test 'should get monthly entries in correct format' do
      get '/v1/mileages/monthly', {}, @auth_headers
      assert_response :success

      parsed_response = JSON.parse(body)

      assert_equal 4, parsed_response.count, 4
      assert_equal 500.0, parsed_response['actual'].third
      assert_equal 3000, parsed_response['expected'].third
      assert_equal 'October', parsed_response['labels'].third
    end

    test 'should get graph data in correct format' do
      get '/v1/mileages/graph_data', {}, @auth_headers
      assert_response :success

      parsed_response = JSON.parse(body)['mileages'].first

      assert_equal 3, parsed_response.count
      assert_equal 'October', parsed_response['labels'].third
      assert_equal 3000, parsed_response['expected'].third
      assert_equal 500.0, parsed_response['actual'].third
    end

    test 'should create new mileage entry' do
      assert_difference('Mileage.count') do
        post '/v1/mileages', { mileage: { date: Time.now,
                                          amount: 100,
                                          user_id: @user.id
                                        } }, @auth_headers
      end

      new_mileage = Mileage.last

      assert_equal new_mileage.amount, 100
      assert_equal new_mileage.user_id, @user.id
    end

    test 'should delete mileage entry' do
      assert_difference('Mileage.count', -1) do
        delete "/v1/mileages/#{Mileage.last.id}", {}, @auth_headers
      end
    end
  end
end
