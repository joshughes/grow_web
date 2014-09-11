class TemperatureReading < ActiveRecord::Base

  validates :temperature, numericality: true, presence: true
  validates :humidity, numericality: true, presence: true

  after_commit :run_triggers, on: :create

  def self.temperature_data
    chart_data('temperature')
  end

  def self.humidity_data
    chart_data('humidity')
  end

  def run_triggers
    Resque.enque("TemperatureReading", temperature)
  end

  private 

  def self.chart_data(attribute)
    reading_hash = {}
    TemperatureReading.all.each do | reading |
      reading_hash["#{reading.created_at}"] = reading.send(attribute)
    end
    reading_hash
  end
end
