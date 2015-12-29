require 'dm-validations'
require 'bcrypt'

class User
  include DataMapper::Resource
  include BCrypt

  property :id, Serial
  property :email, String,    :format => :email_address,
                              :required => true, :unique => true
  property :password_digest, Text
  property :token, Text
  property :token_time, Time

  attr_accessor :password_confirmation

  validates_confirmation_of :password

  def password
    @password ||= Password.new(password_digest)
  end

  def password=(password)
    @password = password
    self.password_digest = Password.create(password)
  end

  def self.authenticate(email, password)
    user = first(:email => email)
    (user && user.password == password) ? user : nil
  end

  def generate_token
    self.token = SecureRandom.hex(8)
    self.token_time = Time.now
    self.save
  end

  has n, :links, through: Resource

end
