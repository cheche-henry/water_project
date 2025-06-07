class PaymentsController < ApplicationController
  before_action :authorize_customer
  before_action :set_bill
  before_action :set_payment, only: [:show, :update, :destroy]

  # GET /bills/:bill_id/payments
  def index
    payments = @bill.payments
    render json: payments
  end

  # GET /bills/:bill_id/payments/:id
  def show
    render json: @payment
  end

  # POST /bills/:bill_id/payments
  def create
    payment = @bill.payments.new(payment_params)
    if payment.save
      render json: payment, status: :created
    else
      render json: { errors: payment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /bills/:bill_id/payments/:id
  def update
    if @payment.update(payment_params)
      render json: @payment
    else
      render json: { errors: @payment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /bills/:bill_id/payments/:id
  def destroy
    @payment.destroy
    head :no_content
  end

  private

  def set_bill
    @bill = current_user.customer_profile.bills.find_by(id: params[:bill_id])
    render json: { error: 'Bill not found' }, status: :not_found unless @bill
  end

  def set_payment
    @payment = @bill.payments.find_by(id: params[:id])
    render json: { error: 'Payment not found' }, status: :not_found unless @payment
  end

  def payment_params
    params.require(:payment).permit(:amount, :payment_method, :transaction_code, :paid_at)
  end

  def authorize_customer
    render json: { error: 'Access denied' }, status: :forbidden unless current_user&.customer?
  end
end
