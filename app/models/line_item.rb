class LineItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :cart

  after_save :update_cart_total

  def total_price

    quantity * product.price

  end

  def update_cart_total

    cart.price = cart.reload.line_items.collect {|line| line.total_price}.inject(:+)
    cart.save!

  end


end
