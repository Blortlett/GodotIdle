class_name UIController
extends Node

@onready var HomeUI: Control = get_node("../InventoryUI/BookLeftPageSprite/HomeMenuUI")
@onready var DestinationUI: Control = get_node("../InventoryUI/BookLeftPageSprite/DestinationMenuUI")
@onready var EnemyCharacterUI: Control = get_node("../InventoryUI/BookLeftPageSprite/CharacterDisplay")

func _ready():
	# Connect to state manager signals
	var state_manager = get_node("../GameStateManager")
	if state_manager:
		state_manager.state_changed.connect(_on_state_changed)
	
	hide_all_uis()
	HomeUI.visible = true;

func hide_all_uis():
	HomeUI.visible = false
	DestinationUI.visible = false
	EnemyCharacterUI.visible = false

func _on_state_changed(state_name: String):
	hide_all_uis()  # Hide all first
	print_debug(state_name);
	match state_name:
		"HomeState":
			HomeUI.visible = true
			print_debug("Showing Home Menu");
		"DestinationMenuState":
			DestinationUI.visible = true
			print_debug("Showing Destination Menu");
		"ExploringState":
			EnemyCharacterUI.visible = true
			print_debug("Showing Combat Zone");
		_:
			print_debug("Broke ass broken state fuck")
