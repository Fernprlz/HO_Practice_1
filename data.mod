data;


set Robots := R1, R2, R3, R4, R5, R6, R7, R8;
set Salas := A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q;

set Salas_Oeste := A, B, C, D, E, F, G, H, I, J;
set Salas_Este := K, L, M, N, O, P, Q;


set Salas_5_Objetos = A, B, C;
set Salas_6_Objetos = D, E;
set Salas_4_Objetos = F, G, H;
set Salas_7_Objetos = I, J;
set Salas_3_Objetos = K, L, M;
set Salas_2_Objetos = N, O, P, Q;



/*---- Inicializacion de Parametros ----*/ 
/* -- Robots */
param Tiempo_objeto :=
R1 4
R2 6
R3 5
R4 3
R5 2
R6 3
R7 4
R8 5;

param Energia_objeto :=
R1 7
R2 5
R3 3
R4 1
R5 2
R6 4
R7 4
R8 5;

param Energia_total :=
R1 100
R2 90
R3 95
R4 40
R5 45
R6 75
R7 85
R8 60;
					

/* -- Tiempo que tarda cada robot en presentar cada sala */
param Tiempo_R_Sala:	A	B	C 	D 	E 	F 	G 	H 	I 	J	K	L	M	N	O 	P 	Q :=
R1						20	20	20	24	24	16	16	16	28	28	12	12	12	8	8	8	8
R2						30	30	30	36	36	24	24	24	42	42	18	18	18	12	12	12	12
R3						25	25	25	30	30	20	20	20	35	35	15	15	15	10	10	10	10
R4						15	15	15	18	18	12	12	12	21	21	9	9	9	6	6	6	6
R5						10	10	10	12	12	8	8	8	14	14	6	6	6	4	4	4	4
R6						15	15	15	18	18	12	12	12	21	21	9	9	9	6	6	6	6
R7						20	20	20	24	24	16	16	16	28	28	12	12	12	8	8	8	8
R8						25	25	25	30	30	20	20	20	35	35	15	15	15	10	10	10	10;


/* -- Energía que consume cada robot en presentar cada sala */
param Energia_R_Sala:	A	B	C 	D 	E 	F	G	H	I 	J	K	L	M	N	O 	P 	Q :=
R1						35	35	35	42	42	28	28	28	49	49	21	21	21	14	14	14	14
R2						25	25	25	30	30	20	20	20	35	35	15	15	15	10	10	10	10
R3						15	15	15	18	18	12	12	12	21	21	9	9	9	6	6	6	6
R4						5	5	5	6	6	4	4	4	7	7	3	3	3	2	2	2	2
R5						10	10	10	12	12	8	8	8	14	14	6	6	6	4	4	4	4
R6						20	20	20	24	24	16	16	16	28	28	12	12	12	8	8	8	8
R7						20	20	20	24	24	16	16	16	28	28	12	12	12	8	8	8	8
R8						25	25	25	30	30	20	20	20	35	35	15	15	15	10	10	10	10;

/*//////////////////////// Problema 1 ////////////////////////*/
set Puertas = Este, Norte, Oeste;
set Elementos = Maquina_Exp, Torno, Persona;


param Tiempo_Espera_Inicial :=
Este 	130
Norte	90
Oeste 	100;

param Reduccion_Tiempo_Visitante :=
Maquina_Exp	2
Torno		3
Persona		4;

param Coste_Hora :=
Maquina_Exp	4
Torno		5
Persona		8;