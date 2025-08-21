class_name CraftOutputDescription extends Node
@export var mItemNameLabel: Label
@export var mItemTypeLabel: Label
@export var mIngredientsParent: GridContainer

func _ready() -> void:
	self.visible = false

func SetDescription(_recipe: Recipe):
	mItemNameLabel.text = _recipe.Products[0].Item.name
	mItemTypeLabel.text = InvItem.ItemType.keys()[_recipe.Products[0].Item.mItemType]
	self.visible = true

func ClearDescription():
	self.visible = false;
