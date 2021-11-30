# require 'net/http'
# require 'uri'

class FixedShift < ApplicationRecord
  belongs_to :user
  validates :start_time, presence: true
  with_options on: :create do
    validates :start_time, uniqueness: { scope: :user_id }
  end
  validate :required_either_absence_or_time, unless: -> { errors.any? }
  validates :fixed_start_time, presence: true, unless: :require_validation?
  validates :fixed_end_time, presence: true, unless: :require_validation?
  enum status: { draft: 0, published: 1 }
  validates :status, inclusion: { in: FixedShift.statuses.keys }
  
  private
  
    def required_either_absence_or_time
      return if absence? ^ (fixed_start_time.present? || fixed_end_time.present?)
      errors.add(:absence_or_fixed_time, "のどちらかを入力してください")
    end
    
    def require_validation?
      return true if errors.any? || absence?
      false
    end
end
