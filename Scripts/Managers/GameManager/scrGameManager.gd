class_name GameStateManager extends Node

signal state_changed(state_type: GameState.StateType)

var CurrentGameState: GameState = null
var gameStates: Array[GameState] = []

func _ready() -> void:
	gameStates = [
		HomeState.new(self),
		DestinationMenuState.new(self),
		ExploringState.new(self),
		ShopState.new(self),
		CraftingState.new(self),
	]
	
	for state in gameStates:
		self.add_child(state)
	
	ChangeState(gameStates[0])

func ChangeState(new_state: GameState) -> void:
	if CurrentGameState != null:
		CurrentGameState.ExitState()
	
	CurrentGameState = new_state
	#add_child(CurrentGameState)
	CurrentGameState.EnterState()
	
	# Emit signal with state type enum
	state_changed.emit(new_state.state_type)


# Simplified state implementations
class HomeState extends GameState:
	@onready var mCombatManager: CombatManager = get_tree().get_root().get_node("Node/CombatManager")
	@onready var mDisplayController: CharacterDisplayController = get_tree().get_root().get_node("Node/GameUI/CharacterDisplayController")
	func _init(manager: GameStateManager):
		super(manager)
		state_type = StateType.HOME
		
	func EnterState() -> void:
		print("Entered Home State")
		# UI is handled by signal system
		mCombatManager.IsHome = true;
		mDisplayController.PlayerDisplay.OnPlayerArriveHome()
		
	func ExitState() -> void:
		print("Exited Home State")
		mCombatManager.IsHome = false;

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

class ShopState extends GameState:
	func _init(manager: GameStateManager):
		super(manager)
		state_type = StateType.SHOP
	
	func EnterState() -> void:
		print("Entered Shop State")
		
	func ExitState() -> void:
		print("Exited Shop State")

class CraftingState extends GameState:
	func _init(manager: GameStateManager):
		super(manager)
		state_type = StateType.CRAFTING
	
	func EnterState() -> void:
		print("Entered Craft State")
		
	func ExitState() -> void:
		print("Exited Craft State")

# Swap functions remain the same
func SwapToHomeState():
	ChangeState(gameStates[0])

func SwapToDestinationMenuState():
	ChangeState(gameStates[1])

func SwapToExploringState():
	ChangeState(gameStates[2])

func SwapToShopState():
	ChangeState(gameStates[3])

func SwapToCraftingState():
	ChangeState(gameStates[4])
