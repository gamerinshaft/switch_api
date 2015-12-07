json.meta do
  json.status 201
  json.message '赤外線を作成しました。'
end
json.response do
  json.infrared @infrared
end
