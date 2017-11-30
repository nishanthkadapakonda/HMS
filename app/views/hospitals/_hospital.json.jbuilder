json.extract! hospital, :id, :name, :place, :pin, :phone, :created_at, :updated_at
json.url hospital_url(hospital, format: :json)
