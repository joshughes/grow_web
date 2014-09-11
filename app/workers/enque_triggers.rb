class EnqueTriggers
  @queue = :run_triggers

  def self.perform(type, sensor_reading)
    Triggers.find_each(type: type).each do | trigger |
      Resque.enque(RunTrigger, trigger.id, sensor_reading)
    end
  end
end