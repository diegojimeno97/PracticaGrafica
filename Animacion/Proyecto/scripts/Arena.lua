-- Obtener Objeto
Jugador = getObject("Jugador")
Cam = getObject("Camara")
P1 = getObject("Prohibido1")
P2 = getObject("Prohibido2")
P3 = getObject("Prohibido3")
P4 = getObject("Prohibido4")
P5 = getObject("Prohibido5")
S1 = getObject("Sonido1")
S2 = getObject("Sonido2")

-- niebla: Espera a que la niebla se halla ejecutado 20 veces para ponerla
-- sound: Indica que el sonido ya ha sido iniciado
-- prop: Es la variable que se utiliza para que la niebla aumente/disminuya proporcionalmente
niebla = 0
sound = 0
prop = 0

-- Actualización de la escena
function onSceneUpdate()
	-- Comprueba si el Jugador está en contacto con al menos un objeto (la cámara), si no es así
	-- fuerza la caída
	if getNumCollisions(Jugador) < 1 then
		addCentralForce(Jugador, {0, 0, 0}, "local")
		setLinearDamping(Jugador, 0.01)
	else
		-- Vel: Fuerza que tiene el usuario
		-- Des: Rozamiento que tiene el usuario con el entorno	
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
		
		setLinearDamping(Jugador, des)
	end
	
	-- Niebla si el usuario toca un lugar prohibido
	if isCollisionBetween(Jugador, P1) or isCollisionBetween(Jugador, P2) or isCollisionBetween(Jugador, P3) 
	or isCollisionBetween(Jugador, P4) or isCollisionBetween(Jugador, P5) then
		niebla = niebla + 1
		if niebla>5 then
			prop = prop + 1
			if prop>0 and prop<50 then 
				setCameraFogDistance(Cam, 50*prop)
			end
			enableCameraFog(Cam, true)
		end
	else 
		niebla = 0
		if prop>0 then
			if prop>50 then prop=50 end
			setCameraFogDistance(Cam, 50*prop)
			prop = prop - 1
		else 
			enableCameraFog(Cam, false)
		end	
		
	end
	
	minute = os.date("%M")
	seg = os.date("%S")

	-- Reproducir sonido
	if seg == "00" then
		if sound == 0 then
			if minute%2==0 then playSound(S1)
			else playSound(S2) end
			sound = 1
		end
	else sound = 0 end
	
	-- Cambio de color foco
	mintot = os.date("%H")*60+minute
	
	-- if (os.date("%S")==0) then 
	
	-- print(os.date("%H")*3600+os.date("%M")*60+)	
end