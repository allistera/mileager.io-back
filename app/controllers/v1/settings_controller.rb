require 'mileage_calculator.rb'

module V1
  ##
  # Settings controller
  #
  class SettingsController < ApplicationController
    before_action :authenticate_user_from_token!

    def update
      params[:settings].each do |n, v|
        return unless Setting.update_setting(current_user.id, n, v)
      end

      if params[:users].present?
        User.find(current_user.id).update_attribute('walkthrough', false)
      end

      render json: 'Settings where successfully updated.', status: :ok
    end
  end
end
