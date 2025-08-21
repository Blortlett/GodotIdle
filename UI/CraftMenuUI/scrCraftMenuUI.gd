class_name CraftMenu extends Control;
# Button name list
var ButtonNames: Array[String];
# Button storage
@export var ButtonParent: GridContainer;
var Buttons: Array[Button];
# HomeButton
@onready var mHomeButton: Control = get_node("Button");

# Gamestate Manager
@onready var mGameStateManager: GameStateManager = get_tree().get_root().get_node("Node/GameStateManager")
# Crafting Dictionary:
@onready var mCraftingDictionary: CraftRecipies = get_node("GridContainer")


func _ready() -> void:
	mHomeButton.pressed.connect(ReturnHome)
	mGameStateManager.state_changed.connect(CheckMenuOpen)

func RefreshCraftables():
	print_debug(":: CRAFTING ::")
	var CraftableRecipes: Array[Recipe] = mCraftingDictionary.GetCraftableRecipies()
	for i in range(CraftableRecipes.size()):
		print_debug("recipe craftable: " + CraftableRecipes[i].Products[0].Item.name)

# -= Menu functionality =-
#Home Button
func ReturnHome():
	mGameStateManager.SwapToHomeState()
#Open/Close listener
func CheckMenuOpen(new_state_type: GameState.StateType):
	if new_state_type == GameState.StateType.CRAFTING:
		RefreshCraftables()
