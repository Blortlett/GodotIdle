class_name UIController
extends Node

@onready var HomeUI: Control = get_node("../GameUI/SystemUI/HomeMenuUI")
@onready var DestinationUI: Control = get_node("../GameUI/SystemUI/DestinationMenuUI")
@onready var EnemyCharacterUI: Control = get_node("../GameUI/SystemUI/CombatMenuUI")
@onready var mShopMenuUI: Control = get_node("../GameUI/SystemUI/ShopMenuUI")
@onready var CraftingMenuUI: Control = get_node("../GameUI/SystemUI/CraftMenuUI")

# Player UIs / Right side screen UIs
@onready var mInventoryUI: Control = get_tree().get_root().get_node("Node/GameUI/SystemUI/InventoryUI")
@onready var mCharacterUI: Control = get_tree().get_root().get_node("Node/GameUI/SystemUI/CharacterUI")


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
	mShopMenuUI.visible = false
	CraftingMenuUI.visible = false

func hide_player_uis():
	#mInventoryUI.visible = false;
	mCharacterUI.visible = false;

func show_player_uis():
	#mInventoryUI.visible = true;
	mCharacterUI.visible = true;

func _on_state_changed(state_type: GameState.StateType):
	# Hide all first
	hide_all_uis();
	
	# Turn on active UI determined by active state
	match state_type:
		GameState.StateType.HOME:
			HomeUI.visible = true
			show_player_uis();
		GameState.StateType.DESTINATION_MENU:
			DestinationUI.visible = true
		GameState.StateType.EXPLORING:
			EnemyCharacterUI.visible = true
		GameState.StateType.SHOP:
			mShopMenuUI.visible = true;
		GameState.StateType.CRAFTING:
			CraftingMenuUI.visible = true;
			hide_player_uis()
		_: # default case (Means shit's broken)
			print_debug("Broke ass broken state fuck")
