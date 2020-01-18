extends Node2D

var inputstr = "" setget _set_inputstr

var writing = false setget _set_writing

signal delete_command
signal color_command
signal move_command
signal copy_command
signal list_command


var history = []
var index = 0

var errors = {
	"noTarget": "you have to specify a target",
	"noCommand": "command %s undefined",
	"noParams": "not enought parameters for this command. Check help for more info"
}

var help = {
	"help": "help <<command>> for more info. Avaiable commands -->  delete  color  move  copy  list",
	"delete": "delete <<id>> --> It deletes the object specified",
	"color": "color <<id>> <<color>> --> It changes the color of the object to red, blue, green or black",
	"move": "move <<id>> <<x>> <<y>> --> It moves the object a few coordinates",
	"copy": "copy <<id>> --> It copies the object",
	"list": "list --> List of avaiable objects"
}


func _ready():
	self.writing = false
	self.inputstr = ""
	add_to_group("Console")


func _input(event):
	if event is InputEvent and event.is_pressed():
		if writing:
			if event.is_action_pressed("ui_exit"):
				self.writing = false
			else:
				var s = event.as_text()
				
				if s == "Enter":
					if inputstr != "":
						execute(inputstr)
						historyApend()
						self.inputstr = ""
						self.writing = false
				if s == "BackSpace":
					self.inputstr = inputstr.substr(0, inputstr.length() - 1)
				if s == "Space":
					self.inputstr = self.inputstr + " "
				if s == "Minus":
					self.inputstr = self.inputstr + "-"
				if s == "Shift+7":
					self.inputstr = self.inputstr + "/"
				if s == "Shift+Minus":
					self.inputstr = self.inputstr + "_"
				if s == "Up":
					historyUp()
				if s == "Down":
					historyDown()	
				if s.length() == 1:
					self.inputstr = self.inputstr + s.to_lower()
					
		elif event.is_action_pressed("ui_write"):
			self.writing = true


func historyApend():
	history.append(inputstr)
	index = 0

	
func historyUp():
	if history.size() == 0:
		self.inputstr = ""
		return
	
	index = index + 1
	if index > history.size():
		index = history.size()
	self.inputstr = history[history.size() - index]
	
	
func historyDown():
	index = index - 1
	if index > 0:
		self.inputstr = history[history.size() - index]
	else:
		index = 0
		self.inputstr = ""


func _set_inputstr(text):
	inputstr = text
	$GUILayer/TextInputDisplay.set_text(inputstr)
	
	
	
func _set_writing(val):
	writing = val
	self.inputstr = ""
	
	if writing:
		$GUILayer/WritingLabel.visible = true
		$GUILayer/TextInputDisplay.visible = true
		$GUILayer/ColorRect.visible = true
	else:
		$GUILayer/WritingLabel.visible = false
		$GUILayer/TextInputDisplay.visible = false
		$GUILayer/ColorRect.visible = false
		

func out(text):
	$GUILayer/Output.pushLine(text)

func execute(command):
	var params = command.rsplit(" ", false)

	command = params[0]
	
	if command == "help":
		if params.size() > 1:
			print(params)
			if help.has(params[1]):
				out(help[params[1]])
			else:
				out(errors["noCommand"]%[params[1]])
		else:
			out("help <<command>> for more info. Avaiable commands -->  delete  color  move  copy  list")
			
	elif command == "delete":
		if params.size() < 2:
			out(errors["noParams"])
			return
			
		emit_signal("delete_command", params[1])
		
	elif command == "color":
		if params.size() < 3:
			out(errors["noParams"])
			return
			
		emit_signal("color_command", params[1], params[2])
		
	elif command == "move":
		if params.size() < 4:
			out(errors["noParams"])
			return
			
		emit_signal("move_command", params[1], params[2], params[3])
		
	elif command == "copy":
		if params.size() < 2:
			out(errors["noParams"])
			return
			
		emit_signal("copy_command", params[1])
		
	elif command == "list":
		var scriptable = get_tree().get_nodes_in_group("Scriptable")
		var text = ""
		
		for s in scriptable:
			text = text + " " + s.get_name()
		
		if text == "":
			text = "There is nothing to list"
		out(text)
	else:
		out(errors["noCommand"]%[command])
		
	
	
	
	
	
	
	
	
	
	
	
	