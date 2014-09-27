class TemperatureReading < ActiveRecord::Base
  include Readable
  validates :temperature, numericality: true, presence: true
end
