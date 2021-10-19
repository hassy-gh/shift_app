class Form::FixedShiftCollection < Form::Base
  FORM_COUNT = 5
  attr_accessor :fixed_shifts
  
  def initialize(attributes = {})
    super attributes
    self.fixed_shifts = FORM_COUNT.times.map { FixedShift.new() } unless self.fixed_shifts.present?
  end
  
  def fixed_shifts_attributes=(attributes)
    self.fixed_shifts = attributes.map { |_, v| FixedShift.new(v) }
  end
  
  def save
    FixedShift.transaction do
      self.fixed_shifts.map(&:save!)
    end
      return true
    rescue => e
      return false
    end
end