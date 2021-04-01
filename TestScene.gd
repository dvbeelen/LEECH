extends Spatial

func showText():
	var textToShow = get_node("Texts/TextDisplay" + String(Global.textTriggerNr))
	textToShow.get_node("Viewport/Control/Label").text = Global.bookTexts[Global.textTriggerNr]
	textToShow.get_node("anim").play('fadeIn')

func removeText():
	var textToShow = get_node("Texts/TextDisplay" + String(Global.textTriggerNr))
	textToShow.get_node("anim").play('fadeOut')
