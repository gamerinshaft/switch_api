json.meta do
  json.status 201
  json.message "#{@screen_name}を登録しました"
end
json.response do
  json.auth_token @token
end
