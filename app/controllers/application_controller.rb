##
# Base Application Controller
#
class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  def index
    render json: 'Welcome to CarMileager API', status: :ok
  end

  private

  def populate_settings
    @STARTING_MONTH = '01-Jan-2015'
    @YEARLY_MILEAGE = 10_000
    @STARTING_MILEAGE = 0
    @DURATION = 12

    settings = Setting.where(user_id: current_user.id)

    settings.each do |setting|
      unless setting.name.empty?
        instance_variable_set("@#{setting.name}", setting.value)
      end
    end
  end
end
