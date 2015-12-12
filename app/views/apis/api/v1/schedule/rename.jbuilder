json.meta do
  json.status 200
  json.message "スケジューラーを「#{@schedule.name}」にリネームしました"
end
json.response do
  json.schedule @schedule
end
