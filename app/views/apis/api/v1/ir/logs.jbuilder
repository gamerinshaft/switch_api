json.meta do
  json.status 200
  json.message 'ログデータ一覧を受信しました。'
end
json.response do
  json.logs @logs
end
