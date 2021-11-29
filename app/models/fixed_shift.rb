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
  # TOKEN = '9XvCN3N3DLTyLpGV3mpmknTaVqHtS24mof6cxYW1jzE'.freeze
  # URL = 'https://notify-api.line.me/api/notify'.freeze
  
  # def send(message)
  #   Net::Http.start(uri.hostname, uri.port, use_ssl: true) do |https|
  #     https.request(request)
  #   end
  # end
  
  private
  
    def required_either_absence_or_time
      return if absence? ^ (fixed_start_time.present? || fixed_end_time.present?)
      errors.add(:absence_or_fixed_time, "のどちらかを入力してください")
    end
    
    def require_validation?
      return true if errors.any? || absence?
      false
    end
    
    # def request
    #   request = Net::HTTP::Post.new(uri)
    #   request['Authorization'] = "Bearer #{TOKEN}"
    #   request.set_form_data(message: message)
    #   request
    # end
    
    # def uri
    #   URI.parse(URL)
    # end
end
