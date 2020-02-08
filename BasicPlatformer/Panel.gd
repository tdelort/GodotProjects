extends Panel

const CIRCLE_RADIUS = 32

func _on_Sprite_ended(bullet_position, bullet_color):
	draw_circle(bullet_position,CIRCLE_RADIUS,bullet_color)
	update()
