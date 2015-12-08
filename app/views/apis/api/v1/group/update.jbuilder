json.meta do
  json.status 200
  json.message 'グループ名を変更しました。'
end
json.response do
  json.group @group
end
