extends Node2D

var inputstr = "" setget _set_inputstr

var writing = false setget _set_writing

signal spawn_command


var history = []
var index = 0

var commands = []


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
		
		
func execute(command):
	var commandList = command.rsplit(" ", false)
	var options = []
	var target = ""
	
	command = commandList[0]
	
	for c in commandList:
		if c[0] == "-":
			options.append(c)
		else:
			if target == "":
				target = c
	
	$GUILayer/Output.pushLine(command)
		
	
	
	
	
	
	
	
	
	
	
	
	