json.array!(@retails) do |retail|
  json.extract! retail, 
  json.url retail_url(retail, format: :json)
end
