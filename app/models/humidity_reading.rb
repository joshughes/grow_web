class HumidityReading < ActiveRecord::Base
  include Readable
  validates :humidity, numericality: true, presence: true

  def self.humidity_data
    chart_data('humidity')
  end

end
