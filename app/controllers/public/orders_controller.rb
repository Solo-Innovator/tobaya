class Public::OrdersController < ApplicationController
  
  def new
    cart_items = current_customer.cart_items
    if cart_items.present?
      @order = Order.new
      @addresses = current_customer.addresses
    else
      flash[:notice] = "カートが空です"
      redirect_to request.referer
    end
  end
  
  def confirm
    if params[:order]
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @cart_items = current_customer.cart_items
    @total_amount = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
    @order.shipping_fee = 800
    @order_total_amount = @total_amount + @order.shipping_fee.to_i
    
    if params[:order][:address_option] == "0"
      @order.postcode   = current_customer.postcode
      @order.address    = current_customer.address
      @order.name       = current_customer.full_name
    elsif params[:order][:address_option] == "1"
      if current_customer.addresses.present?
        address = Address.find(params[:order][:address_id])
        @order.postcode = address.postcode
        @order.address  = address.address
        @order.name     = address.name
      end
    elsif params[:order][:address_option] == "2"
      render "new"
    end
    @cart_items         = current_customer.cart_items.all
    @order.shipping_fee = 800
    @order.customer_id  = current_customer.id
  end
end
  
  def create
    @order = Order.new(order_params)
    if @order.save
      current_customer.cart_items.each do |cart_item|
        order_detail          = OrderDetail.new()
        order_detail.order_id = @order.id
        order_detail.item_id  = cart_item.id
        order_detail.quantity = cart_item.quantity
        order_detail.price    = cart_item.item.with_tax_price
        order_detail.save
      end
      current_customer.cart_items.destroy_all
      redirect_to complete_orders_path
    end
  end

  def index
    @orders = current_customer.orders.all
  end
     
  def complete
  end
  
  def show
    @order = current_customer.orders.find(params[:id])
    @total = @order.order_details.inject(0) { |sum, order_details| sum + order_details.total_price }
    @order_details = @order.order_details.all
  end
  
  private
  
  def order_params
    params.require(:order).permit(:postcode,
                                  :address,
                                  :name,
                                  :payment_method,
                                  :total_amount,
                                  :shipping_fee,
                                  :customer_id
                                  )
  end
end

