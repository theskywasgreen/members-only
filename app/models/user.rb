class User < ApplicationRecord
  attr_accessor :remember_digest
  before_create :create_remember_token
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
end
