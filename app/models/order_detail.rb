class OrderDetail < ApplicationRecord
  enum status: { impossible: 0, wait: 1, making: 2, complete: 3 }
  
  belongs_to :order
  belongs_to :item
  
  def total_price
    item.with_tax_price.to_i * count.to_i
  end
  
end
