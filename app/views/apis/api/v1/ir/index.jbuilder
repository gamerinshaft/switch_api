json.meta do
  json.status 200
  json.message '赤外線データ一覧を受信しました。'
end
json.response do
  json.infrareds @infrareds, :name, :id, :updated_at
end

