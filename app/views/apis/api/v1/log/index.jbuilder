json.meta do
  json.status 200
  json.message "#{@user.info.screen_name}のログ一覧を取得しました。"
end
json.response do
  json.logs @logs
end
