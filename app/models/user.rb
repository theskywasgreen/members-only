class User < ApplicationRecord
  attr_accessor :remember_digest
  before_create :create_remember_token
  before_save :downcase_email
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  has_secure_password
  has_many :posts

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(string)
    string.to_s
    Digest::SHA1.hexdigest(string)
  end

  def create_remember_token
    self.remember_digest = User.new_token
    self.remember_token = User.digest(remember_digest)
  end

  private

  def downcase_email
    email.downcase!
  end
end
