require 'test_helper'

class TriggerTest < ActiveSupport::TestCase
  test "the truth" do
    FactoryGirl.create(:reading)
  end
end
