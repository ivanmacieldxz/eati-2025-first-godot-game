extends CanvasLayer

func _ready():
	updateVidaLabel()
	updateOleadaLabel()
	
func updateVidaLabel():
	$Panel/Vida.text = "Vida: "+str(Global.vida)
	
func updateOleadaLabel():
	$Panel/Oleada.text = "Oleada: "+str(Global.wave_number)
	
