extends CanvasLayer

func _ready():
	update_lives_label()
	update_wave_count_label()

func update_lives_label():
	$Panel/LivesLabel.text = "Vidas: " + str(Global.player_hp)
	
func update_wave_count_label():
	$Panel/WaveCountLabel.text = "Wave number: " + str(Global.wave_number)
