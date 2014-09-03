class TemperatureReading < ActiveRecord::Base

  validates :temperature, numericality: true, presence: true
  validates :humidity, numericality: true, presence: true

  def self.take_reading
    conn = Faraday.new
    response = conn.get 'http://arm:8080/temperature.json'
    body = JSON.parse(response.body)
    TemperatureReading.create(temperature: body["temperature"], humidity: body["humidity"])
  end

  def self.temperature_data
    chart_data('temperature')
  end

  def self.humidity_data
    chart_data('humidity')
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
