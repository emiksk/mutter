class User < ApplicationRecord
  VALID_NAME_REGEXP = /\A[a-z\d][a-z\d\-_]+\z/i
  validates :name, presence: true, length: {maximum: 50}, uniqueness: true,
            format: {with: VALID_NAME_REGEXP}
  validates :password, presence: true, length: {minimum: 5, maximum: 255}
  has_secure_password

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
