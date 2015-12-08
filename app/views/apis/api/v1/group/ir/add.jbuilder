json.meta do
  json.status 201
  json.message "「#{@group.name}」に#{@ir.name}を追加しました。"
end
json.response do
  json.group do
    json.infrareds @group.infrareds
  end
end
