require 'mileage_calculator.rb'

module V1
  ##
  # Settings controller
  #
  class SettingsController < ApplicationController
    before_action :authenticate_user_from_token!

    def index
      render json: User.where(id: current_user.id).select('starting_date',
                                                          'term_length',
                                                          'yearly_mileage',
                                                          'starting_mileage')
    end

    def update
      render json: User.find(current_user.id).update(settings_params)
    end

    def delete_account
      render json: User.find(current_user.id).destroy
    end

    private

    def settings_params
      params.require(:settings).permit(:starting_date,
                                       :term_length,
                                       :yearly_mileage,
                                       :starting_mileage)
    end
  end
end
