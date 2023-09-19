class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :purchases, foreign_key: :buyer_id
  has_many :movies, through: :purchases

  def has_payment_info?
    # braintree_customer_id 
  end
end
