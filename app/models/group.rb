class Group < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :hope_shifts, through: :users
  has_many :fixed_shifts, through: :users
  validates :name, presence: true, length: { maximum: 30 }, uniqueness: true
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
end
