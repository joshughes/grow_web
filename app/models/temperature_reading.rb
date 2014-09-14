class TemperatureReading < ActiveRecord::Base
  include Readable

  validates :temperature, numericality: true, presence: true

  after_save :run_triggers
end
