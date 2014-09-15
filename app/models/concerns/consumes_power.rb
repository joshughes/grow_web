module ConsumesPower
  extend ActiveSupport::Concern

  included do 
    after_create :create_power_consumption, if: :state?
    after_update :update_power_consumption, unless: :state?
  end

  

end

