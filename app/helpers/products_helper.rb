# frozen_string_literal: true

# Helper class for products
module ProductsHelper

  def owns_product(product_id)
    !current_user&.products.exists?(@product.id)
  end

  def owns_comment(comment_id)
    current_user.comments.exists?(comment_id)
  end

end
