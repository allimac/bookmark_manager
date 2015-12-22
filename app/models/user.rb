require 'dm-validations'
require 'bcrypt'

class User
  include DataMapper::Resource
  include BCrypt

  property :id, Serial
  property :name, String,     :required => true
  property :email, String,    :format => :email_address,
                              :required => true, :unique => true
  property :password_digest, Text

  attr_accessor :password_confirmation
  attr_reader :password

  validates_confirmation_of :password

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  has n, :links, through: Resource

end
