class_name UIController
extends Node

@onready var HomeUI: Control = get_node("../GameUI/SystemUI/HomeMenuUI")
@onready var DestinationUI: Control = get_node("../GameUI/SystemUI/DestinationMenuUI")
@onready var EnemyCharacterUI: Control = get_node("../GameUI/SystemUI/CombatMenuUI")
@onready var ShopMenuUI: Control = get_node("../GameUI/SystemUI/ShopMenuUI")
@onready var CraftingMenuUI: Control = get_node("../GameUI/SystemUI/CraftMenuUI")


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
	ShopMenuUI.visible = false
	CraftingMenuUI.visible = false


func _on_state_changed(state_type: GameState.StateType):
	# Hide all first
	hide_all_uis();
	
	# Turn on active UI determined by active state
	match state_type:
		GameState.StateType.HOME:
			HomeUI.visible = true
		GameState.StateType.DESTINATION_MENU:
			DestinationUI.visible = true
		GameState.StateType.EXPLORING:
			EnemyCharacterUI.visible = true
		GameState.StateType.SHOP:
			ShopMenuUI.visible = true;
		GameState.StateType.CRAFTING:
			CraftingMenuUI.visible = true;
		_: # default case (Means shit's broken)
			print_debug("Broke ass broken state fuck")
