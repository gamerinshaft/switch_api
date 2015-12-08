json.meta do
  json.status 200
  json.message 'グループ一覧を取得しました。'
end
json.response do
  json.groups @groups
end

