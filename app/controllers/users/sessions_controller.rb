class Users::SessionsController < Devise::SessionsController

  skip_before_filter :verify_authenticity_token

  # POST /resource/sign_in
  def create
    super do |user|
      data = {
        token: user.authentication_token,
        email: user.email,
        walkthrough: user.walkthrough
      }
      render json: data, status: 201 and return

    end
  end

end
