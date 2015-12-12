json.meta do
  json.status 201
  json.message "#{@schedule.name}を停止しました。"
end
json.response do
  json.schedule @schedule
end
