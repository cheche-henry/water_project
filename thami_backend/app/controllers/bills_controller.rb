class BillsController < ApplicationController
  before_action :authorize_customer
  before_action :set_customer_profile
  before_action :set_bill, only: [:show, :update, :destroy]

  # GET /bills
  def index
    bills = @customer_profile.bills
    render json: bills
  end

  # GET /bills/:id
  def show
    render json: @bill
  end

  # POST /bills
  def create
    bill = @customer_profile.bills.new(bill_params)
    if bill.save
      render json: bill, status: :created
    else
      render json: { errors: bill.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /bills/:id
  def update
    if @bill.update(bill_params)
      render json: @bill
    else
      render json: { errors: @bill.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /bills/:id
  def destroy
    @bill.destroy
    head :no_content
  end

  private

  def set_customer_profile
    @customer_profile = current_user.customer_profile
    render json: { error: 'Customer profile not found' }, status: :not_found unless @customer_profile
  end

  def set_bill
    @bill = @customer_profile.bills.find_by(id: params[:id])
    render json: { error: 'Bill not found' }, status: :not_found unless @bill
  end

  def bill_params
    params.require(:bill).permit(:amount, :status, :water_reading_id)
  end

  def authorize_customer
    render json: { error: 'Access denied' }, status: :forbidden unless current_user&.customer?
  end
end
