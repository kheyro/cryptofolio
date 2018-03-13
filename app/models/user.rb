class User < ApplicationRecord
  has_secure_password

  has_many :portfolios
  has_many :transactions, through: :portfolio

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }

  def self.find_or_create_by_omniauth(auth_hash)
    self.where(email: auth_hash["info"]["email"]).first_or_create do |user|
      user.name = auth_hash["info"]["name"]
      user.password = SecureRandom.hex
    end
  end

  def admin
    !!self.role_id
  end
end
