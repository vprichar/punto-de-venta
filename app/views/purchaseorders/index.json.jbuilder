json.array!(@purchaseorders) do |purchaseorder|
  json.extract! purchaseorder, :id, :item_id, :store_configuration_id, :user_id, :committed, :stock_id
  json.url purchaseorder_url(purchaseorder, format: :json)
end
