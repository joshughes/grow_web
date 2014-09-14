class TemperatureTaker 
  @queue = :take_temperature

  def self.perform()
    conn = Faraday.new
    response = conn.get 'http://arm:8080/temperature.json'
    body = JSON.parse(response.body)
    TemperatureReading.create(temperature: body["temperature"])
    HumidityReading.create(humidity: body["humidity"])
  end

end