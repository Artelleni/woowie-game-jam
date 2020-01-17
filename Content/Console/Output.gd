extends Label

var lines = ["", "", "", ""]

export var maxLen = 80


func doInsertLine(line):
	lines = [lines[1], lines[2], lines[3], line]
	

# Adds an output of the console
func pushLine(line):
	line = ">> " + line
	var words = line.rsplit(" ", false)
	line = ""
	
	for w in words:
		if line.length() + w.length() > maxLen:
			doInsertLine(line)
			line = ""
		
		line = line + " " + w
	
	doInsertLine(line)
	
	
	text = "%s\n%s\n%s\n%s" % lines
	
	# We make it dissapear over time
	$Tween.interpolate_property(self, "modulate",
	        Color(1, 1, 1, 1), Color(1, 1, 1, 0), 10,
	        Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	$Tween.start()