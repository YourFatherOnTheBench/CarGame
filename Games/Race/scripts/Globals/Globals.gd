extends Node

var race_started: bool = false
var Stop_moving: bool = true
var LapsNeedToBeMade: int
var LapTimes = []
var RaceTime: float
var SinglePlayer

signal can_end
signal lap_made
signal race_ended
