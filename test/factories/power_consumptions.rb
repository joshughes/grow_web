# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :power_consumption do
    device { build (:device ) }
  end
end
