class_name InventoryActions extends Control
# Item drag graphics
@onready var mDragHandler: ItemDragGfxHandler = get_node("ItemDragGfxHandler");
var mLastHoveredInvUI: InventoryUI;
var mLastHoveredID: int;
var mIsHoveringInv: bool = false;
var mLastAccessedInvUI: InventoryUI;
var mLastAccessedID: int;
# Inventory UI
@onready var mInventoryGrid: GridContainer = get_node("../InventoryGrid");
@onready var mInventorySlots: Array[Node] = mInventoryGrid.get_children();
# Inventory Object
@onready var mInventoryUI: InventoryUI = get_node("../../..")
@onready var mEquipmentUI: EquipmentManager = get_node("../../CharacterUI/EquipmentUI")
@onready var mInventory: Inv = mInventoryUI.GetInventory();
# Consumable Helper
@onready var mConsumableManager: ConsumableManager = get_tree().get_root().get_node("Node/ConsumableManager")

var mIsItemHeld: bool = false;

func _ready() -> void:
	# Sign up to EquipmentUI interaction signals
	var EquipmentSlots: Array[SlotUI] = mEquipmentUI.GetUISlots()
	for i in EquipmentSlots.size():
		var slot = EquipmentSlots[i]
		var button: Control = slot.get_node("CenterContainer")
		button.mouse_entered.connect(func(): OnInventoryHovered(mEquipmentUI.GetUI(), i))
		button.mouse_exited.connect(func(): OnInventoryUnhovered(mEquipmentUI.GetUI(), i))
	# Sign up to InventoryUI interaction signals
	for i in mInventorySlots.size():
		var slot = mInventorySlots[i]
		var button: Control = slot.get_node("CenterContainer")
		button.mouse_entered.connect(func(): OnInventoryHovered(mInventoryUI, i))
		button.mouse_exited.connect(func(): OnInventoryUnhovered(mInventoryUI, i))

func OnInventoryHovered(inventoryUI: InventoryUI, slot_index: int):
	mLastHoveredInvUI = inventoryUI;
	mLastHoveredID = slot_index;
	mIsHoveringInv = true;
	print_debug("HoveredInv: " + mLastHoveredInvUI.name + "  HoveredID: " + str(mLastHoveredID))

func OnInventoryUnhovered(inventoryUI: InventoryUI, slot_index: int):
	if mLastHoveredInvUI == inventoryUI:
		mLastHoveredInvUI = null;
	if mLastHoveredID == slot_index:
		mLastHoveredID = -1;
	mIsHoveringInv = false;

# Left Mouse click/release input here
func _unhandled_input(event: InputEvent):
	# LeftMouse release
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed():
			OnLeftMouseButtonPressed()
		elif event.is_released():
			OnLeftMouseButtonReleased()

func OnLeftMouseButtonPressed():
	if mIsHoveringInv:
		print_debug("Try grab from: " + mLastHoveredInvUI.name)
		DragItem(mLastHoveredInvUI, mLastHoveredID);

func OnLeftMouseButtonReleased():
	if mIsHoveringInv: # Player Suggests to move item
		if mLastHoveredID == mLastAccessedID && mLastHoveredInvUI == mLastAccessedInvUI: 
			# Dropped item at same location
			# Assuming click/use slot
			print_debug("Attempting Consume on Item")
			ConsumeItem();
			DropDraggedItem(mLastHoveredInvUI, mLastHoveredID);
		else: # Move item/stack to new location
			DropDraggedItem(mLastHoveredInvUI, mLastHoveredID);
	else: # invalid move, return item to original slot
		DropDraggedItem(mLastAccessedInvUI, mLastAccessedID);

func ConsumeItem():
	if !mDragHandler.mIsItemHeld:
		return; # No item program might crash, so abort
	if !mDragHandler.mItemSlot.item.mItemType == InvItem.ItemType.CONSUMABLE:
		return;
	var slot: InvSlot = mDragHandler.mItemSlot
	mConsumableManager.ProcessConsume(slot.item);
	# Consuming last item of stack
	if slot.amount <= 1:
		slot.item = null;
		slot.amount = 0;
	else: # Consume one item
		slot.amount -= 1;
	# Update UI
	mLastAccessedInvUI.UpdateSlots();
	ClearHeldItemVars()

func DragItem(inventoryUI: InventoryUI, slot_index: int):
	print_debug("Pressed: " + inventoryUI.name)
	# track where item came from incase want to cancel
	mLastAccessedInvUI = inventoryUI;
	mLastAccessedID = slot_index
	# Get Slot
	var slot = inventoryUI.GetInventory().slots[slot_index]
	if slot.amount == 0 or !slot.item:
		return
	mDragHandler.OnItemDragged(slot)
	inventoryUI.UpdateSlots(); # Update Inventory UI
	mIsItemHeld = true;

func DropDraggedItem(inventoryUI: InventoryUI, slot_index: int):
	if !inventoryUI:
		return; # invalid operation, no drop spot found
	# Get destination slot
	var slotToDropItem: InvSlot = inventoryUI.GetInventory().slots[slot_index];
	var originalSlot: InvSlot = mLastAccessedInvUI.GetInventory().slots[mLastAccessedID];
	# Check if slot is occupied
	if slotToDropItem.item && slotToDropItem.amount > 0:
		# Inv Slot already has item, swap with other slot
		originalSlot.item = slotToDropItem.item
		originalSlot.amount = slotToDropItem.amount
		mDragHandler.OnItemDropped(slotToDropItem)
		mLastAccessedInvUI.UpdateSlots();
		mLastHoveredInvUI.UpdateSlots();
		ClearHeldItemVars()
	else:
		# Empty slot: Drop Item
		mDragHandler.OnItemDropped(slotToDropItem)
		#Update UI with new drop position
		inventoryUI.UpdateSlots(); # Update Inventory UI
		# Update held item variables to reflect no item held
		ClearHeldItemVars()

func ClearHeldItemVars():
	mIsItemHeld = false;
	mLastAccessedInvUI = null;
	mLastAccessedID = -1;
