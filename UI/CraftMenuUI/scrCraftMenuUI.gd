class_name CraftMenu extends Control;
# Button name list
var ButtonNames: Array[String];
# Crafting Slot button storage
@export var ButtonParent: GridContainer;
# Button spawnable:
@export var CraftButtonSpawnable: PackedScene = preload("res://UI/CraftMenuUI/CraftSlot/nCraftableSlot.tscn")
var mCraftButtons: Array[Button];

# Gamestate Manager
@onready var mGameStateManager: GameStateManager = get_tree().get_root().get_node("Node/GameStateManager")
# Crafting Dictionary:
@onready var mCraftingDictionary: CraftRecipies = get_node("GridContainer")

# HomeButton
@onready var mHomeButton: Control = get_node("Button");

func _ready() -> void:
	mHomeButton.pressed.connect(ReturnHome)
	mGameStateManager.state_changed.connect(CheckMenuOpen)

func RefreshCraftables():
	print_debug(":: CRAFTING ::")
	var CraftableRecipes: Array[Recipe] = mCraftingDictionary.GetCraftableRecipies()
	for i in range(CraftableRecipes.size()):
		var craftButton: CraftableSlotUI= CraftButtonSpawnable.instantiate()
		craftButton.SetDisplayItem(CraftableRecipes[i].Products[0].Item)
		mCraftButtons.append(craftButton)
		ButtonParent.add_child(craftButton)
		print_debug("recipe craftable: " + CraftableRecipes[i].Products[0].Item.name)

func RemoveCraftables():
	for child in ButtonParent.get_children():
		child.queue_free()

# -= Menu functionality =-
#Home Button
func ReturnHome():
	mGameStateManager.SwapToHomeState()
#Open/Close listener
func CheckMenuOpen(new_state_type: GameState.StateType):
	if new_state_type == GameState.StateType.CRAFTING:
		RefreshCraftables()
	else:
		RemoveCraftables()
