class_name GameStateManager
extends Node

signal state_changed(state_type: GameState.StateType)

var CurrentGameState: GameState = null
var gameStates: Array[GameState] = []

func _ready() -> void:
	gameStates = [
		HomeState.new(self),
		DestinationMenuState.new(self),
		ExploringState.new(self)
	]
	
	ChangeState(gameStates[0])

func ChangeState(new_state: GameState) -> void:
	if CurrentGameState != null:
		CurrentGameState.ExitState()
		CurrentGameState.queue_free()
	
	CurrentGameState = new_state
	add_child(CurrentGameState)
	CurrentGameState.EnterState()
	
	# Emit signal with state type enum
	state_changed.emit(new_state.state_type)

# Simplified state implementations
class HomeState extends GameState:
	func _init(manager: GameStateManager):
		super(manager)
		state_type = StateType.HOME
		
	func EnterState() -> void:
		print("Entered Home State")
		# UI is handled by signal system
		
	func ExitState() -> void:
		print("Exited Home State")

class DestinationMenuState extends GameState:
	func _init(manager: GameStateManager):
		super(manager)
		state_type = StateType.DESTINATION_MENU
		
	func EnterState() -> void:
		print("Entered Destination Menu State")
		
	func ExitState() -> void:
		print("Exited Destination Menu State")

class ExploringState extends GameState:
	func _init(manager: GameStateManager):
		super(manager)
		state_type = StateType.EXPLORING
		
	func EnterState() -> void:
		print("Entered Exploring State")
		
	func ExitState() -> void:
		print("Exited Exploring State")

# Swap functions remain the same
func SwapToHomeState():
	ChangeState(gameStates[0])
	
func SwapToDestinationMenuState():
	ChangeState(gameStates[1])
	
func SwapToExploringState():
	ChangeState(gameStates[2])
