extends ColorRect


export (PackedScene) var Splash

var to_draw_list = []

func _ready():
	pass

func _draw():
	for i in to_draw_list:
		draw_texture(i,Vector2(0,0))

func _on_PaintBullet_ended(bullet_position, bullet_color):
	var paint_splash = Splash.instance()
	add_child(paint_splash)
	paint_splash.set_position(bullet_position)
	paint_splash.get_child(0).modulate = bullet_color
	to_draw_list.append(paint_splash)
	update()

func _input(event):
	if event is InputEventMouseButton:
		get_child(0).position = event.position
		get_child(0).fire()
