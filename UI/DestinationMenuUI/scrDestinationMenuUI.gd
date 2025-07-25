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
@onready var mCharacterRegister: CharacterRegister = get_tree().get_root().get_node("Node/CharacterRegister")

# create buttons on start
func _ready() -> void:
	for i in Destinations.size():
		var new_button: Button = mButton.instantiate();
		ButtonParent.add_child(new_button);
		new_button.text = Destinations[i].Name;
		ImplementButton(new_button, i);

# -= Button Pressed Functions =-
func OnButtonMeadows():
	mGameStateManager.SwapToExploringState();
	mCharacterRegister.RespawnEnemy();

func OnButtonGraveyard():
	mGameStateManager.SwapToExploringState();
	mCharacterRegister.RespawnEnemy();
	
func OnButtonCanyon():
	mGameStateManager.SwapToExploringState();
	mCharacterRegister.RespawnEnemy();
	
# -= Assign button press to function switch =-
func ImplementButton(_Button: Button, _ButtonIndex: int):
	if (_ButtonIndex == 0):
		_Button.pressed.connect(OnButtonMeadows);
	elif (_ButtonIndex == 1):
		_Button.pressed.connect(OnButtonGraveyard);
	elif (_ButtonIndex == 2):
		_Button.pressed.connect(OnButtonCanyon);
