extends Sprite3D


@onready var order_timer: Timer = $"../AssemblyTimer"
var i = 1


func _ready():
	self.modulate = Color.GREEN


func _on_customer_timer_started():
	var wait_time = order_timer.wait_time / 100
	var curr_scale = self.scale.x
	
	while i != -1000:
		i -= .01
		await get_tree().create_timer(wait_time).timeout
		if order_timer.paused == false:
			self.scale.x = curr_scale * i
			
			if self.scale.x == curr_scale/2:
				self.modulate = Color.YELLOW
			elif self.scale.x == curr_scale/4:
				self.modulate = Color.ORANGE
			elif self.scale.x == curr_scale/6:
				self.modulate = Color.RED
			elif self.scale.x == 0:
				self.hide()
