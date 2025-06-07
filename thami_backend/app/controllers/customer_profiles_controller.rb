# app/controllers/customer_profiles_controller.rb
class CustomerProfilesController < ApplicationController
  before_action :authenticate_request
  before_action :set_customer_profile, only: %i[show update destroy]
  before_action :authorize_owner!, only: %i[show update destroy]

  # GET /customer_profiles
  def index
    if current_user.admin?
      profiles = CustomerProfile.all
    else
      profiles = current_user.customer_profile ? [current_user.customer_profile] : []
    end
    render json: profiles, status: :ok
  end

  # GET /customer_profiles/:id
  def show
    render json: @customer_profile, status: :ok
  end

  # POST /customer_profiles
  def create
    if current_user.customer_profile
      render json: { error: 'Customer already has a profile' }, status: :unprocessable_entity
      return
    end

    profile = current_user.build_customer_profile(customer_profile_params)

    if profile.save
      render json: profile, status: :created
    else
      render json: { errors: profile.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /customer_profiles/:id
  def update
    if @customer_profile.update(customer_profile_params)
      render json: @customer_profile, status: :ok
    else
      render json: { errors: @customer_profile.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /customer_profiles/:id
  def destroy
    @customer_profile.destroy
    render json: { message: "Profile deleted" }, status: :ok
  end

  private

  def set_customer_profile
    @customer_profile = CustomerProfile.find(params[:id])
  end

  def authorize_owner!
    return if current_user.admin? || @customer_profile.user_id == current_user.id

    render json: { error: "Unauthorized" }, status: :unauthorized
  end

  def customer_profile_params
    params.require(:customer_profile).permit(:meter_number, :address)
  end
end
