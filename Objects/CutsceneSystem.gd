extends Node2D

# Declare member variables here. Examples:
var scenePhase = 0;
var i = 0;
var readingText = false;
export(NodePath) var textWriter;
var rootTextWriter;
var myTextWriter;

# Called when the node enters the scene tree for the first time.
func _ready():
	rootTextWriter = get_node(textWriter);
	myTextWriter = rootTextWriter.get_node("CanvasLayer/textBox");


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#match scenePhase:
		#0: #Pantalla en negro con 2 segundos de delay
			#playerActor.visible = false;
			#if(i >= 300):
				#get_node("CanvasLayer/FadeIn").active = true;
			#_delay(480);
	pass

func _delay(myDelay):
	if(!readingText):
		if(i < myDelay):
			i += 1;
		else:
			scenePhase += 1;
			i = 0;
	else:
		if(myTextWriter.finished):
			scenePhase += 1;
			closeMessage();

func showMessage(msg):
	if(!readingText):
		readingText = true;
		myTextWriter.message = msg;
		myTextWriter.showText();

func closeMessage():
	readingText = false;
	
func changePortrait(SpriteFrames):
	myTextWriter.get_node("textFace").frames = SpriteFrames;
	
func changeVoice(AudioStream):
		if(myTextWriter.get_node("talkSound").stream != AudioStream):
			myTextWriter.get_node("talkSound").stream = AudioStream;
func changeName(string):
	myTextWriter.get_node("textName").text = string;

func changeAnimation(string):
	myTextWriter.get_node("textFace").animation = string;
