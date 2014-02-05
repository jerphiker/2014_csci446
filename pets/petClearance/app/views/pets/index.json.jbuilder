json.array!(@pets) do |pet|
  json.extract! pet, :id, :type, :name, :breed, :description, :image_url
  json.url pet_url(pet, format: :json)
end
