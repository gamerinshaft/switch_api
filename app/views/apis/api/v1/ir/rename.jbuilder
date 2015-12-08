json.meta do
  json.status 200
  json.message '赤外線名を変更しました。'
end
json.response do
  json.infrared @infrared, :name, :id, :count, :updated_at
end
