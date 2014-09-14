class EnqueTriggers
  @queue = :run_triggers

  def self.perform(type, sensor_reading)
    Trigger.where(reading_type: type).find_each do | trigger |
      Resque.enqueue(RunTrigger, trigger.id, sensor_reading)
    end
  end
end