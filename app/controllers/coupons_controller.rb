class CouponsController < ApplicationController
  def apply_coupon
    @code = Coupon.is_valid_coupon(params[:promo_code])

    if @code.nil? or @code[0] != params[:promo_code]
      flash[:alert] = "Your code is not valid."
      @validity = "false"
      redirect_to :cart_items, flash: {validity: false}
    else
      flash[:notice] = "Your code is valid. Discount will be applied."
      @validity = "true"
      redirect_to :cart_items, flash: {validity: [true, parse_discount_value(@code[0])]}
    end
  end

  def parse_discount_value(promo_code)
    index = promo_code.index( /[^[:alnum:]]/ );
    promo_code.slice(index + 1, promo_code.length)
  end

end