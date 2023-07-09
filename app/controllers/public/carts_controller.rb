class Public::CartsController < ApplicationController

  def index
    @carts = current_customer.carts.all
    @total = @carts.inject(0) { |sum, item| sum + item.subtotal }
  end

  def create
    @cart = Cart.new(cart_params)
    if cart = current_customer.carts.find_by(item_id: @cart.item_id)
      cart.quantity += @cart.quantity.to_i
      cart.save
      redirect_to carts_path
    else
      @cart.save
      redirect_to carts_path
    end
  end

  def update
    Cart.find(params[:id]).update(cart_params)
    redirect_to carts_path
  end

  def destroy
    Cart.find(params[:id]).destroy
    redirect_to carts_path
  end

  def destroy_all
    current_customer.carts.destroy_all
    redirect_to carts_path
  end

  private

  def cart_params
    params.require(:cart).permit(:customer_id,
                                 :item_id,
                                 :quantity
                                 )
  end
end
