class_name Leaderboard extends Control
var mLeaderboardData: LeaderboardData
@export var HighscoreParentUI: GridContainer
@export var mNameTextInput: TextInput

#spawnable listing
@export var SpawnableHighscoreListing: PackedScene = preload("res://UI/LeaderboardUI/HighscoreListing/nHighscoreListing.tscn")
# Data save location
var save_path = "user://highscore_leaderboard.tres"

# Restart button
@export var RestartButton: Button

func _ready() -> void:
	RestartButton.pressed.connect(RestartGame)
	mNameTextInput.mLeaderboardController = self
	LoadLeaderboardData()
	Close();

func Open():
	self.visible = true;
	mNameTextInput.GetName();

func Close():
	self.visible = false;

func LoadLeaderboardData():
	if FileAccess.file_exists(save_path):
		mLeaderboardData = ResourceLoader.load(save_path) as LeaderboardData
	else:
		mLeaderboardData = LeaderboardData.new()  # Create empty if none exists

func DisplayLeaderboard():
	var HighscoresUI = HighscoreParentUI.get_children()
	for listing in HighscoresUI:
		listing.free()
	for highscore in mLeaderboardData.highscores:
		var NewHighscoreListing = SpawnableHighscoreListing.instantiate()
		var scrHighscoreListing: HighscoreListing = NewHighscoreListing
		scrHighscoreListing.Display(highscore)
		HighscoreParentUI.add_child(NewHighscoreListing)

func SaveHighscore(_HighscoreData: HighscoreData):
	mLeaderboardData.highscores.append(_HighscoreData)
	var err = ResourceSaver.save(mLeaderboardData, save_path)
	if err != OK:
		print("Error saving leaderboard: ", err)
	DisplayLeaderboard()

func RestartGame():
	print("Restarting Game...")
