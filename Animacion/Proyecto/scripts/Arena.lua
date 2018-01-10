-- Obtener Objetos
Cam = getObject("Camara")
rift = getObject("Prohibido1")
P1 = getObject("Prohibido1")
P2 = getObject("Prohibido2")
P3 = getObject("Prohibido3")
P4 = getObject("Prohibido4")
P5 = getObject("Prohibido5")
Luz = getObject("Luz")
SN1 = getObject("SNoche1")
SN2 = getObject("SNoche2")
SD1 = getObject("SDia1")
SD2 = getObject("SDia2")
Jugador = getObject("Jugador")
Cabeza = getObject("Cabeza")

dx = 0.0
dy = 0.0

hideCursor()
centerCursor()
mx = getAxis("MOUSE_X")
my = getAxis("MOUSE_Y")

-- niebla: Es la variable que se utiliza para que la niebla aumente/disminuya proporcionalmente
-- sound: Indica que el sonido ya ha sido iniciado
niebla = 0
sound = 0

-- Actualización de la escena
function onSceneUpdate()
	
	-- Preparación de botones
	-- Vel: Fuerza que tiene el usuario
	-- Des: Rozamiento que tiene el usuario con el entorno	
	if isKeyPressed("MOUSE_BUTTON1") then
		vel=15
		des=0.82
	else
		vel=10
		des=0.9
	end
	
	-- Girar a la Izquierda 
	if isKeyPressed("A") then
		rotate(Jugador, {0, 0, 1}, 0.8)
	end

	-- Girar a la derecha
	if isKeyPressed("D") then
		rotate(Jugador, {0, 0, -1}, 0.8)
	end
	
	-- Moverse hacia delante
	if isKeyPressed("W") then
		addCentralForce(Jugador, {0, -vel, 0}, "local")
	end
	
	-- Moverse hacia detrás
	if isKeyPressed("S") then
		addCentralForce(Jugador, {0, vel, 0}, "local")
	end
	
	-- Salir del juego pulsando Esc
	if isKeyPressed("ESCAPE") then quit() end
		
	setLinearDamping(Jugador, des)
	
	-- Desplazamiento con ratón
	-- Rotar jugador con ratón (X)
	rotate(Jugador, {0, 0, -1}, dx*50)
	
	-- Rotar jugador con ratón (Y)
	rotate(Cabeza, {1, 0, 0}, dy*50, "local")	
	rotation = getRotation(Cabeza)
	if rotation[1] > 90 then
		rotation[1] = 90
	elseif rotation[1] < -90 then
		rotation[1] = -90
	end
	setRotation(Cabeza, rotation)
	
	-- Obtener dirección del ratón
	dx = getAxis("MOUSE_X") - mx
	dy = getAxis("MOUSE_Y") - my

	-- Centrar Cursor
	centerCursor()
	mx = getAxis("MOUSE_X")
	my = getAxis("MOUSE_Y")	

	-- Niebla si el usuario toca un lugar prohibido
	if isCollisionBetween(Jugador, P1) or isCollisionBetween(Jugador, P2) or isCollisionBetween(Jugador, P3) 
	or isCollisionBetween(Jugador, P4) or isCollisionBetween(Jugador, P5) then
		if niebla<50 then 
			niebla = niebla + 1
			setCameraFogDistance(Cam, 50*niebla)
			enableCameraFog(Cam, true)
		end
	else 
		if niebla>0 then
			setCameraFogDistance(Cam, 50*niebla)
			niebla = niebla - 1
		else 
			enableCameraFog(Cam, false)
		end	
		
	end
	
	-- Cambio de color foco
	seg = os.date("%S")
	minute=os.date("%M")
	segtot = ( os.date("%H")*60*60)+(minute*60)+seg
	
	S1=SD1
	S2=SD2
	
	-- Noche1, amanecer1, amanecer2, dia, atardecer1, atardecer2, Noche2
	if segtot>=0 and segtot<32400 then 
		S1 = SN1
		S2 = SN2
		setLightColor(Luz, {1, 1, 6})
	elseif segtot>=32400 and segtot<34200 then setLightColor(Luz, getLight(1, 1, 6, 9, 9, -1, 32400, segtot))
	elseif segtot>=34200 and segtot<36000 then setLightColor(Luz, getLight(10, 10, 5, 0, 0, 5, 34200, segtot))
	elseif segtot>=36000 and segtot<75600 then setLightColor(Luz, {10, 10, 10})
	elseif segtot>=75600 and segtot<77400 then setLightColor(Luz, getLight(10, 10, 10, 0, -6, -8, 75600, segtot))
	elseif segtot>=77400 and segtot<79200 then setLightColor(Luz, getLight(10, 4, 2, -9, -3, 4, 77400, segtot))
	elseif segtot>=79200 then
		S1 = SN1
		S2 = SN2
		setLightColor(Luz, {1, 1, 6})
	end
	
	-- Reproducir sonido
	if seg == "00" then
		if sound == 0 then
			if minute%2==0 then playSound(S1)
			else playSound(S2) end
			sound = 1
		end
	else sound = 0 end
end

function getLight(ar, ag, ab, sr, sg, sb, hstart, hreal)
	if hstart == hreal then t=0
	else t=(hreal-hstart)/1800 end
	r = ar + (sr*t)
	g = ag + (sg*t)
	b = ab + (sb*t)
	return {r, g, b}
end
