json.meta do
  json.status 201
  json.message "#{@group.name}を作成しました。"
end
json.response do
  json.group @group
end
