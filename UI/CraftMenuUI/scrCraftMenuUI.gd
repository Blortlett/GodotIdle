class_name CraftMenu extends Control;
# Button name list
var ButtonNames: Array[String];
# Button storage
@export var ButtonParent: GridContainer;
var Buttons: Array[Button];
# Button
@onready var mHomeButton: Control = get_node("Button");

# Gamestate Manager
@onready var mGameStateManager: GameStateManager = get_tree().get_root().get_node("Node/GameStateManager")
# Crafting Dictionary:
@onready var mCraftingDictionary: CraftRecipies = CraftRecipies.new()

# create buttons on start
func _ready() -> void:
	mHomeButton.pressed.connect(ReturnHome)

func ReturnHome():
	mGameStateManager.SwapToHomeState()

# -= Assign button press to function switch =-
#func ImplementButton(_Button: Button, _ButtonIndex: int):
	#if (_ButtonIndex == 0):
	#	_Button.pressed.connect(OnButtonCraft);
