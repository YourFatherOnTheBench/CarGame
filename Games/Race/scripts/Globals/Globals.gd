extends Node

var race_started: bool = false
var Stop_moving: bool = true
var LapsNeedToBeMade: int
var LapTimes = []
var RaceTime: float
var SinglePlayer
var Players = {}

signal can_end
signal lap_made(body)
signal race_ended
signal sync_data(pid, time)


func _ready():
	restart()


func restart():
	race_started = false
	Stop_moving = true
	LapTimes = []
	RaceTime = 0
	Players = {}
	for i in ["1", "2"]:
		Players[i] = {
			"name": "P" + i,
			"id": i,
			"Laps": [],
			"time": 0.00,
			"LapsMade": 1,
			"CheckpointsMade": 0
		}
