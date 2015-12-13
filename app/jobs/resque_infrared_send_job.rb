class ResqueInfraredSendJob
  @queue = :resque_infrared_send_job
  def self.perform(task)
    # path = File.expand_path("log/resque_infrared_send_job.log", Rails.root)
    schedule = Schedule.without_soft_destroyed.find_by(id: task['id'])
    user = schedule.user
    infrared = schedule.infrared
    fname = infrared.data
    path = Rails.root.to_s
    command = File.join(path, 'commands/send')
    `#{command} #{path}/data/#{fname}`
    count = infrared.count + 1
    infrared.update(count: count)
    log = user.logs.create(name: "「#{schedule.name}」のスケジューラーが「#{infrared.name}」を実行しました", status: :robot_send_ir)
    infrared.logs << log
  end
end
