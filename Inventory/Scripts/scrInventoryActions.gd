class_name InventoryActions extends Control
# Item drag graphics
@onready var mDragHandler: ItemDragGfxHandler = get_node("ItemDragGfxHandler");
var mLastAccessedInvUI: InventoryUI;
var mLastAccessedID: int;
# Inventory UI
@onready var mInventoryGrid: GridContainer = get_node("../InventoryGrid");
@onready var mInventorySlots: Array[Node] = mInventoryGrid.get_children();
# Inventory Object
@onready var mInventoryUI: InventoryUI = get_node("../../..")
@onready var mEquipmentUI: EquipmentManager = get_node("../../CharacterUI/EquipmentUI")
@onready var mInventory: Inv = mInventoryUI.GetInventory();

var mIsItemHeld: bool = false;

func _ready() -> void:
	# Sign up to InventoryUI interaction signals
	for i in mInventorySlots.size():
		var slot = mInventorySlots[i]
		var button := slot.get_node("CenterContainer/Button")
		button.pressed.connect(func(): OnInventoryClicked(i))
	# Sign up to EquipmentUI interaction signals
	var EquipmentSlots: Array[SlotUI] = mEquipmentUI.GetUISlots()
	print_debug("EquipmentSlots size: " + str(EquipmentSlots.size()))
	for i in EquipmentSlots.size():
		var slot = EquipmentSlots[i]
		var button := slot.get_node("CenterContainer/Button")
		button.pressed.connect(func(): OnEquipmentClicked(i))

func OnInventoryClicked(slot_index: int):
	# Debug
	print_debug("Clicked inventory slot index: %d" % slot_index)
	OnSlotClicked(mInventoryUI, slot_index)

func OnEquipmentClicked(slot_index: int):
	# Debug
	print_debug("Clicked equipment slot index: %d" % slot_index)
	OnSlotClicked(mEquipmentUI.GetUI(), slot_index)

# Left Mouse Unclicked input here
func _unhandled_input(event: InputEvent):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_released():
			OnLeftMouseButtonReleased()

#Called by both OnInventoryClicked & OnEquipmentClicked
func OnSlotClicked(inventoryUI: InventoryUI, slot_index: int):
	# Drop held Item to slot
	if mIsItemHeld:
		DropDraggedItem(inventoryUI, slot_index)
	# Try Pickup item from slot
	else:
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

func OnLeftMouseButtonReleased():
	print_debug("Drop Item here :)")
	DropDraggedItem(mLastAccessedInvUI, mLastAccessedID);

func DropDraggedItem(inventoryUI: InventoryUI, slot_index: int):
	mDragHandler.OnItemDropped(inventoryUI.GetInventory().slots[slot_index])
	inventoryUI.UpdateSlots(); # Update Inventory UI
	mIsItemHeld = false;
