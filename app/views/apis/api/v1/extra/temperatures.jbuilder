json.meta do
  json.status 200
  json.message '気温情報を取得しました。'
end
json.response do
  json.temperatures @temperatures
end
