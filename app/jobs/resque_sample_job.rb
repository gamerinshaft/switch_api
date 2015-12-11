class ResqueScheduleTask
  @queue = :resque_schdule_task
  def self.perform(text)
    path = File.expand_path("log/resque_schedule_task.log", Rails.root)
    File.open(path, 'a') do |f|
      f.puts text["screen_name"]
    end
  end
end