-----------------------------------------------------------------------------------
-- Maratis
-- YoFrankie Arena example
-----------------------------------------------------------------------------------

-- get objects
Sheep = getObject("Sheep")
Player = getObject("Player")
Feet = getObject("Feet")

-- scene update
function onSceneUpdate()

	coll = getNumCollisions(Feet)
	move = 0

	-- rotate left
	if isKeyPressed("LEFT") and (coll > 1)  then
		rotate(Player, {0, 0, 1}, 5)
		move = 1
	end

	-- rotate right
	if isKeyPressed("RIGHT") and (coll > 1) then
		rotate(Player, {0, 0, 1}, -5)
		move = 1
	end
	
	-- move Sheep
	if isKeyPressed("UP") and (coll > 1) then
		move = 1
	end

	if move == 1 then
		addCentralForce(Player, {1, -10, 0}, "local")
		changeAnimation(Sheep, 1)
	else
		changeAnimation(Sheep, 0)
	end
	
	-- manual friction (set damping if Player touch the ground)
	if coll < 2 then
		setLinearDamping(Player, 0.01)
	else
		setLinearDamping(Player, 0.9)
	end
	
end