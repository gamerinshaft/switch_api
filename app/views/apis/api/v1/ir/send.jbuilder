json.meta do
  json.status 201
  json.message '赤外線データを照射しました。'
end
json.response do
  json.ir_id @infrared
end
