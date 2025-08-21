class_name CraftOutputDescription extends Node
@export var mItemNameLabel: Label
@export var mItemTypeLabel: Label
@export var mIngredientsParent: GridContainer
@export var mCraftButton: Button

func _ready() -> void:
	self.visible = false
	mCraftButton.text = "CRAFT"
	mCraftButton.size = Vector2.ZERO

func SetDescription(_recipe: Recipe):
	mItemNameLabel.text = _recipe.Products[0].Item.name
	mItemTypeLabel.text = InvItem.ItemType.keys()[_recipe.Products[0].Item.mItemType]
	self.visible = true

func ClearDescription():
	self.visible = false;
