extends Node2D

func _ready():
	pass # Replace with function body.

func _input(event):
	if event is InputEventMouseButton && event.is_pressed():
		#print("Pressed")
		print(event.position.x)
		print(event.position.y)
		var boxIndex = getBoxIndex(event.position.x, event.position.y)
		selectBox(boxIndex)
	

func getBoxIndex(x, y):
	if x < 100:
		if y < 160:
			return 0
		elif y > 170 && y < 270:
			return 3
		elif y > 280 && y < 380:
			return 6
	elif x > 110 && x < 210:
		if y < 160:
			return 1
		elif y > 170 && y < 270:
			return 4
		elif y > 280 && y < 380:
			return 7
	elif x > 220:
		if y < 160:
			return 2
		elif y > 170 && y < 270:
			return 5
		elif y > 280 && y < 380:
			return 8		
	return -1

func selectBox(index):
	#print("Select Box " + String(index))
	if index == -1:
		return
	
	var boxSelected; 
	if index == 0:
		boxSelected = $Rect0
	elif index == 1:
		boxSelected = $Rect1
	elif index == 2:
		boxSelected = $Rect2
	elif index == 3:
		boxSelected = $Rect3
	elif index == 4:
		boxSelected = $Rect4
	elif index == 5:
		boxSelected = $Rect5
	elif index == 6:
		boxSelected = $Rect6
	elif index == 7:
		boxSelected = $Rect7
	elif index == 8:
		boxSelected = $Rect8
		
	boxSelected.color = Color(0,0,255)
