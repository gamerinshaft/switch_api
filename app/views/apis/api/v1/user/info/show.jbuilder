json.meta do
  json.status 200
  json.message "ユーザー情報を取得しました"
end
json.response do
  json.user @info
end
