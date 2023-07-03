class Admin::ItemsController < ApplicationController
  
  def new
    @item = Item.new
  end
  
  def create
    item = Item.new(item_params)
    item.save
    redirect_to admin_items_path
  end
end
