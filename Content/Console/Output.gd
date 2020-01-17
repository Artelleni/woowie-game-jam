extends Label

var lines = ["", "", "", ""]


func pushLine(line):
	lines = [lines[1], lines[2], lines[3], line]
	
	text = "%s\n%s\n%s\n%s" % lines