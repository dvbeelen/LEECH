extends Control

var waitTime = 15
var addStarted = false

func showAdd():
	if !addStarted:
		addStarted = true
		$AddTexts.text = Global.advertisements[Global.questionsAnswered -1]
		$Countdown.text = 'Skips automatically in 10 seconds'
		yield(get_tree().create_timer(10), 'timeout')
		self.visible = false
		get_parent().adShown = true
