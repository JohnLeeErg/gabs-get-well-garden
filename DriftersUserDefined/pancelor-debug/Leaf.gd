extends Drifter

var repeat_dir:bool
var dir:Vector2

func _physics_process(_delta):
	._physics_process(_delta) # call method on base class
	if randf()*50<1:
		scale = Vector2(1.1, 0.9)
		rotation_degrees = rand_range(-20,20)

func evolve():
	var vibe:Vibe = world.vibe_nearby(cell)
	if vibe.get_fire() > 1:
		world.log("a wandering leaf bursts into flames")
		intend_transmute("res://DriftersUserDefined/pancelor-debug/Flames.tscn")
	elif vibe.get_wind() > 6:
		world.log("many leaves join forces")
		intend_transmute("res://DriftersUserDefined/pancelor-demo/Whirlwind.tscn")
	elif randf()*50<1:
		# settle
		tweak()
	else:
		if not repeat_dir:
			dir = vibiest_dir(DirsAdjacent,{"Wind":1,"Earth":-1})
		repeat_dir = not repeat_dir

		scale = Vector2(1.2, 0.8)
		if dir.x: $Sprite.flip_h = dir.x<0
		
		intend_move(dir)

func tweak():
	world.log("a leaf settles down")
	intend_transmute("res://DriftersUserDefined/pancelor-debug/Sapling.tscn")
