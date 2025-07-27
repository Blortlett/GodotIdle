extends Node

var inventory: Dictionary = {}

func update_item(item, amount):
	if inventory.has(item):
		inventory[item] += amount
	else:
		inventory[item] = amount
	
	if inventory[item] <= 0:
		inventory.erase(item)

func craft_item(key_name):
	var recipe: Dictionary = CraftingRecipies.crafting_dict[key_name]
	
	if recipe != null:
		var products: Dictionary = recipe["products"]
		var ingredients: Dictionary = recipe["ingredients"]
		
		if inventory.has_all(ingredients.keys()):
			var obtained_ingredients: int = 0
			for item in ingredients:
				if inventory[item] >= ingredients[item]:
					obtained_ingredients += 1
			
			if obtained_ingredients == ingredients.size():
				for item in ingredients:
					update_item(item, ingredients)
				for product in products:
					update_item(product, products[product])
		else:
			print("cant craft due to missing ingredients.")
