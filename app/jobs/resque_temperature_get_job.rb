class ResqueTemperatureGetJob
  @queue = :resque_temperature_get_job
  def self.perform(user)
    path = Rails.root.to_s
    command = File.join(path, 'commands/temperature.rb')
    `sudo ruby #{command} #{path}/data/extra/temperature.txt`
    centigrade = File.read("#{path}/data/extra/temperature.txt")
    user = User.find(user['id'])
    user.create_room if user.room.nil?
    user.room.temperatures << Temperature.create(centigrade: centigrade)
  end
end
