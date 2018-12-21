class Signature < ApplicationRecord
  belongs_to :user
  has_one_attached :public_key
  
  attr_accessor :password
  attr_accessor :private_key

  validates :user_id, uniqueness: {message: "Solo una firma por profesor" }
end
