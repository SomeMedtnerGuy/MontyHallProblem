extends Control


var simulation_on := false

var doors_amount := 0

var simulations_run := 0:
	set(value):
		simulations_run = value
		simulations_run_display.set_text()

var correct_answers := 0:
	set(value):
		correct_answers = value
		correct_answers_display.text = str(value)

var correct_answers_percentage := 0.0:
	set(value):
		correct_answers_percentage = value
		correct_answers_percentage_display.text = str("%.2f" % value) + "%"

@onready var doors_amount_edit := $DoorSelection/ChosenAmount
@onready var simulate_button := $SimulateButton
@onready var simulations_run_display := $Statistics/SimulationsRun/Amount
@onready var correct_answers_display := $Statistics/CorrectAnswers/Amount
@onready var correct_answers_percentage_display := $Statistics/CorrectAnswersPercent/Percentage
@onready var stop_button := $StopButton



func _process(_delta: float) -> void:
	if simulation_on:
		var correct_door := randi() % doors_amount
		var chosen_door := randi() % doors_amount
		
		var other_door: int
		
		if chosen_door == correct_door:
			while true:
				other_door = randi() % doors_amount
				if other_door != chosen_door:
					break
		else:
			other_door = correct_door
		
		simulations_run += 1
		if other_door == correct_door:
			correct_answers += 1
		correct_answers_percentage = float(correct_answers) / float(simulations_run) * 100


func reset_simulation() -> void:
	simulations_run = 0
	correct_answers = 0
	correct_answers_percentage = 0


func _on_simulate_button_pressed() -> void:
	doors_amount = int(doors_amount_edit.text)
	if doors_amount > 1:
		reset_simulation()
		simulation_on = true


func _on_stop_button_pressed() -> void:
	simulation_on = false


# Quick test of git
