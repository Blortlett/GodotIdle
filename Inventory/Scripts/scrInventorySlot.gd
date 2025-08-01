class_name InvSlot extends Resource;
# stored item data
var SlotID: int;
@export var item: InvItem;
@export var amount: int;
@export var mIsEquipmentSlot: bool;
@export var mEquipmentType: InvItem.ArmorSlot;

signal ItemUpdated(item: InvItem);

func _init(_item: InvItem = null, _amount: int = 0) -> void:
	item = _item;
	amount = _amount;

# slot functions
func PickFromSlot():
	print_debug("Item Dragged from slot")

func DropToSlot():
	print_debug("Item dropped into slot")
	emit_signal("ItemUpdated", item)

func Use():
	# Return if no item
	if (item == null || amount == 0):
		return
	# If last item of stack, empty the stack
	if (amount == 1):
		item = null
	# If multiple items in stack, remove one item
	elif (amount > 1):
		amount -= 1;
	# Use Item here
	print_debug("Item Used!")
