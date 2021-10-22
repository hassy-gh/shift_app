class FixedShift < ApplicationRecord
  belongs_to :user
  validates :start_time, presence: true
  with_options on: :create do
    validates :user_id, uniqueness: { scope: :start_time }
  end
  validate :required_either_absence_or_time, unless: -> { errors.any? }
  validates :fixed_start_time, presence: true, unless: -> { errors.any? || !:fixed_end_time.present? }
  validates :fixed_end_time, presence: true, unless: -> { errors.any? || !:fixed_start_time.present? }
  
  private
  
    def required_either_absence_or_time
      return if absence? ^ (fixed_start_time.present? || fixed_end_time.present?)
      errors.add(:absence_or_fixed_time, "のどちらかを入力してください")
    end
end
