class SessionsController < ApplicationController
  # Skip auth for login
  skip_before_action :authenticate_request

  # POST /login
  def create
    user = User.find_by(phone_number: params[:login]) || User.find_by(email: params[:login])

    if user&.authenticate(params[:password])
      token = jwt_token(user)
      render json: {
        token: token,
        user: {
          id: user.id,
          name: user.name,
          role: user.role,
          phone_number: user.phone_number,
          email: user.email
        }
      }, status: :ok
    else
      render json: { error: "Invalid login or password" }, status: :unauthorized
    end
  end

  private

  def jwt_token(user)
    payload = {
      user_id: user.id,
      role: user.role,
      exp: 24.hours.from_now.to_i
    }
    JWT.encode(payload, Rails.application.secret_key_base)
  end
end
