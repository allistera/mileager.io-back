require 'mileage_calculator.rb'

module V1
  ##
  # Mileage controller
  #
  class MileagesController < ApplicationController
    before_action :authenticate_user_from_token!
    before_filter :authenticate_user!

    before_action :populate_settings

    respond_to :json, :csv

    def index
      mileages = Mileage.all.order('date desc').where(user_id: current_user.id)

      respond_to do |format|
        format.json { render json: mileages }
        format.csv { render csv: mileages, filename: 'mileager_io_export' }
      end
    end

    def graph_data
      render json: [
        labels:
          MileageCalculator.labels(@starting_month),
        expected:
          MileageCalculator.expected(@yearly_mileage, @starting_mileage,
                                     @duration.to_i),
        actual:
          MileageCalculator.actual(current_user.id, @duration.to_i,
                                   @starting_month)
      ]
    end

    def create
      render json: Mileage.create(date: params[:mileage][:date],
                                  amount: params[:mileage][:amount],
                                  user_id: current_user.id)
    end

    def delete
      mileage = Mileage.where(user_id: current_user.id, id: params[:id])
      if mileage.exists? && Mileage.destroy(params[:id])
        render json: { status: 'Mileage was successfully deleted.' },
               status: :ok
      else
        render json: { status: 'Unable to delete as no mileage was specified.' },
               status: :error
      end
    end

    def monthly
      actual = MileageCalculator.actual(current_user.id, @duration.to_i, @starting_month)
      expected = MileageCalculator.expected(@yearly_mileage, @starting_mileage,
                                            @duration.to_i)
      labels = MileageCalculator.labels(@starting_month)
      current_months_position = labels.index Time.now.strftime('%B').to_s
      render json: { actual: actual, expected: expected, labels: labels,
                     current_months_position: current_months_position }
    end
  end
end
