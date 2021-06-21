extends Control

onready var chatLog = $boxContainer/chatLog
onready var writeLine = $boxContainer/HBoxContainer/writeLine
onready var nameLabel = $boxContainer/HBoxContainer/Label

var methodChosen = false
var questionAnswered = false
var scoldedOrAnswered = false

var hints = [
	'Look closely at the paintings, see any symbols on them?',
	'Maybe your co-player knows more about the symbols on the walls...',
	'You will need 4 numbers to escape, 2 from your room, 2 from your co-players',
	'Look at the green house',
	'Look in the lake',
	'Look at the top-left tree',
	'Look at the right in the sky above the mountains',
	'The correct order is house, tree, mountain, lake'
]

var questions = [
	'What is your favorite food?',
	'What is your favorite tv show?',
	'What is your favorite sport?',
	'Who is your favorite musical artist?',
	'What is your favorite movie?',
	'What is the last thing you bought from the grocery store?',
	'What is the last piece of clothing you bought?',
	'What is your favorite color of shoe?'
]

func _ready():
	chatLog.text = "Need a hint?, you have " + String(hints.size() - Global.hintsSeen) + " hints remaining"

func startChat():
	writeLine.grab_focus()

func _process(_delta):
	if self.visible:
		startChat()
		if Input.is_action_just_pressed("enter"):
			chatLogPrint(Global.playerName, writeLine.text)
			writeLine.clear()
		if Input.is_action_just_pressed("escape"):
			self.visible = false
			$CanvasLayer/ColorRect.visible = false

func chatLogPrint(username, text):
#	Setting playername for the first time
	if !methodChosen:
		print('setting player name')
		Global.playerName = text
		nameLabel = Global.playerName
		chatLog.text = "I will give you a hint, but I would like something in return."
		yield(get_tree().create_timer(2.5), 'timeout')
		chatLog.text = "To help me learn to assist you better, I would like you to answer a short question about yourself."
		yield(get_tree().create_timer(2.5), 'timeout')
		chatLog.text = "This will only take a second and will help me to assist you in more ways."
		yield(get_tree().create_timer(2.5), 'timeout')
		chatLog.text = "Any information given is for training purposes only and will not be saved in any way."
		yield(get_tree().create_timer(2.5), 'timeout')
		chatLog.text = "Do you want to answer the question? Answer Yes or No."
		methodChosen = true
		return
	if methodChosen && text == 'yes':
		chatLog.text = 'Thank you!'
		yield(get_tree().create_timer(2.5), 'timeout')
		chatLog.text = 'Please provide an answer, even if the question does not fully apply to you.'
		yield(get_tree().create_timer(2.5), 'timeout')
		chatLog.text = questions[Global.questionsAnswered]
		questionAnswered = true
		return
	if methodChosen && questionAnswered && !scoldedOrAnswered:
		chatLog.text = 'Interesting answer, thank you for providing it.'
		yield(get_tree().create_timer(2.5), 'timeout')
		chatLog.text = 'Your co operation is greatly appreciated..'
		yield(get_tree().create_timer(2.5), 'timeout')
		chatLog.text = 'Press enter to receive your hint'
		saveGivenAnswer(text, Global.questionsAnswered)
		increaseQuestionsAnswered()
		scoldedOrAnswered = true
		return
	if methodChosen && text == 'no':
		chatLog.text = 'I see, I am sorry to hear that.'
		yield(get_tree().create_timer(2.5), 'timeout')
		chatLog.text = 'By not answering my questions, my services cannot improve.'
		yield(get_tree().create_timer(2.5), 'timeout')
		chatLog.text = 'To encourage you to answer the question next time, I will lower your LEECHat character limit by 10 characters.'
		yield(get_tree().create_timer(2.5), 'timeout')
		chatLog.text = 'Consider answering the questions next time. Hopefully we can help each other out better in the future...'
		lowerCharacters()
		yield(get_tree().create_timer(2.5), 'timeout')
		chatLog.text = 'Press enter to receive the hint'
		questionAnswered = true
		scoldedOrAnswered = true
		return
	if methodChosen && questionAnswered && scoldedOrAnswered:
		methodChosen = false
		chatLog.text = hints[Global.hintsSeen]
		Global.hintsSeen += 1
		yield(get_tree().create_timer(12), 'timeout')
		questionAnswered = false
		scoldedOrAnswered = false
		chatLogPrint(Global.playerName, writeLine.text)
		return

func lowerCharacters():
	Global.maxCharactersForChat -= 10
	print(Global.maxCharactersForChat)

func increaseQuestionsAnswered():
	Global.questionsAnswered += 1

func saveGivenAnswer(answer, number):
	Global.givenAnswers[number] = answer
	print (Global.givenAnswers[number])
