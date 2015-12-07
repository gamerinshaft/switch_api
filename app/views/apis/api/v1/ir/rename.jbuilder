json.meta do
  json.status 200
  json.message '赤外線名を変更しました。'
end
json.response do
  json.infrared @infrared, :name, :id, :updated_at
end
