extends Node

enum rooms {throne, hallway, hall, steps_left, kitchen}

var currentScene = "room"
var currentRoom = rooms.throne
var player: CharacterBody2D
var playerInCamlockArea: bool = false
