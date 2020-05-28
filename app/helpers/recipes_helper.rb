module RecipesHelper

	# Convert preparation time into human readable string
	def preparation_time_human(recipe)
		convert_time_to_human(recipe.preparation_time)
	end

	# Convert baking time into human readable string
	def baking_time_human(recipe)
		convert_time_to_human(recipe.baking_time)
	end

	# Convert waiting time into human readable string
	def waiting_time_human(recipe)
		convert_time_to_human(recipe.waiting_time)
	end

	# Convert global time into human readable string
	def global_time_human(recipe)
		global_time = recipe.preparation_time.to_i + recipe.waiting_time.to_i + recipe.baking_time.to_i
		convert_time_to_human(global_time)
	end

	# Convert complixity time into human readable string
	def complexity_human(recipe)
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

def convert_time_to_human(integer)
	hours, minutes = integer.to_i.divmod(60)
	if hours == 0
		minutes.to_s + " min"
	elsif minutes == 0
		hours.to_s + "h"
	else
		hours.to_s + "h" + minutes.to_s
	end
end