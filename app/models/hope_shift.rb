class HopeShift < ApplicationRecord
  belongs_to :user
  validates :start_time, presence: true
  with_options on: :create do
    validates :start_time, uniqueness: { scope: :user_id }
  end
  validate :required_either_content_or_time
  
  private
  
    def required_either_content_or_time
      return if content.present? ^ hope_start_time.present? || hope_end_time.present?
      errors.add(:base, "どちらか一方を入力してください")
    end
end
