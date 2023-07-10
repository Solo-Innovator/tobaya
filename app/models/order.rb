class Order < ApplicationRecord
  
  belongs_to :customer
  has_many :order_details
  
  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status:  { wait: 0, check: 1, making: 2, standby: 3, sent: 4 }
  
end
