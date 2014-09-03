class TemperatureController < ApplicationController
  respond_to :json

  def show
    render :json => TemperatureReading.take_reading.as_json
  end

  

end
