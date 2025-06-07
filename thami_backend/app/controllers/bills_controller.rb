class BillsController < ApplicationController
  before_action :set_customer_profile
  before_action :set_bill, only: [:show, :update, :destroy]

  # GET /customer_profiles/:customer_profile_id/bills
  def index
    @bills = @customer_profile.bills
    render json: @bills
  end

  # GET /customer_profiles/:customer_profile_id/bills/:id
  def show
    render json: @bill
  end

  # POST /customer_profiles/:customer_profile_id/bills
  def create
    @bill = @customer_profile.bills.new(bill_params)
    if @bill.save
      render json: @bill, status: :created
    else
      render json: { errors: @bill.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /customer_profiles/:customer_profile_id/bills/:id
  def update
    if @bill.update(bill_params)
      render json: @bill
    else
      render json: { errors: @bill.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /customer_profiles/:customer_profile_id/bills/:id
  def destroy
    @bill.destroy
    head :no_content
  end

  private

  def set_customer_profile
    @customer_profile = CustomerProfile.find(params[:customer_profile_id])
  end

  def set_bill
    @bill = @customer_profile.bills.find(params[:id])
  end

  def bill_params
    params.require(:bill).permit(:water_reading_id, :amount, :status)
  end
end
