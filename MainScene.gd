extends Node2D

enum State {STATE_PLAYER_TURN, STATE_CHECK_WIN, STATE_OPPONENT_TURN, STATE_ENDGAME}
var opponentBoxes = []
var playerBoxes = []

var currentState = State.STATE_PLAYER_TURN

func _ready():
	$Timer.connect("timeout",self,"_on_timer_timeout")
	pass # Replace with function body.

func _input(event):
	if currentState == State.STATE_OPPONENT_TURN:
		return
	
	if event is InputEventMouseButton && event.is_pressed():
		#print("Pressed")
#		print(event.position.x)
#		print(event.position.y)
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
	if opponentBoxes.has(index):
		$TulisanArahan.text = "Ini bukan kamu punya"
		return
	
	if playerBoxes.has(index):
		$TulisanArahan.text = "Pilih lain"
		return
	
	playerBoxes.append(index)
	
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
	moveToNextState()

func moveToNextState():
	var opponentBoxCount = opponentBoxes.size()
	var playerBoxCount = playerBoxes.size()
	
	print("Opponent box count " + String(opponentBoxCount))
	print("Player box count " + String(playerBoxCount))
	
	var boxSelectedCount = opponentBoxCount + playerBoxCount
	if boxSelectedCount >= 9:
		$TulisanArahan.text = "Habis dah lah"
		
		return
	
	if currentState == State.STATE_PLAYER_TURN:
		currentState = State.STATE_OPPONENT_TURN
		$TulisanArahan.text = "Tunggu eh.."
		$Timer.start(0.5)
	elif currentState == State.STATE_OPPONENT_TURN:
		currentState = State.STATE_PLAYER_TURN
		$TulisanArahan.text = "Silakan"

func superAdvancedAIPlayNextStep():
	var opponentBoxCount = opponentBoxes.size()
	var playerBoxCount = playerBoxes.size()
	
	var boxSelectedCount = opponentBoxCount + playerBoxCount
	if boxSelectedCount >= 9:
		$TulisanArahan.text = "Habis dah lah"
		currentState = State.STATE_ENDGAME
		return
	
	var isAvailable = false
	var boxToSelect = -1
	
	while isAvailable == false:
		var randomBoxIndex = randi() % 8
		if opponentBoxes.has(randomBoxIndex) == false && playerBoxes.has(randomBoxIndex) == false:
			isAvailable = true
			boxToSelect = randomBoxIndex
	opponentSelectBox(boxToSelect)
	
func _on_timer_timeout():
	$Timer.stop()
	superAdvancedAIPlayNextStep()
	
func opponentSelectBox(index):
	if index == -1:
		return
		
	opponentBoxes.append(index)
	
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
		
	boxSelected.color = Color(0,255,0)
	moveToNextState()
	
