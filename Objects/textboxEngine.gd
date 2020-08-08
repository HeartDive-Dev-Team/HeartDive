extends Node2D


# General variables
export var message = [];
export var message_current = 0;
export var message_end = 0;
onready var target = get_node("message_draw");
export var textName = "";
export var textFaceArray = [];
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
		if(Input.is_action_just_pressed("keyZ")):
			opened = true;
			position = gotoPos;
			playerObject.reading = true;
	if(opened): #Player pressed Z
		if(characters < message[message_current].length()): #There's messages to write
			characters += 1 + hold;
			textFace.playing = true;
			target.set_bbcode(message[message_current].substr(0, characters));
			
			#Check the textFaceArray to change the textFace animation
			if(textFaceArray[message_current] != null):
				textFace.animation = textFaceArray[message_current];
			
			#Check to see if you can play the speech sound
			if(!audioPlayer.playing):
				audioPlayer.play();
		
		elif(characters >= message[message_current].length()): #No more messages
			textFace.playing = false;
			textFace.frame = 0;
			if(Input.is_action_just_pressed("keyZ")):
				if(message_current < message_end):
					characters = 0;
					message_current += 1;
				else:
					characters = 0;
					position = startPos;
					message_current = 0;
					opened = false;
					playerObject.reading = false;
					if(executeScriptonEnd):
						var myScript = scriptToRead.new();
						myScript._ready();


func _on_Area2D_body_entered(body):
	if(body.get_name() == "obj_Player"):
		active = true;
		playerObject = body;


func _on_Area2D_body_exited(body):
	if(body.get_name() == "obj_Player"):
		active = false;
