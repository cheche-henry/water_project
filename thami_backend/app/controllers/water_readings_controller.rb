class WaterReadingsController < ApplicationController
  before_action :authorize_customer
  before_action :set_customer_profile
  before_action :set_reading, only: [:show, :update, :destroy]

  # GET /water_readings
  def index
    readings = @customer_profile.water_readings
    render json: readings
  end

  # GET /water_readings/:id
  def show
    render json: @reading
  end

  # POST /water_readings
  def create
    reading = @customer_profile.water_readings.new(water_reading_params)
    if reading.save
      render json: reading, status: :created
    else
      render json: { errors: reading.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /water_readings/:id
  def update
    if @reading.update(water_reading_params)
      render json: @reading
    else
      render json: { errors: @reading.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /water_readings/:id
  def destroy
    @reading.destroy
    head :no_content
  end

  private

  def set_customer_profile
    @customer_profile = current_user.customer_profile
    render json: { error: 'Customer profile not found' }, status: :not_found unless @customer_profile
  end

  def set_reading
    @reading = @customer_profile.water_readings.find_by(id: params[:id])
    render json: { error: 'Reading not found' }, status: :not_found unless @reading
  end

  def water_reading_params
    params.require(:water_reading).permit(:reading_date, :consumption)
  end

  def authorize_customer
    render json: { error: 'Access denied' }, status: :forbidden unless current_user&.customer?
  end
end
