extends Node

var category_by_scancode = {}
var factory_has_envelopes = true
var spam_mails = {
	"bob.doe@x-vinagra.com":		"enlarge your very chickEn! Make your chicKEN BIGgeR in just two minutes or more!",
	"elmer.man@x-cyalus.uk":		"Your THE VERY FIrst one and only you tHAT WIN THIS PRIZE!!!111!!111",
	"puseekat@x-kittens.au":		"Free kittiNs! pay for 15 and get 10! Moar for your bucKs! kittens!",
	"mandy.moor@x-corn.tk":			"hot elephants alone in your ciTy! get a trunk for free! (actually you better pay)",
	"mutombo@x-mokelele.ng":		"i'm a prince and hAVE TonS OF MAneY to give yOu! Send me plz so i can send back.",
	"warky.barper@x-bay.er":		"uh-oh, your prescription is expirinG. Buy morE! MORE! Run you fool!",
	"waldo@digital-mark.et":		"[urgeNt] you've GOT ONLY 1 YeaR to watch this, or you'll dIe. eventualLy. someday.",
	"assist@gym-tonic.com":			"Your gym plan goes bye-bye tonight, better buy some beer tickets.",
	"auntie@film-affonic.com":		"[WEEKEND ONLy] complete your collection OF vhs film tapes before they worn out.",
	"guybrush@threepwood.com":		"You fight like a cow.",
	"what@x-many-cube.com":			"don't open this e-maIl! no, really, don't do iT!! you just did, did you?",
	"sell@x-vomistar.es":			"licking your phone never tasted so gooD. enjoy your meal.",
	"developers@x-party.now"	:	"Keep playing, we're having beer right now.",
	"venus@x-space.travel":			"NEw! Book your next vacations on venus, the heaviest of the planets!",
	"im@a-zone.com":				"gift inspiration for lazy people: give money in an envelope.",
	"spam@x-spam.spam":				"grow your email list 10x faster with thIS SPam generator.",
	"kasparov@x-chess.ru":			"CHESS!! CHESS!! amazing chess gameplays On blUe-Ray for your chessy tastes.",
	"hammer@fall.de":				"your computar is iN BRÜTAL DANGER!!11!! smash it hard with a hammer.",
	"phil@elic.es":					"get the latest shiniest of the shinier iN PHILATELy anD DON'T LOOK BACK!!",
	"candy@x-zing.com":				"stop wasting timE! my time is priceless!! go plAy canDy cash instead.",
	"arthur@x-language.bg":			"learn to spEak bulgarian so fast you can speak it yesterdAy! Oui!",
	"mad.hatter@x-wonderland.com":	"happy unbirthday to you! click here to see some ads.",
	"monthy@peiton.fr":				"I fArt in your general direction! Your mother was a hamster and your father smelt of elderberries.",
	"game@x-blizzard.com":			"[newsteeleR] May 1994 - february 2006. nothing happened.",
	"this@game.joke":				"online cansino! spin the wheel to win cherries, peaches and watermelon.",
}


func _ready() -> void:
	var categories = $Sidebar.get_categories()

	var current_scancode = KEY_F1
	for category in categories:
		category_by_scancode[current_scancode] = category
		current_scancode += 1

	$Factory.set_available_categories(categories)
	_set_current_category(categories[0])

	$Timer.start()


func _input(event : InputEvent) -> void:
	if not event is InputEventKey or event.is_echo() or not event.is_pressed():
		return

	var pressed_key = OS.get_scancode_string(event.scancode)
	if pressed_key.length() == 1:
		$Playground.remove_envelope_by_label(pressed_key)
		return

	if event.scancode in category_by_scancode.keys():
		_set_current_category(category_by_scancode[event.scancode])


func _set_current_category(category) -> void:
	$Sidebar.set_current_category(category.name)
	$Playground.set_current_category(category)


func _on_Timer_timeout() -> void:
	if factory_has_envelopes:
		var envelope = $Factory.create_random_envelope()
		$Playground.add_envelope(envelope)
	else:
		$MailFailed.play()
		$Sidebar.tainted_envelope()


func _on_Factory_no_more_envelopes():
	factory_has_envelopes = false


func _on_Factory_more_envelopes():
	factory_has_envelopes = true


func _on_Playground_sent_envelope(envelope: Envelope) -> void:
	var impulse = $Sidebar.current_category.rect_global_position - envelope.global_position
	envelope.linear_velocity = Vector2()
	envelope.apply_central_impulse(impulse)


func _on_Sidebar_correct_category() -> void:
	$MailOk.play()


func _on_Sidebar_wrong_category() -> void:
	var random = randi() % spam_mails.size()
	var from = spam_mails.keys()[random]
	$Inbox.add_message(from, spam_mails[from])
	spam_mails.erase(from)
	$MailFailed.play()


func _on_Inbox_overflow() -> void:
	var gameover_scene = preload("res://ui/GameOver/GameOver.tscn")
	var gameover = gameover_scene.instance()

	gameover.set_highscore($Sidebar.highscore)

	gameover.pause_mode = PAUSE_MODE_PROCESS
	add_child(gameover)
	get_tree().paused = true
	yield(gameover, "tree_exited")
	get_tree().paused = false
	get_tree().change_scene("res://ui/Title/TitleMenu.tscn")
