class SessionsController < Devise::SessionsController
  skip_before_filter :verify_authenticity_token

  def create
    super do |_resource|
      if request.format.json?
        data = {
          email: user.email
        }
        render(json: data, status: 201) && return
      end
    end
  end

  def flash
    render json: { success: false, errors: ['Login failed.'] }
  end
end
