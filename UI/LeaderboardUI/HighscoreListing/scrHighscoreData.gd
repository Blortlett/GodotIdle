class_name HighscoreData extends Resource
@export var PlayerName: String
@export var EnemyKills: int
@export var CashCollected: int
var FinalScore: int

var KillToScoreMult = 10
var CashToScoreMult = 3

func CalculateFinalScore():
	var KillScore = EnemyKills * KillToScoreMult
	var CashScore = CashCollected * CashToScoreMult
	FinalScore = KillScore + CashScore
