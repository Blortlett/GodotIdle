class_name GameStateManager
extends Node

var CurrentGameState: GameState = null

func _ready() -> void:
	# Initialize with the default state (Home)
	ChangeState(HomeState.new(self))

func ChangeState(new_state: GameState) -> void:
	# Exit the current state if it exists
	if CurrentGameState != null:
		CurrentGameState.ExitState()
		CurrentGameState.queue_free()
	
	# Set and enter the new state
	CurrentGameState = new_state
	add_child(CurrentGameState)
	CurrentGameState.EnterState()

# Example state implementations
class HomeState extends GameState:
	func EnterState() -> void:
		print("Entered Home State")
		
	func ExitState() -> void:
		print("Exited Home State")

class DestinationMenuState extends GameState:
	func EnterState() -> void:
		print("Entered Destination Menu State")
		
	func ExitState() -> void:
		print("Exited Destination Menu State")

class ExploringState extends GameState:
	func EnterState() -> void:
		print("Entered Exploring State")
		
	func ExitState() -> void:
		print("Exited Exploring State")
