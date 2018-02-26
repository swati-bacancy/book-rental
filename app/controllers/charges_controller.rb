class ChargesController < ApplicationController
  def new
  end

  def create
    # Amount in cents
    @amount = 500
     @order_id= params[:charges][:order_id]
     @order=Order.find(@order_id)
     @order.paymentStatus=1
     @order.save
    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Rails Stripe customer',
      :currency    => 'usd'
    )

    redirect_to orders_path

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path
  end
end
