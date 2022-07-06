class ChargesController < ApplicationController
  def new
  end

  def create
    @amount = 4600

    customer = Stripe::Customer.create({
      email: params[:stripeEmail],
      source: params[:stripeToken],
    })

  charge = Stripe::PaymentIntent.create(
    :customer => customer.id,
    :amount => @amount,
    :description => 'Rails Stripe transaction',
    :currency => 'usd',
  )

    # charge = Stripe::Charge.create({
    #   customer: customer.id,
    #   amount: @amount,
    #   description: 'E-Commerece Customer',
    #   currency: 'INR',
    # })

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end
end
