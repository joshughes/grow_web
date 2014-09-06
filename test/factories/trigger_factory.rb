FactoryGirl.define do
  factory :trigger do |ag|
    device { build (:device ) }
    condition "=="
    state false
    type "Temperature"
    value 0
  end
end