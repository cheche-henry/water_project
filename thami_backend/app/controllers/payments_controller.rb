class PaymentsController < ApplicationController
  before_action :set_bill
  before_action :set_payment, only: [:show, :update, :destroy]

  # GET /customer_profiles/:customer_profile_id/bills/:bill_id/payments
  def index
    @payments = @bill.payments
    render json: @payments
  end

  # GET /customer_profiles/:customer_profile_id/bills/:bill_id/payments/:id
  def show
    render json: @payment
  end

  # POST /customer_profiles/:customer_profile_id/bills/:bill_id/payments
  def create
    @payment = @bill.payments.new(payment_params)
    if @payment.save
      render json: @payment, status: :created
    else
      render json: { errors: @payment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /customer_profiles/:customer_profile_id/bills/:bill_id/payments/:id
  def update
    if @payment.update(payment_params)
      render json: @payment
    else
      render json: { errors: @payment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /customer_profiles/:customer_profile_id/bills/:bill_id/payments/:id
  def destroy
    @payment.destroy
    head :no_content
  end

  private

  def set_bill
    @bill = Bill.find(params[:bill_id])
  end

  def set_payment
    @payment = @bill.payments.find(params[:id])
  end

  def payment_params
    params.require(:payment).permit(:amount, :payment_method, :transaction_code, :paid_at)
  end
end
