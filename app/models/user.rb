class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :contents

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  validates :username, presence: true, uniqueness: true,
                       format: { with: /\A[a-z0-9\_]+\z/, message: "può contenere solo lettere minuscole, numeri e trattini bassi" },
                       length: { minimum: 3, maximum: 20 }

end
