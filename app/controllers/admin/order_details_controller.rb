class Admin::OrderDetailsController < ApplicationController
    def update
    order_detail = OrderDetail.find(params[:id])
    order      = order_detail.order
    OrderDetail.transaction do
      order_detail.update(order_item_params)
      if order_detail.status == "making"
        order.update(status: 2)
      elsif order.order_details.count == order.order_details.where(status: "complete").count
        order.update(status: 3)
      end
    end
      flash[:notice] = "updated order status successfully"
      redirect_to admin_order_path(order)
    rescue => e
      flash[:alert] = "failed update"
      redirect_to admin_order_path(order)
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:status)
  end
  
end
