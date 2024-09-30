program cube3d;

uses Crt, Math;

type
  TPoint3D = record
    x, y, z: Real;
  end;
  tCube = array[1..8] of TPoint3D;


function Project3DTo2D(Point: TPoint3D; zCamera:real; ScaleX, ScaleY, OffsetX, OffsetY:integer): TPoint3D;
begin

  Project3DTo2D.x := Round(Point.x / (Point.z + zCamera) * ScaleX + OffsetX); // Escalado para consola
  Project3DTo2D.y := Round(Point.y / (Point.z + zCamera) * ScaleY + OffsetY); // Ajustar centro
end;

procedure DrawPoint(x, y: Integer);
begin
  
    GotoXY(x, y);
    Write('-');  
end;

procedure DrawLine(x1, y1, x2, y2: Integer);	//algoritmo de bresenham
var
  dx, dy, sx, sy, err, e2: Integer;
begin
 
  dx := Abs(x2 - x1);
  dy := Abs(y2 - y1);
  if x1 < x2 then sx := 1 else sx := -1;
  if y1 < y2 then sy := 1 else sy := -1;
  err := dx - dy;

  while True do
  begin
    DrawPoint(x1, y1);
    if (x1 = x2) and (y1 = y2) then Break;
    e2 := 2 * err;
    if e2 > -dy then
    begin
      err := err - dy;
      x1 := x1 + sx;
    end;
    if e2 < dx then
    begin
      err := err + dx;
      y1 := y1 + sy;
    end;
  end;
end;

procedure RotateX(var Point: TPoint3D; Angle: Real);	//rotación matricial sobre el eje X
var
  yTemp: Real;
begin
  yTemp := Point.y * Cos(Angle) - Point.z * Sin(Angle);
  Point.z := Point.y * Sin(Angle) + Point.z * Cos(Angle);
  Point.y := yTemp;
end;

procedure RotateY(var Point: TPoint3D; Angle: Real);	//rotación matricial sobre el eje y
var
  xTemp: Real;
begin
  xTemp := Point.x * Cos(Angle) + Point.z * Sin(Angle);
  Point.z := -Point.x * Sin(Angle) + Point.z * Cos(Angle);
  Point.x := xTemp;
end;

procedure RotateZ(var Point: TPoint3D; Angle: Real);	//rotación matricial sobre el eje z
var
  xTemp: Real;
begin
  xTemp := Point.x * Cos(Angle) - Point.y * Sin(Angle);
  Point.y := Point.x * Sin(Angle) + Point.y * Cos(Angle);
  Point.x := xTemp;
end;

procedure text;
begin	
writeln('                                                                                                                                                                     ▄▄                                         ▄▄               			'); 
writeln('         ▀███▀▀▀██▄         ▄▄█▀▀▀█▄████▀   ▀███▀███▀▀▀██▄███▀▀▀███      ▀███▀▀▀██▄ ▀███▀▀▀███▀███▄   ▀███▀███▀▀▀██▄ ▀███▀▀▀███▀███▀▀▀██▄ ▀███▀▀▀███▀███▀▀▀██▄      ▄██                     ▀███▀▀▀██▄        ▀███   ██           			');
writeln('           ██    ▀██▄     ▄██▀     ▀███       █   ██    ██ ██    ▀█        ██   ▀██▄  ██    ▀█  ███▄    █   ██    ▀██▄ ██    ▀█  ██   ▀██▄  ██    ▀█  ██   ▀██▄      ██                       ██    ██          ██   ██           			');
writeln('  ██▀▀█▄   ██     ▀██     ██▀       ▀██       █   ██    ██ ██   █          ██   ▄██   ██   █    █ ███   █   ██     ▀██ ██   █    ██   ▄██   ██   █    ██   ▄██       ██▄████▄ ▀██▀   ▀██▀     ██    ██▄█▀██▄    ██ ██████ ▄█▀██▄  			');
writeln(' ███  ▀██  ██      ██     ██         ██       █   ██▀▀▀█▄▄ ██████          ███████    ██████    █  ▀██▄ █   ██      ██ ██████    ███████    ██████    ███████        ██    ▀██  ██   ▄█       ██▀▀▀█▄▄█   ██    ██   ██  ██   ██  			');
writeln('      ▄██  ██     ▄██     ██▄        ██       █   ██    ▀█ ██   █  ▄       ██  ██▄    ██   █  ▄ █   ▀██▄█   ██     ▄██ ██   █  ▄ ██  ██▄    ██   █  ▄ ██  ██▄        ██     ██   ██ ▄█        ██    ▀█▄█████    ██   ██   ▄█████  			');
writeln('    ▀▀██▄  ██    ▄██▀     ▀██▄     ▄▀██▄     ▄█   ██    ▄█ ██     ▄█       ██   ▀██▄  ██     ▄█ █     ███   ██    ▄██▀ ██     ▄█ ██   ▀██▄  ██     ▄█ ██   ▀██▄      ██▄   ▄██    ███         ██    ▄██   ██    ██   ██  ██   ██  			');
writeln('       ██▄████████▀         ▀▀█████▀  ▀██████▀▀ ▄████████▄██████████     ▄████▄ ▄███▄█████████████▄    ██ ▄████████▀ ▄██████████████▄ ▄███▄██████████████▄ ▄███▄     █▀█████▀     ▄█        ▄████████▀████▀██▄▄████▄ ▀████████▀██▄			');
writeln('███  ▄█▀                                                                                                                                                                        ▄█                                                			');
writeln(' █████▀                                                                                                                                                                       ██▀                                                 			');
writeln;
writeln;
writeln('PRESIONE "Q" o "ESC" PARA SALIR. ');
writeln;
writeln('USE "+" PARA ACERCAR EL CUBO. PRESIONE "-" PARA ALEJARLO.');
writeln('USE WASD PARA MOVER EL CUBO.');
writeln;
writeln('PRESIONE "R" PARA RESEATEAR EL CUBO.');
writeln('PRESIONE "P" PARA DESACTIVAR EL MOVIMIENTO ALEATORIO DEL CUBO.');
writeln('PRESIONE "C" PARA CONTINUAR EL MOVIMIENTO ALEATORIO.');
writeln('PRESIONE "X" PARA DETENERLO COMPLETAMENTE.');
writeln;
writeln('USE "U" o "J" PARA CONTROLAR EL ÁNGULO SOBRE EL EJE X');
writeln('USE "I" o "K" PARA CONTROLAR EL ÁNGULO SOBRE EL EJE Y');
writeln('USE "O" o "L" PARA CONTROLAR EL ÁNGULO SOBRE EL EJE Z');
end;

procedure text2;
begin
writeln('░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░');
writeln('░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░');
writeln('▒▒   ▒  ▒▒▒▒▒▒▒▒   ▒▒▒▒▒▒▒   ▒  ▒▒▒▒▒▒▒▒▒▒▒   ▒▒▒');
writeln('▒  ▒▒▒▒▒   ▒▒▒   ▒▒   ▒▒▒  ▒▒▒▒▒   ▒▒▒▒▒▒ ▒   ▒▒▒');
writeln('▓▓▓▓▓▓   ▓▓▓   ▓▓▓▓▓   ▓▓▓▓▓▓▓   ▓▓▓▓▓▓▓  ▓   ▓▓▓');
writeln('▓▓▓▓   ▓▓▓▓▓   ▓▓▓▓▓▓   ▓▓▓▓   ▓▓▓▓▓▓▓   ▓▓   ▓▓▓');
writeln('▓▓   ▓▓▓▓▓▓▓▓   ▓▓▓▓   ▓▓▓   ▓▓▓▓▓▓▓      ▓      ');
writeln('█         ██████    █████         █████████   ███');
writeln('█████████████████████████████████████████████████');
end;


procedure values(AngleX, AngleY, AngleZ, zCamera:real; OffsetX, OffsetY:integer);	//debug
begin

	gotoxy(1, 30);
	writeln('- DEBUG -');
	writeln('Angulo X: ', AngleX:0:4);
	writeln('Angulo Y: ', AngleY:0:4);
	writeln('Angulo Z: ', AngleZ:0:4);
	writeln('zCamera: ', zCamera:0:4);
	writeln('Offset X: ', OffsetX);
	writeln('Offset Y: ', OffsetY);

end;



procedure randomVelocity(var valor:real);
var aux:integer;
begin

	aux := random(4);

	if (valor > 0.1) or (valor < -0.1) then valor := 0.002;
	if aux>1 then valor := valor + 0.001 else valor := valor - 0.001;

end;

procedure selectColor(EdgeIndex:integer);
begin 	

	case EdgeIndex of
	1, 2, 3, 4: begin textcolor(4); textbackground(4); end; 21, 22: begin textcolor(4); textbackground(4); end;	//bordes rojos
	5, 6, 7, 8: begin textcolor(9); textbackground(9); end;	23, 24: begin textcolor(9); textbackground(9); end;	//bordes azules
	9, 10, 11, 12: begin textcolor(white); textbackground(white); end;	//bordes blancos
	else begin textcolor(8); textbackground(8); end;  //aristas que dan al centro
	end;

	if EdgeIndex = 25 then begin textcolor(white); textbackground(black); end;	//resetea el color de fondo a negro

end;

procedure initializeCube(var Cube:tCube);
begin

	// Inicializar los vértices del cubo
  	Cube[1].x := -1; Cube[1].y := -1; Cube[1].z := -1;
  	Cube[2].x := 1;  Cube[2].y := -1; Cube[2].z := -1;
  	Cube[3].x := 1;  Cube[3].y := 1;  Cube[3].z := -1;
  	Cube[4].x := -1; Cube[4].y := 1;  Cube[4].z := -1;
  	Cube[5].x := -1; Cube[5].y := -1; Cube[5].z := 1;
 	Cube[6].x := 1;  Cube[6].y := -1; Cube[6].z := 1;
  	Cube[7].x := 1;  Cube[7].y := 1;  Cube[7].z := 1;
  	Cube[8].x := -1; Cube[8].y := 1;  Cube[8].z := 1;

end;

procedure DrawCube(var Cube:tCube; zCamera:real; ScaleX, ScaleY, OffsetX, OffsetY:integer);
const
  Edges: array[1..25, 1..2] of Integer = (
    (1, 2), (2, 3), (3, 4), (4, 1),  // Lado trasero
    (5, 6), (6, 7), (7, 8), (8, 5),  // Lado delantero
    (1, 5), (2, 6), (3, 7), (4, 8),   // Aristas conectando el frente y la parte trasera
    (1, 9), (2, 9), (3, 9), (4, 9), (5, 9), (6, 9), (7, 9), (8, 9),  // Vertices que unen al fondo
    (1, 3), (2, 4), // Rojo
    (5, 7), (6, 8), (9, 9) // Azul
  );
var
  EdgeIndex: Integer;
  P1, P2: TPoint3D;

begin
  
  for EdgeIndex := 1 to 25 do
  begin
  	
    P1 := Project3DTo2D(Cube[Edges[EdgeIndex, 1]], zCamera, ScaleX, ScaleY, OffsetX, OffsetY);
    P2 := Project3DTo2D(Cube[Edges[EdgeIndex, 2]], zCamera, ScaleX, ScaleY, OffsetX, OffsetY);

	selectColor(EdgeIndex); //pinta las aristas
    DrawLine(Round(P1.x), Round(P1.y), Round(P2.x), Round(P2.y)); // Dibujar arista
    
    if EdgeIndex = 25 then begin gotoxy(WhereX-1, WhereY); writeln('𒊹'); end; // Dibuja pelotita

  end;
end;

procedure rotarCubo(var Cube:tCube; var AngleX, AngleY, AngleZ:real; var Aleatorio:boolean);
var i:integer;
begin
	for i := 1 to 8 do
	begin

		RotateX(Cube[i], AngleX);  // Aplicar rotación en X
	    RotateY(Cube[i], AngleY);  // Aplicar rotación en Y
	    RotateZ(Cube[i], AngleZ); //Rotar en Z

	    if Aleatorio then begin
	    randomVelocity(AngleX);
	    randomVelocity(AngleY);
	    randomVelocity(AngleZ);
	    end;

	end;
end;

procedure mostrarTextos(AngleX, AngleY, AngleZ, zCamera:real; OffsetX, OffsetY:integer);
begin

	gotoxy(1, 90);
    text2;

   	textcolor(white);
    gotoxy(1,1);
    text;

    gotoxy(1, 15);
    values(AngleX, AngleY, AngleZ, zCamera, OffsetX, OffsetY);

end;

procedure activarCubo(var Cube:tCube; var AngleX, AngleY, AngleZ:real; var zCamera:real; var ScaleX, ScaleY, OffsetX, OffsetY:integer; var Aleatorio:boolean);
begin

	ClrScr;
    rotarCubo(Cube, AngleX, AngleY, AngleZ, Aleatorio);
    DrawCube(Cube, zCamera, ScaleX, ScaleY, OffsetX, OffsetY);  // Dibujar el cubo con aristas
    mostrarTextos(AngleX, AngleY, AngleZ, zCamera, OffsetX, OffsetY);

end;

procedure resetCube(var Cube:tCube; var zCamera:real; var ScaleX, ScaleY, OffsetX, OffsetY:integer);
begin

  zCamera := 3.5;
  ScaleX := 120;
  ScaleY := 60;
  OffsetX := 120;
  OffsetY := 55;
  initializeCube(Cube);

end;

procedure stopCube(var AngleX, AngleY, AngleZ:real);
begin

	AngleX := 0; 
  	AngleY := 0; 
  	AngleZ := 0;

end;

procedure main;
var
  Cube: tCube;
  AngleX, AngleY, AngleZ: Real;
  zCamera:real;
  ScaleX, ScaleY, OffsetX, OffsetY:integer;
  endLoop, Aleatorio:boolean;

begin

  endLoop := false; Aleatorio := true;
  initializeCube(Cube);
  stopCube(AngleX, AngleY, AngleZ);

  resetCube(Cube, zCamera, ScaleX, ScaleY, OffsetX, OffsetY);

  while not endLoop do
  begin
    
   activarCubo(Cube, AngleX, AngleY, AngleZ, zCamera, ScaleX, ScaleY, OffsetX, OffsetY, Aleatorio);

   if KeyPressed then
   begin

   		case Readkey of
   		'q', 'Q', #27: endLoop := true;
   		#43: if zCamera > 2.5 then zCamera-=0.1;
   		#45: if zCamera < 10 then zCamera+=0.1;
   		'a', 'A': if OffsetX > 23 then OffsetX-=2;
   		'd', 'D': if OffsetX < 234 then OffsetX+=2;
   		'w', 'W': if OffsetY > 6 then OffsetY-=1;
   		's', 'S': if OffsetY < 80 then OffsetY+=1;
   		'r', 'R': resetCube(Cube, zCamera, ScaleX, ScaleY, OffsetX, OffsetY);
   		'u', 'U': AngleX+=0.01;
   		'j', 'J': AngleX-=0.01;
   		'i', 'I': AngleY+=0.01;
   		'k', 'K': AngleY-=0.01;
   		'o', 'O': AngleZ+=0.01;
   		'l', 'L': AngleZ-=0.01;
   		'p', 'P': Aleatorio := false;
   		'c', 'C': Aleatorio := true;
   		'x', 'X': begin stopCube(AngleX, AngleY, AngleZ); Aleatorio := false; end;
   		end;

   end;

   Delay(20); // Esperar 100 milisegundos para refrescar

  end;
end;

begin
main;
end.
