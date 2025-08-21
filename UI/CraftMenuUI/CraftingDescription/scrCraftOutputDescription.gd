class_name CraftOutputDescription extends Node
@export var mItemIconDisplay: SlotUI
@export var mItemNameLabel: Label
@export var mItemTypeLabel: Label
@export var mIngredientsParent: GridContainer
@export var mCraftButton: Button
var mCraftMenuUI: CraftMenu

#Ingredient icon display spawnable
var mItemDisplaySpawnable = preload("res://Inventory/UI/ItemDisplaySlot/nItemIconDisplay.tscn")
# Variable array for all display icons on screen
var mIngredientDisplaySlots: Array[Control]

func _ready() -> void:
	self.visible = false
	mCraftButton.text = "CRAFT"
	mCraftButton.size = Vector2.ZERO

func SetIngredientsDisplay(_ingredients: Array[ItemAmount]):
	var OldIngredients := mIngredientsParent.get_children()
	for ingredient in OldIngredients:
		ingredient.queue_free()
	for ingredient in _ingredients:
		var newIconDisplay = mItemDisplaySpawnable.instantiate()
		var newIconSlot: SlotUI = newIconDisplay.get_node("InvSlotUI") as SlotUI
		var newInvSlot: InvSlot = InvSlot.new()
		newInvSlot.item = ingredient.Item
		newInvSlot.amount = ingredient.Amount
		newIconSlot.update(newInvSlot)
		mIngredientDisplaySlots.append(newIconDisplay)
		mIngredientsParent.add_child(newIconDisplay)

func SetDescription(_recipe: Recipe):
	# Set item description name & type
	mItemNameLabel.text = _recipe.Products[0].Item.name
	mItemTypeLabel.text = InvItem.ItemType.keys()[_recipe.Products[0].Item.mItemType]
	# Set item description icon
	var DescItemIcon: InvSlot = InvSlot.new()
	DescItemIcon.item = _recipe.Products[0].Item
	DescItemIcon.amount = _recipe.Products[0].Amount
	mItemIconDisplay.update(DescItemIcon)
	# Set ingredients item icons
	SetIngredientsDisplay(_recipe.Ingredients)
	self.visible = true

func AttemptCraft():
	mCraftMenuUI.CraftItem()

func ClearDescription():
	self.visible = false;
