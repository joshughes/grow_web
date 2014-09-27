class HumidityReading < ActiveRecord::Base
  include Readable
  validates :humidity, numericality: true, presence: true
end
