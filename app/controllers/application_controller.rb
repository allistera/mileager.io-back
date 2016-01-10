##
# Base Application Controller
#
class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  before_filter :authenticate_user_from_token!, except: ['index']
  before_filter :configure_permitted_parameters, if: :devise_controller?
  respond_to :json

  def index
    render json: 'Welcome to CarMileager API', status: :ok
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) do |u| 
      u.permit(:password, :password_confirmation, :current_password) 
    end
  end

  def populate_settings
    settings = User.find_by_id(current_user.id)
    @starting_month = settings.starting_date
    @yearly_mileage = settings.yearly_mileage
    @starting_mileage = settings.starting_mileage
    @duration = settings.term_length
  end

  def authenticate_user_from_token!
    authenticate_with_http_token do |token, options|
      user_email = options[:email].presence
      user = user_email && User.find_by_email(user_email)

      if user && Devise.secure_compare(user.authentication_token, token)
        sign_in user, store: false
      end
    end
  end

end
