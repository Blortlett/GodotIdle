extends Node

var crafting_dict: Dictionary = {}

var campfire_recipe: Dictionary = {
	"ingredients": {"wood" = 3, "rock" = 5},
	"products": {"campfire" = 1}
}

var cooked_fish_recipe: Dictionary = {
	"ingredients": {"campfire" = 1, "fish" = 1},
	"products": {"cooked_fish" = 1, "ash" = 3}
}

func _ready() -> void:
	crafting_dict["campfire"] = campfire_recipe;
	crafting_dict["cooked_fish"] = cooked_fish_recipe;
