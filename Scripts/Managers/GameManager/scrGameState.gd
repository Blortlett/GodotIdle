class_name GameState
extends Node

enum StateType {
	HOME,
	DESTINATION_MENU,
	EXPLORING,
	SHOP,
	CRAFTING,
	GAMEOVER,
	MAINMENU,
}

var game_manager: GameStateManager
var state_type: StateType

func _init(manager: GameStateManager) -> void:
	game_manager = manager

func EnterState() -> void:
	pass

func ExitState() -> void:
	pass
