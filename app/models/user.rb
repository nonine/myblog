class User < ActiveRecord::Base
  has_many :articles
  validates :name, presence: true, length: { minimum: 5 }
  validates :password, confirmation: true, length: { minimum: 5 }
  # validates :email, email: true
  
  EMAIL_MAX_LENGTH = 50

  has_secure_password

  def sign_in!(session)
    session[:id] = id
    session[:name] = name
  end
  
  def sign_out!(session)
    session[:id] = nil
    session[:name] = nil
  end
  
  def clear_password!
    self.password = nil
  end

  def remember!(cookies)
    cookies_expiration = 1.months.from_now
    cookies[:remember_me] = { value: 1, expires: cookies_expiration }
    self.authorization_token = unique_identifier
    save!
    cookies[:authorization_token] = { value: authorization_token, expires: cookies_expiration }
  end

  def forget!(cookies)
    cookies.delete(:remember_me)
    cookies.delete(:authorization_token)
  end

private
  def unique_identifier
    Digest::SHA1.hexdigest("#{name}:#{password_digest}")
  end
end
