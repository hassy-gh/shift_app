class HopeShift < ApplicationRecord
  belongs_to :user
  validates :start_time, presence: true
  with_options on: :create do
    validates :start_time, uniqueness: { scope: :user_id }
  end
  validate :required_either_content_or_time

  private
  
    def required_either_content_or_time
      if content.present? ^ (hope_start_time.present? || hope_end_time.present?)
        errors.add(:content_or_hope_time, "どちらか一方を入力してください")
      end
    end
end
