class HopeShift < ApplicationRecord
  belongs_to :user
  validates :start_time, uniqueness: { message: "%{attribute}%{value}はすでに登録されています" }
end
