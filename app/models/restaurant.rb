class Restaurant < ActiveRecord::Base
  extend Memorable::ClassMethods
  include Memorable::InstanceMethods

  validates_presence_of :name, :cuisine, :address, :city, :state, :zip_code
  has_many :reviews
  has_many :users, through: :reviews
end
