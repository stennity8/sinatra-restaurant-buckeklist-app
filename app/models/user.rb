class User < ActiveRecord::Base
  extend Memorable::ClassMethods
  include Memorable::InstanceMethods

  validates_presence_of :username, :email, :password_digest
  has_secure_password
  has_many :reviews
  has_many :restaurants, through: :reviews
end
