json.extract! recipe, :id, :title, :story, :instructions, :ingredients, :complexity, :time, :created_at, :updated_at
json.url recipe_url(recipe, format: :json)
