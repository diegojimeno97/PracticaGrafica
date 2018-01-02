-- Obtener Objeto
Jugador = getObject("Jugador")

-- Actualización de la escena
function onSceneUpdate()

	coll = getNumCollisions(Jugador)
	move = 0

	if isKeyPressed("LSHIFT") then
		vel=15
		gir=1
		des=0.5
	else
		vel=10
		gir=0.5
		des=0.9
	end
	
	-- Rotar a la Izquierda
	if isKeyPressed("A") then
		rotate(Jugador, {0, 0, gir}, 2)
		addCentralForce(Jugador, {0, -vel, 0}, "local")
	end

	-- Rotar a la derecha
	if isKeyPressed("D") then
		rotate(Jugador, {0, 0, gir}, -2)
		addCentralForce(Jugador, {0, -vel, 0}, "local")
	end
	
	-- move Sheep
	if isKeyPressed("W") then
		addCentralForce(Jugador, {0, -vel, 0}, "local")
	end
	
	-- move Sheep
	if isKeyPressed("S") then
		addCentralForce(Jugador, {0, vel, 0}, "local")
	end

	setLinearDamping(Jugador, des)	
end