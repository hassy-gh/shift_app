class Group < ApplicationRecord
  has_many :users
  validates :name, presence: true, length: { maximum: 30 }, uniqueness: true
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
end
