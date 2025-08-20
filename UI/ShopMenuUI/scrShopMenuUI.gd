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
	SellSlot.amount = SellSlot.item.SellPrice
	SellSlot.item.ItemID = mMoneyItemDef.ItemID;
	mShopInventorySlotUI[_SlotID].update(SellSlot);

func SlotUpdate():
	if mShopInventory.slots[0].item:
		mSellLabels[0].StartTimer(mShopInventory.slots[0].item.TimeToSell)

# Back button functionality
func ReturnHome():
	mGameStateManager.SwapToHomeState()
func ImplementButton(_Button):
	_Button.pressed.connect(ReturnHome)
