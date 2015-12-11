require_relative '../config/boot'
require_relative '../config/environment'

require 'clockwork'
include Clockwork

case Rails.env
when 'development'
  every(1.second, 'seconds.job') do
    puts "Running development job"
  end
when 'staging'
  every(1.minute, 'minutes.job') do
    puts "Running staging job"
  end
when 'production'
  every(1.hour, 'hours.job') do
    puts "Running staging job"
  end
else # Unknown
  every(1.day, 'days.job') do
    puts "Running production job"
  end
end

# Shared jobs
every(1.week, 'weeks.job') do
  puts "Running common job"
end

every(1.second, 'seconds.job', :thread => true) do
  puts AuthToken.all.count
end