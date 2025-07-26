class_name InventoryActions extends Control
@onready var InventoryGrid: GridContainer = get_node("../InventoryGrid");
@onready var InventorySlots: Array[SlotUI] = InventoryGrid.get_children();

func _ready() -> void:
	for Slot in InventorySlots:
		#subscribe to signal here
