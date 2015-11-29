json.meta do
  json.status 200
  json.message 'トークンを作成しました。'
end
json.response do
  json.auth_token @token
end
