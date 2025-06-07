class WaterReadingsController < ApplicationController
  before_action :set_customer_profile
  before_action :set_water_reading, only: [:show, :update, :destroy]

  # GET /customer_profiles/:customer_profile_id/water_readings
  def index
    @water_readings = @customer_profile.water_readings
    render json: @water_readings
  end

  # GET /customer_profiles/:customer_profile_id/water_readings/:id
  def show
    render json: @water_reading
  end

  # POST /customer_profiles/:customer_profile_id/water_readings
  def create
    @water_reading = @customer_profile.water_readings.new(water_reading_params)
    if @water_reading.save
      render json: @water_reading, status: :created
    else
      render json: { errors: @water_reading.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /customer_profiles/:customer_profile_id/water_readings/:id
  def update
    if @water_reading.update(water_reading_params)
      render json: @water_reading
    else
      render json: { errors: @water_reading.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /customer_profiles/:customer_profile_id/water_readings/:id
  def destroy
    @water_reading.destroy
    head :no_content
  end

  private

  def set_customer_profile
    @customer_profile = CustomerProfile.find(params[:customer_profile_id])
  end

  def set_water_reading
    @water_reading = @customer_profile.water_readings.find(params[:id])
  end

  def water_reading_params
    params.require(:water_reading).permit(:reading_date, :consumption)
  end
end
