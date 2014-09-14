FactoryGirl.define do
  factory :trigger do |ag|
    device { build (:device ) }
    condition "=="
    state false
    reading_type "TemperatureReading"
    value 0
  end
end