class_name Recipe extends Resource

@export var RecipeName: String;
@export var Ingredients: Array[ItemAmount];
@export var Products: Array[ItemAmount];

# Helper function to get ingredient amount by item
func get_ingredient_amount(item: InvItem) -> int:
	for ingredient in Ingredients:
		if ingredient.Item == item:
			return ingredient.Amount
	return 0

# Helper function to get product amount by item
func get_product_amount(item: InvItem) -> int:
	for product in Products:
		if product.Item == item:
			return product.Amount
	return 0
