namespace :room do
  task :temperature do
    path = Rails.root.to_s
    command = File.join(path, 'commands/temperature.rb')
    `ruby #{command}`
  end
end
