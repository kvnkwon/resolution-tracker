class User < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :full_name, presence: true
  has_secure_password

  has_many :resolutions
end
