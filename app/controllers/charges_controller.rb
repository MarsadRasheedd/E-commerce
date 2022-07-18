# frozen_string_literal: true

# this controller handles charges methods.
class ChargesController < ApplicationController
  helper_method :amount

  def new
    if user_signed_in?
      @@amount = params[:amount].to_i
    else
      flash[:alert] = 'You need to sign-up or sign-in'
      redirect_to new_user_registration_path
    end
  end

  def create
    customer = Stripe::Customer.create({ email: params[:stripeEmail], source: params[:stripeToken] })

    Stripe::PaymentIntent.create(customer: customer.id, amount: @@amount,
                                 description: 'Rails Stripe transaction', currency: 'INR')
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

  def amount
    @@amount
  end
end
