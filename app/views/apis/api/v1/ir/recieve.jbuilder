json.meta do
  json.status 201
  json.message '赤外線データを作成しました。'
end
json.response do
  json.infrared @infrared, :name, :id, :count, :updated_at
end
