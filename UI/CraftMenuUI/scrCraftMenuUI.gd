class_name CraftMenu extends Control;
# Button name list
var ButtonNames: Array[String];
# Button storage
@export var ButtonParent: GridContainer;
var Buttons: Array[Button];
# Button Spawnable
@onready var mButton: PackedScene = preload("res://UI/ButtonUI/nButtonUI.tscn");

# Gamestate Manager
@onready var mGameStateManager: GameStateManager = get_tree().get_root().get_node("Node/GameStateManager")
# Crafting Dictionary:
@onready var mCraftingDictionary: CraftRecipies = CraftRecipies.new()

# create buttons on start
func _ready() -> void:
	var i = 0;
	for recipe: Recipe in mCraftingDictionary.Craftables:
		var new_button: Button = mButton.instantiate();
		ButtonParent.add_child(new_button);
		new_button.text = recipe.RecipeName;
		ImplementButton(new_button, i);
		i += 1;

# -= Button Pressed Functions =-
func OnButtonExplore():
	mGameStateManager.SwapToDestinationMenuState();

func OnButtonCraft():
	print_debug("Craft Button Clicked")

func OnButtonShop():
	print_debug("Shop Button Clicked")

# -= Assign button press to function switch =-
func ImplementButton(_Button: Button, _ButtonIndex: int):
	if (_ButtonIndex == 0):
		_Button.pressed.connect(OnButtonCraft);
	elif (_ButtonIndex == 1):
		_Button.pressed.connect(OnButtonShop);
	elif (_ButtonIndex == 2):
		_Button.pressed.connect(OnButtonExplore);
