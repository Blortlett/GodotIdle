class_name DestinationMenu extends Control;
# Button name list
@export var Destinations: Array[ExplorableArea];
# Button Storage
@export var ButtonParent: GridContainer;
var Buttons: Array[Button];
# Button Spawnable
@onready var mButton: PackedScene = preload("res://UI/ButtonUI/nButtonUI.tscn");

# Gamestate Manager
@onready var mGameStateManager: GameStateManager = get_tree().get_root().get_node("Node/GameStateManager")

# create buttons on start
func _ready() -> void:
	for i in Destinations.size():
		var new_button: Button = mButton.instantiate();
		ButtonParent.add_child(new_button);
		new_button.text = Destinations[i].Name;

func OnButtonMeadows():
	mGameStateManager.SwapToExploringState();

func OnButtonGraveyard():
	mGameStateManager.SwapToExploringState();
	
func OnButtonCanyon():
	mGameStateManager.SwapToExploringState();
	
