json.meta do
  json.status 200
  json.message "「#{@group.name}」の赤外線一覧を取得しました。"
end
json.response do
  json.group do
    json.infrareds @group.infrareds
  end
end
