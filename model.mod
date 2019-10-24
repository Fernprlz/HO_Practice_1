/*/////////////////// E J E R C I C I O   1 ///////////////////*/
/*/////// Declaracion de conjuntos ///////*/
set Puertas;
param Tiempo_Espera_Inicial{p in Puertas};

set Elementos;
param Reduccion_Tiempo_Visitante{e in Elementos};
param Coste_Hora{e in Elementos};

/*/////// Variables de Decision ///////*/
var y: {i in Puertas, j in Elementos}, x>=0, integer;

/*/////// Restricciones ///////*/
/* 1. Coste Total <= 125*/
s.t. rest1A{j in Elementos}: sum{i in Puertas} Coste_Hora[j] * y[i,j] <= 125;
/* 2. Minimo de dos elementos de cada tipo en Este*/
s.t. rest2A{j in Elementos}: y[0,j]>=2; 
/* 3. Minimo de un elemento de cada tipo en Norte y Oeste*/
s.t. rest3_1A{j in Elementos}: y[1,j]>=1;
s.t. rest3_2A{j in Elementos}: y[2,j]>=1;
/* 4. Nº  tornos en Norte <= Nº tornos en Oeste*/
s.t. rest4A: y[1,1] <= y[2,1];
/* 5. Nº  tornos y expendedoras en Norte <= Nº tornos y expendedoras en Este*/
s.t. rest5A: y[1,0] + y[1,1] <= y[0,0] + y[0,1];
/* 6. Nº  tornos y expendedoras en Oeste <= Nº tornos y expendedoras en Este*/
s.t. rest6A: y[2,0] + y[0,0] + y[0,1];
/* 7. Inversión en Este no superior al 110% de inversión en Norte*/
s.t. rest7A: sum{j in Elementos} Coste_Hora[j] * y[0,j] <= 1'1 * sum{j in Elementos} Coste_Hora * y[1,j];
/* 8. Inversión en Este no superior al 110% de inversión en Oeste*/
s.t. rest8A: sum{j in Elementos} Coste_Hora[j] * y[0,j] <= 1'1 * sum{j in Elementos} Coste_Hora * y[2,j];
/* 9. Reducción de tiempo de espera en Este >= tiempo de espera en Norte*/
s.t. rest9A: sum{j in Elementos} Reduccion_Tiempo_Visitante * y[0,j] >= sum{j in Elementos} Reduccion_Tiempo_Visitante * y[1,j];
/* 10. Reducción de tiempo de espera en Este >= tiempo de espera en Oeste */
s.t. rest10A: sum{j in Elementos} Reduccion_Tiempo_Visitante * y[0,j] >= sum{j in Elementos} Reduccion_Tiempo_Visitante * y[2,j];
/*/////////////////// E J E R C I C I O   2 ///////////////////*/
/*/////// Declaracion de conjuntos ///////*/

set Robots;
param Tiempo_objeto{r in Robots};
param Energia_objeto{r in Robots};
param Energia_total{r in Robots};

set Salas;
param Objetos_sala{s in Salas};

param Tiempo_R_Sala{r in Robots, s in Salas};
param Energia_R_Sala{r in Robots, s in Salas};

set Salas_6_Objetos within Salas;las};

set Salas_Oeste within Salas;
set Salas_Este within Salas;

set Salas_5_Objetos within Salas;
set Salas_4_Objetos within Salas;
set Salas_7_Objetos within Salas;
set Salas_3_Objetos within Salas;
set Salas_2_Objetos within Salas;


/*/////// Parametros (constantes) ///////*/
param offset := 10;

/*/////// Variables de Decision ///////*/

var x: {i in Robots, j in Salas}, x >= 0, integer;

/*/////// Restricciones ///////*/

/*///////- 1. No más de un robot en una sala, todas las salas deben tener un robot*/
s.t. rest1B{j in Salas}: sum{i in Robots} x[i, j] = 1; 

/*///////- 2. Un robot no puede estar asignado a menos de dos salas*/
s.t. rest2B{i in Robots}: sum{j in Salas} x[i, j] >= 2;

/*///////- 3. Un robot no puede estar asignado a más de tres salas*/
s.t. rest3B{i in Robots}: sum{j in Salas} x[i, j] <= 3;

/*///////- 4. R3, R5, R6 != oeste ///// x2a-j == 0; x4a-j == 0; x5a-j == 0*/
s.t. rest4B: sum{j in Salas_Oeste} x[2, j] + x[4, j] + x[5, j] == 0;

/*///////- 5. R2, R4 != este ////////// x1k-q == 0; x3k-q == 0*/
s.t. rest5B: sum{j in Salas_Este} x[1, j + offset] + x[3, j + offset] == 0;


////////////////////TODO//////////////////////////////

/*///////- 6. No hay robots asignados a C y a EFG..Q Simultaneamente ///// xi2 + xi4-16 <= 1;*/
s.t. rest6B{i in Robots, j in Salas: j >= 4}: x[i, 2] + x[i, j] <= 1;

/*///////- 7. ///// xi3 + xi4-16 <= 1;*/
s.t. rest7B{i in Robots, j in Salas: j >= 4}: x[i, 3] + x[i, j] <= 1;

////////////////////TODO//////////////////////////////

/*///////- 8. Un robot no puede estar en una sala que requiera + energia de la disponible*/

s.t. rest8B{r in Robots}: sum{s in Salas} x[r, s] * Energia_R_Sala[r, s] <= Energia_total[r];

s.t. rest8{i in Robots}: ((sum{j: j <= 2} x[i, j] * 5) + (sum{j: j > 2, j <= 4} x[i, j] * 6) + 
						 (sum{j: j > 4, j <= 7} x[i, j] * 4) + (sum{j: j > 7, j <= 9} x[i, j] * 7) +
						 (sum{j: j > 9, j <= 12} x[i, j] * 3) + (sum{j: j > 12, j <= 16} x[i, j] * 2)) 
						 * Energia_Objeto[i] <= Energia_total[i];

/*///////- 9. TPO >= TPE·1.1*/
s.t. rest9B{r in Robots}: sum{o in Salas_Oeste} x[r, o] * Tiempo_R_Sala[r, o] >= 1.1*sum{e in Salas_Este} x[r, e] * Tiempo_R_Sala[r, e];




/*/////// Funcion Objetivo ///////*/
minimize Tiempo_Espera: sum{r in Robots, s in Salas} x[r, s] * Tiempo_R_Sala[r, s];