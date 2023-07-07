class Public::AddressesController < ApplicationController

  def index
    @addresses = current_customer.addresses.all
    @address = Address.new
  end

  def create
    address = Address.new(address_params)
    address.customer_id = current_customer.id
    address.save
    redirect_to addresses_path
  end

  def edit
    @address = Address.find(params[:id])
  end
  
  def update
    Address.find(params[:id]).update(address_params)
    redirect_to addresses_path
  end

  def destroy
    Address.find(params[:id]).destroy
    redirect_to addresses_path
  end

  private

  def address_params
    params.require(:address).permit(:customer_id,
                                   :name,
                                   :address,
                                   :postcode
                                   )
  end
end
