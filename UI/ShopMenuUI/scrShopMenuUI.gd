class_name ShopMenuUI extends Control
# HomeButton
@onready var mHomeButtonParent = get_node("ButtonParent")
@onready var mHomeButton: Control = get_node("Button");
# Shop Inventory
@onready var mShopInventoryUI: InventoryUI = get_node("InventoryGrid")
@onready var mShopInventorySlotUI: Array[Node] = mShopInventoryUI.get_children()
@onready var mShopInventory: Inv = mShopInventoryUI.GetInventory();
#Game manager object ref
@onready var mGameStateManager: GameStateManager = get_tree().get_root().get_node("Node/GameStateManager")
# UI Elements
@onready var mSellLabelSpawnable := preload("res://UI/ShopMenuUI/ShopSellSlot/SellTimer/scrSellTimerLabel.gd");
var mSellLabels: Array[Label];
var mSellLabelTexts: Array[Label];

# Sell Item Variables
var iUnlockedSellSlots: int = 4;
var iItemsForSale: int = 0;
var fSellSlotTimers: Array[float];
var bSellSlotOccupied: Array[bool];

func _ready() -> void:
	mShopInventory.update.connect(SlotUpdate)
	# Connect Home button to return home function
	ImplementButton(mHomeButton);
	# Create SellTimers
	for i in range(iUnlockedSellSlots):
		fSellSlotTimers.append(0.0)

func SlotUpdate():
	for i in range(8):
		if mShopInventory.slots[i] != null:
			bSellSlotOccupied[i] = true;
		else:
			bSellSlotOccupied[i] = false;

func TickSellSlots(delta_time: float):
	var i = 0
	var tickedSlots = 0
	while tickedSlots < iUnlockedSellSlots:
		if bSellSlotOccupied[i] == true:
			fSellSlotTimers[i] -= delta_time;
			tickedSlots += 1
		i += 1

#func UpdateSellTimerLabel(TimerText: float):
	


func ReturnHome():
	mGameStateManager.SwapToHomeState()
func ImplementButton(_Button):
	_Button.pressed.connect(ReturnHome)
