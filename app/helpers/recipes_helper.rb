module RecipesHelper
	def format_global_time(recipe)
		global_time = recipe.preparation_time.to_i + recipe.waiting_time.to_i + recipe.baking_time.to_i
		hours, minutes = global_time.divmod(60)
		if hours == 0
			minutes.to_s + " min"
		elsif minutes == 0
			hours.to_s + "h"
		else
			hours.to_s + "h" + minutes.to_s
		end
	end

	def format_complexity(recipe)
		case recipe.complexity
		when 1
			"Simple"
		when 2
			"Moyen"
		when 3
			"Difficile"
		end
	end
end
