FactoryGirl.define do
  factory :device do |ag|
    sequence(:address) { |n| "P8#{n}" }
    sequence(:name)    { |n| "Test Device #{n}" }
    state true
    sequence(:id)
  end
end