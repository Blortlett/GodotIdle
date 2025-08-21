class_name CraftRecipies extends Control
@onready var mInventoryUI: InventoryUI = get_tree().get_root().get_node("Node/GameUI")
@onready var mPlayerInventory: Inv = mInventoryUI.GetInventory();

@export var Craftables: RecipeBook;



func GetCraftableRecipies() -> Array[Recipe]:
	var PlayerItems: Array[InvItem] = mPlayerInventory.GetAllItems()
	# Output variable
	var CraftableRecipies: Array[Recipe]
	
	for recipe: Recipe in Craftables.mRecipies:
		if CheckCraftableRecipe(recipe, PlayerItems):
			CraftableRecipies.append(recipe)
	return CraftableRecipies

func CheckCraftableRecipe(_recipe: Recipe, _playerItems: Array[InvItem]) -> bool:
	for ingredient in _recipe.Ingredients:
		# If player doesnt have an item needed, return false
		if !_playerItems.has(ingredient.Item):
			return false
	return true # Player has all necessary items, return true
