class Restaurant < ActiveRecord::Base
  extend Memorable::ClassMethods
  include Memorable::InstanceMethods

  has_many :reviews
  has_many :users, through: :reviews
end
