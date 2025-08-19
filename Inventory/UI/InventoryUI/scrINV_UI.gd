class_name InventoryUI extends Control;
@export var mInv: Inv;
@export var mSlotParent: Node;
var mSlots: Array[Node];
var isOpen = false;

func _ready() -> void:
	mSlots = mSlotParent.get_children();
	mInv.update.connect(UpdateSlots);
	UpdateSlots();
	open();

func UpdateSlots():
	var slotCount: int = 0
	for i in range(min(mInv.slots.size(), mSlots.size())):
		mSlots[i].update(mInv.slots[i])
		slotCount += 1
	print_debug(name + "Found " + str(slotCount + 1) + " Inventory GUI slots")

func open():
	visible = true;
	isOpen = true;

func close():
	visible = false;
	isOpen = false;

func GetInventory() -> Inv:
	return mInv;
