json.array!(@vehicles) do |vehicle|
  json.extract! vehicle, :id, :manufacturer_id, :model, :description, :price
  json.url vehicle_url(vehicle, format: :json)
end
