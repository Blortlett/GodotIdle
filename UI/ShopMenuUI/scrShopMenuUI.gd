class_name ShopMenuUI extends Control
# HomeButton
@onready var mHomeButtonParent = get_node("ButtonParent")
@onready var mHomeButton: Control = get_node("Button");
# Shop Inventory
@onready var mShopInventoryUI: InventoryUI = get_node("InventoryGrid")
@onready var mShopInventory: Inv = mShopInventoryUI.GetInventory();
#Game manager object ref
@onready var mGameStateManager: GameStateManager = get_tree().get_root().get_node("Node/GameStateManager")

# Sell Item Variables
var iUnlockedSellSlots: int = 4;
var iItemsForSale: int = 0;
var fSellSlotTimer: Array[float];

func _ready() -> void:
	# Connect Home button to return home function
	ImplementButton(mHomeButton);
	# Create SellTimers
	for i in range(iUnlockedSellSlots):
		fSellSlotTimer.append(0.0)


func TickSellSlots(delta_time: float):
	for i in iUnlockedSellSlots:
		if mShopInventory.slots[i].item != null:
			fSellSlotTimer[i] -= delta_time;


func ReturnHome():
	mGameStateManager.SwapToHomeState()
func ImplementButton(_Button):
	_Button.pressed.connect(ReturnHome)
