extends Spatial

export var Text = ''
export var fontPath = ''

onready var label = $Viewport/Control/SubDisplayLabel

func _ready():
	label.add_font_override('normal_font', load(fontPath))
	label.text = Text
