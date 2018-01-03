-- Obtener Objeto
Jugador = getObject("Jugador")
Cam = getObject("Camara")
P1 = getObject("Prohibido1")
P2 = getObject("Prohibido2")
P3 = getObject("Prohibido3")
cont = 0
fot = 0

-- Actualización de la escena
function onSceneUpdate()

	coll = getNumCollisions(Jugador)
	move = 0

	if isKeyPressed("LSHIFT") then
		vel=16
		des=0.8
	else
		vel=12.2
		des=0.9
	end
	
	-- Rotar a la Izquierda
	if isKeyPressed("A") then
		rotate(Jugador, {0, 0, 1}, 2)
		addCentralForce(Jugador, {0, -vel, 0}, "local")
	end

	-- Rotar a la derecha
	if isKeyPressed("D") then
		rotate(Jugador, {0, 0, 1}, -2)
		addCentralForce(Jugador, {0, -vel, 0}, "local")
	end
	
	-- Moverse hacia delante
	if isKeyPressed("W") then
		addCentralForce(Jugador, {0, -vel, 0}, "local")
	end
	
	-- Moverse hacia detrás
	if isKeyPressed("S") then
		addCentralForce(Jugador, {0, vel, 0}, "local")
	end
	
	-- Niebla si el usuario toca un lugar prohibido
	if isCollisionBetween(Jugador, P1) or isCollisionBetween(Jugador, P2) or isCollisionBetween(Jugador, P3) then
		cont = cont + 1
		if cont>10 then
			fot = fot + 1
			if fot>0 and fot<50 then 
				setCameraFogDistance(Cam, 50*fot)
			end
			enableCameraFog(Cam, true)
		end
	else 
		cont = 0
		if fot>0 then
			if fot>50 then fot=50 end
			setCameraFogDistance(Cam, 50*fot)
			fot = fot - 1
		else 
			enableCameraFog(Cam, false)
		end	
		
	end
	
	-- Cambio de color foco
	seg = os.date("%H")*3600+os.date("%M")*60+os.date("%S")
	
	-- print(os.date("%H")*3600+os.date("%M")*60+os.date("%S"))
	
	setLinearDamping(Jugador, des)	
end