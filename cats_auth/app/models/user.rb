class User < ApplicationRecord
  validates :username, :password_digest, :session_token, presence: true
  validates :username, :session_token, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }
  after_initialize :ensure_session_token #TODO we need to write this

  attr_reader :password

  def reset_session_token!
    self.session_token = SecureRandom::urlsafe_base64(32)
    self.save!
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    return nil if user.nil?
    if user.is_password?(password)
      return user
    else
      nil
    end
  end

  def ensure_session_token

    self.session_token ||= SecureRandom::urlsafe_base64(32)
  end

end
