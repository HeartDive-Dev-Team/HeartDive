extends Node2D


# General variables
export var message = "";
export var finished = false;
onready var target = get_node("message_draw");
export var textName = "";
export(SpriteFrames) var textFaceFrames;
export var textFaceAnimation = "";
export var executeScriptonEnd = false;
export(Script) var scriptToRead;

#Set the canvas to follow
onready var targetCanvas = get_parent();
var startPos;
var gotoPos = Vector2(208, 32);
var active = false;
var opened = false;
var playerObject;

var characters = 0;
var hold = 0;
onready var audioPlayer = get_node("talkSound");
onready var textFace = get_node("textFace");

# Called when the node enters the scene tree for the first time.
func _ready():
	startPos = get_position();
	get_node("textName").text = textName;

func _holdFaster():
	if(Input.is_action_pressed("keyZ")):
		hold = 0.5;
	else:
		hold = 0;

func _process(delta):
	_holdFaster();
	if(active and !opened): #Waiting for the player to open the message
		opened = true;
		position = gotoPos;
		finished = false;
		#playerObject.reading = true;
	if(opened):
		if(characters < message.length()): #There's messages to write
			characters += 1 + hold;
			textFace.playing = true;
			target.set_bbcode(message.substr(0, characters));
			
			print(audioPlayer.playing)
			#Check to see if you can play the speech sound
			if(!audioPlayer.playing):
				audioPlayer.play();
		
		elif(characters >= message.length()): #No more messages
			textFace.playing = false;
			textFace.frame = 0;
			if(Input.is_action_just_pressed("keyZ")):
				finished = true;
				characters = 0;
				position = startPos;
				opened = false;
				closeText();
				if(executeScriptonEnd):
					var myScript = scriptToRead.new();
					myScript._ready();


func showText():
	active = true;
	visible = true;
	finished = false;


func closeText():
	active = false;
	visible = false;
