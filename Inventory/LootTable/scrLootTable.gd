class_name LootTable extends Resource
@export var mLootTable: Array[LootTableEntry];

func SpawnLootDrop() -> Array[InvSlot]:
	print_debug("LOOTSPAWN!!!!!!!")
	var LootPack: Array[InvSlot];
	# Loop through Loot Table
	for i in range(0, mLootTable.size()):
		# Roll the dice and see if item will spawn
		if randf_range(0, 100) <= mLootTable[i].ChanceToSpawn:
			# Add item to loot pack
			var spawnAmount = randi_range(mLootTable[i].MinAmount, mLootTable[i].MaxAmount);
			LootPack.append(InvSlot.new(mLootTable[i].Loot, spawnAmount));
	return LootPack;
