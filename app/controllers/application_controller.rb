##
# Base Application Controller
#
class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  before_filter :authenticate_user_from_token!, except: ['index']
  respond_to :json

  def index
    render json: 'Welcome to CarMileager API', status: :ok
  end

  private

  def populate_settings
    settings = Setting.where(user_id: current_user.id)

    settings.each do |setting|
      unless setting.name.empty?
        instance_variable_set("@#{setting.name}", setting.value)
      end
    end
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
