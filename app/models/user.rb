class User < ActiveRecord::Base
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  has_secure_password
  has_many :events
  has_many :goings, dependent: :destroy
  has_many :events_going, through: :goings, source: :event
  validates :first_name, :last_name, :location, :state, presence: true
  validates :password, length: {minimum: 8}, on: :create
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }

  before_save :email_lowercase

  def email_lowercase
    email.downcase!
  end
end
