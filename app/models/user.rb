class User < ApplicationRecord
  has_many :records, dependent: :destroy
  has_many :exams, dependent: :destroy
  has_many :results, dependent: :destroy

  enum role: {user: 0, admin: 1}

  attr_accessor :remember_token

  before_save :email_downcase

  validates :email, presence: true,
            length: {maximum: Settings.user.email.max_length},
            uniqueness: true
  validates :name, presence: true,
            length: {maximum: Settings.user.name.max_length}
  validates :password, presence: true,
            length: {minimum: Settings.user.password.min_length},
            allow_nil: true

  has_secure_password

  class << self
    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create string, cost: cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.new_token
    update_attribute :remember_digest, User.digest(remember_token)
  end

  def forget
    update_attribute :remember_digest, nil
  end

  def authenticated? remember_token
    BCrypt::Password.new remember_digest.is_password? remember_token
  end

  private

  def email_downcase
    email.downcase!
  end
end
