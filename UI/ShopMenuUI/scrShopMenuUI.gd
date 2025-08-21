class_name ShopMenuUI extends Control
# HomeButton
@onready var mHomeButton: Control = get_node("Button");
# Shop Inventory
@onready var mShopInventoryUI: InventoryUI = get_node("InventoryGrid")
@onready var mShopInventorySlotUI: Array[Node] = mShopInventoryUI.get_children()
@onready var mShopInventory: Inv = mShopInventoryUI.GetInventory();
#Game manager object ref
@onready var mGameStateManager: GameStateManager = get_tree().get_root().get_node("Node/GameStateManager")
# UI Elements
var mSellLabels: Array[SellTimerLabel];
# Spawnable Item money
@export var mMoneyItemDef: InvItem;

# Sell Item Variables
var iUnlockedSellSlots: int = 4;
var iItemsForSale: int = 0;
var bItemSlotOccupied: Array[bool];

func _ready() -> void:
	mShopInventoryUI.SlotsUpdated.connect(SlotUpdate)
	# Connect Home button to return home function
	ImplementButton(mHomeButton);
	# Setup Sell slot featurs such as timer label
	for i in range(8):
		bItemSlotOccupied.append(false)
		mSellLabels.append(mShopInventorySlotUI[i].get_node("SellTimer"))
		mSellLabels[i].mSellSlotID = i
		mSellLabels[i].mParentShop = self;

func OnItemSell(_SlotID: int):
	var SellSlot := mShopInventory.slots[_SlotID]
	if SellSlot.item == null: return
	SellSlot.amount = SellSlot.item.SellPrice * SellSlot.amount
	SellSlot.item = mMoneyItemDef;
	mShopInventorySlotUI[_SlotID].update(SellSlot);
	bItemSlotOccupied[_SlotID] = false

func SlotUpdate():
	for i in range(8):
		if mShopInventory.slots[i].item && bItemSlotOccupied[i] == false:
			mSellLabels[i].StartTimer(mShopInventory.slots[i].item.TimeToSell)
			bItemSlotOccupied[i] = true

# Back button functionality
func ReturnHome():
	mGameStateManager.SwapToHomeState()
func ImplementButton(_Button):
	_Button.pressed.connect(ReturnHome)
