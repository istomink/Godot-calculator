extends Node2D

func _ready():
	for item in $num.get_children():
		item.connect("pressed",self,"_button_press",[item.text])
	pass
	
func _button_press(txt):
	if txt == "=":
		var command = $Label.text
		var result = calc(command)
		if typeof(result) == TYPE_BOOL:
			$Label.text = "Error"
		else:
			$Label.text = str(result)
		
		pass
	elif txt == "C":
		$Label.text = ""
		pass
	else:
		var oldTxt = $Label.text
		var newTxt = oldTxt + txt
		$Label.text = newTxt
	pass

func calc(input):
	var script = GDScript.new()
	script.set_source_code("tool\nfunc eval():\n\treturn(" + input +")")
	var err = script.reload()
	if err != OK:
		return false
	var obj = Reference.new()
	obj.set_script(script)
	var result = obj.eval()
	return result
