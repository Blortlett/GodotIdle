class_name InvSlot extends Resource;
# stored item data
@export var item: InvItem;
@export var amount: int;

# slot functions
#func PickFromSlot():
	#remove_child(item);
	#var inventoryNode = find_parent("Inventory");
	
