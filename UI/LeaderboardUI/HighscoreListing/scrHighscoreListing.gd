class_name HighscoreListing extends Node

var mHighscoreData: HighscoreData

@export var NameLabelUI: Label
@export var KillsLabelUI: Label
@export var CashLabelUI: Label
@export var ScoreLabelUI: Label

func Display(_HighscoreData: HighscoreData) -> void:
	mHighscoreData = _HighscoreData
	NameLabelUI.text = mHighscoreData.PlayerName
	KillsLabelUI.text = str(mHighscoreData.EnemyKills)
	CashLabelUI.text = str(mHighscoreData.CashCollected)
	ScoreLabelUI.text = str(mHighscoreData.FinalScore)
