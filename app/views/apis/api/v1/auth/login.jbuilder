json.meta do
  json.status 201
  json.message "ログインに成功しました"
end
json.response do
  json.auth_token @token
end
