extends Control

var waitTime = 15

func _ready():
	$Countdown.text = 'Skip in ' + String(waitTime) + ' seconds'
	$AddTexts.text = Global.advertisements[randi()%Global.questionsAnswered]

