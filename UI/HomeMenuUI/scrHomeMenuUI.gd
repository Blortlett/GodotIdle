class_name HomeMenu extends Control;
# Button name list
var ButtonNames: Array[String] = ["Craft", "Store", "Explore"]
# Button storage
@export var ButtonParent: GridContainer;
var Buttons: Array[Button];
# Button Spawnable
@onready var mButton: PackedScene = preload("res://UI/ButtonUI/nButtonUI.tscn");

# Gamestate Manager
@onready var mGameStateManager: GameStateManager = get_tree().get_root().get_node("Node/GameStateManager")

# create buttons on start
func _ready() -> void:
	for i in ButtonNames.size():
		var new_button: Button = mButton.instantiate();
		ButtonParent.add_child(new_button);
		new_button.text = ButtonNames[i];
		ImplementButton(new_button, i);

# -= Button Pressed Functions =-
func OnButtonExplore():
	mGameStateManager.SwapToDestinationMenuState();

# -= Assign button press to function switch =-
func ImplementButton(_Button: Button, _ButtonIndex: int):
	#if (ButtonIndex = 0):
	#elif (ButtonIndex = 1):
	if (_ButtonIndex == 2):
		_Button.pressed.connect(OnButtonExplore);
