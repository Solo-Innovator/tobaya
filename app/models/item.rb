class Item < ApplicationRecord

  has_one_attached :image
  has_many :carts
  has_many :order_details
  belongs_to :genre

  validates :genre_id,     presence: true
  validates :name,         presence: true
  validates :introduction, presence: true
  validates :price,        presence: true

  def item_status
    if is_available == true
      "販売中"
    else
      "販売停止中"
    end
  end

  def with_tax_price
    (price * 1.1).floor
  end
end
