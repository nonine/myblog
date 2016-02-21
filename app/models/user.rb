class User < ActiveRecord::Base
  has_many :articles
  validates :name, presence: true, length: { minimum: 5 }
  validates :password, confirmation: true, length: { minimum: 5 }
  # validates :email, email: true

  has_secure_password

  def last_active_date
  end
end