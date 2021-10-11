class FixedShift < ApplicationRecord
  belongs_to :user
  validates :start_time, presence: true
  with_options on: :create do
    validates :user_id, uniqueness: { scope: :start_time }
  end
  validates :fixed_start_time, presence: true, unless: -> { errors[:user_id].any? }
  validates :fixed_end_time, presence: true, unless: -> { errors[:user_id].any? }
end
