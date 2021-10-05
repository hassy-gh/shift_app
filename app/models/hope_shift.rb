require 'time'

class HopeShift < ApplicationRecord
  belongs_to :user
  before_save :parse_time
  validates :start_time, presence: true
  with_options on: :create do
    validates :start_time, uniqueness: { scope: :user_id }
  end
  # validate :required_either_content_or_time
  # validates :hope_start_time, presence: true
  # validates :hope_end_time, presense: true
  
  private
  
    def required_either_content_or_time
      return if content.present? ^ hope_start_time.present? || hope_end_time.present?
      errors.add(:base, "どちらか一方を入力してください")
    end
    
    def parse_time
      self.hope_start_time = Time.parse(self.hope_start_time)
      self.hope_end_time = Time.parse(self.hope_end_time)
    end
end
