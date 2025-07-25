class_name GameStateManager
extends Node

@onready var HomeUI: Control = get_node("../InventoryUI/");
@onready var DestinationUI: Control = get_node("../InventoryUI/BookLeftPageSprite/DestinationMenuUI");
@onready var EnemyCharacterUI: Control = get_node("../InventoryUI/BookLeftPageSprite/CharacterDisplay");

var CurrentGameState: GameState = null

var gameStates: Array[GameState] = [
	HomeState.new(self),
	DestinationMenuState.new(self),
	ExploringState.new(self)
]


func _ready() -> void:
	# Initialize with the default state (Home)
	ChangeState(HomeState.new(self))

func ChangeState(new_state: GameState) -> void:
	# Exit the current state if it exists
	if CurrentGameState != null:
		CurrentGameState.ExitState()
	
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



# Swap to specific state functions
func SwapToHomeState():
	ChangeState(gameStates[0])

func SwapToDestinationMenuState():
	ChangeState(gameStates[1])

func SwapToExploringState():
	ChangeState(gameStates[2])
