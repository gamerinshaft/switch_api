json.meta do
  json.status 200
  json.message "#{@user.info.screen_name}の赤外線一覧を取得しました。"
end
json.response do
  json.schedules @schedules
end
