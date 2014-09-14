require 'test_helper'

class ReadableTest < ActiveSupport::TestCase
  test "returns correct reading_method" do
    assert_equal "temperature", TemperatureReading.reading_method
  end

  test 'chart data' do
    past_time = ""
    Timecop.freeze(Date.today - 30) do
     past_time = Time.current.utc.to_s
     FactoryGirl.create(:temperature_reading)
    end
    recent = FactoryGirl.create(:temperature_reading, {temperature: 2})
    recent_time = recent.created_at.utc.to_s

    test_hash = {past_time => 1, recent_time => 2 }
    assert_equal test_hash, TemperatureReading.chart_data
  end
end