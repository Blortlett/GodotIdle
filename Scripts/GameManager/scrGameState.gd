class_name GameState
extends Node

var game_manager: GameStateManager

func _init(manager: GameStateManager) -> void:
	game_manager = manager

func EnterState() -> void:
	pass

func ExitState() -> void:
	pass
