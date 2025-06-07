class CustomerProfilesController < ApplicationController
  before_action :set_customer_profile, only: [:show, :update, :destroy]

  # GET /customer_profiles
  def index
    @customer_profiles = CustomerProfile.all
    render json: @customer_profiles
  end

  # GET /customer_profiles/:id
  def show
    render json: @customer_profile
  end

  # POST /customer_profiles
  def create
    @customer_profile = CustomerProfile.new(customer_profile_params)

    if @customer_profile.save
      render json: @customer_profile, status: :created
    else
      render json: { errors: @customer_profile.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /customer_profiles/:id
  def update
    if @customer_profile.update(customer_profile_params)
      render json: @customer_profile
    else
      render json: { errors: @customer_profile.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /customer_profiles/:id
  def destroy
    @customer_profile.destroy
    head :no_content
  end

  private

  def set_customer_profile
    @customer_profile = CustomerProfile.find(params[:id])
  end

  def customer_profile_params
    params.require(:customer_profile).permit(:user_id, :meter_number, :address)
  end
end
