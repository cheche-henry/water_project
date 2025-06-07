class UsersController < ApplicationController
  # Only admins should list users
  before_action :authorize_admin!, only: [:index, :destroy]

  # GET /users
  def index
    users = User.all
    render json: users.select(:id, :name, :phone_number, :email, :role), status: :ok
  end

  # GET /users/:id
  def show
    user = User.find(params[:id])
    if current_user.admin? || current_user == user
      render json: user.slice(:id, :name, :phone_number, :email, :role), status: :ok
    else
      render json: { error: "Access denied" }, status: :forbidden
    end
  end

  # DELETE /users/:id
  def destroy
    user = User.find(params[:id])
    if user.destroy
      render json: { message: "User deleted" }, status: :ok
    else
      render json: { error: "Failed to delete user" }, status: :unprocessable_entity
    end
  end
end
