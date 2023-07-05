class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  def full_name
    last_name + '' + first_name
  end
  
  def full_name_kana
    last_name_kana + '' + first_name_kana
  end
  
  def cus_status
    if is_withdrawal == true
      "退会"
    else
      "有効"
    end
  end
  
  def active_for_authentication?
    super && (is_withdrawal == false)
  end
    
  
end
