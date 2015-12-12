json.meta do
  json.status 200
  json.message 'cronを翻訳しました'
end
json.response do
  json.translation @translation
end
