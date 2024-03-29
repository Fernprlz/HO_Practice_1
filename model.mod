/*/////////////////// E J E R C I C I O   1 ///////////////////*/
/*/////// Declaracion de conjuntos ///////*/
set Puertas;
set Norte_Oeste within Puertas;
set Este within Puertas;
set Norte within Puertas;
set Oeste within Puertas;
param Tiempo_Espera_Inicial{p in Puertas};

set Elementos;
set Expendedoras_Tornos within Elementos;
set Tornos within Elementos;
param Reduccion_Tiempo_Visitante{e in Elementos};
param Coste_Hora{e in Elementos};

/*/////// Variables de Decision ///////*/
var y{i in Puertas, j in Elementos}, integer, >=0;

/*/////// Restricciones ///////*/
/* 1. Coste Total <= 125*/
s.t. rest1A: sum{i in Puertas, j in Elementos} Coste_Hora[j] * y[i,j] <= 125;
/* 2. Minimo de dos elementos de cada tipo en Este*/
s.t. rest2A{i in Este, j in Elementos}: y[i,j]>=2;
/* 3. Minimo de un elemento de cada tipo en Norte y Oeste*/
s.t. rest3_1A{n in Norte, j in Elementos}: y[n,j]>=1;
s.t. rest3_2A{o in Oeste, j in Elementos}: y[o,j]>=1;
/* 4. Nº  tornos en Norte < Nº tornos en Oeste*/
s.t. rest4A{n in Norte, t in Tornos, o in Oeste}: y[n,t] <= y[o,t] - 1;
/* 5. Nº  tornos y expendedoras en Norte < Nº tornos y expendedoras en Este*/
s.t. rest5A: sum{n in Norte, j in Expendedoras_Tornos} y[n,j] <= (sum{e in Este, j in Expendedoras_Tornos} y[e,j]) - 1;
/* 6. Nº  tornos y expendedoras en Oeste < Nº tornos y expendedoras en Este*/
s.t. rest6A: sum{o in Oeste, j in Expendedoras_Tornos} y[o,j] <= (sum{e in Este, j in Expendedoras_Tornos} y[e,j]) - 1;
/* 7. Inversión en Este no superior al 110% de inversión en Norte*/
s.t. rest7A: sum{e in Este, j in Elementos} Coste_Hora[j] * y[e,j] <= 1.1 * sum{n in Norte, j in Elementos} Coste_Hora[j] * y[n,j];
/* 8. Inversión en Este no superior al 110% de inversión en Oeste*/
s.t. rest8A: sum{e in Este, j in Elementos} Coste_Hora[j] * y[e,j] <= 1.1 * sum{o in Oeste, j in Elementos} Coste_Hora[j] * y[o,j];
/* 9. Reducción de tiempo de espera en Este > tiempo de espera en Norte*/
s.t. rest9A: sum{e in Este, j in Elementos} Reduccion_Tiempo_Visitante[j] * y[e,j] >= (sum{n in Norte, j in Elementos} Reduccion_Tiempo_Visitante[j] * y[n,j]) + 1;
/* 10. Reducción de tiempo de espera en Este > tiempo de espera en Oeste */
s.t. rest10A: sum{e in Este, j in Elementos} Reduccion_Tiempo_Visitante[j] * y[e,j] >= (sum{o in Oeste, j in Elementos} Reduccion_Tiempo_Visitante[j] * y[o,j]) + 1;



/*/////////////////// E J E R C I C I O   2 ///////////////////*/
/*/////// Declaracion de conjuntos ///////*/

set Robots;
set Robots356 within Robots;
set Robots24 within Robots;
param Tiempo_objeto{r in Robots};
param Energia_objeto{r in Robots};
param Energia_total{r in Robots};

set Salas;
set SalasAB within Salas;
set SalasCD within Salas;
set Salas_Oeste within Salas;
set Salas_Este within Salas;
set Salas_5_Objetos within Salas;
set Salas_6_Objetos within Salas;
set Salas_4_Objetos within Salas;
set Salas_7_Objetos within Salas;
set Salas_3_Objetos within Salas;
set Salas_2_Objetos within Salas;

param Objetos_sala{s in Salas};

param Tiempo_R_Sala{r in Robots, s in Salas};
param Energia_R_Sala{r in Robots, s in Salas};

/*/////// Variables de Decision ///////*/

var x{i in Robots, j in Salas}, >= 0, integer;

/*/////// Restricciones ///////*/

/*///////- 1. No más de un robot en una sala, todas las salas deben tener un robot*/
s.t. rest1B{j in Salas}: sum{i in Robots} x[i, j] = 1;

/*///////- 2. Un robot no puede estar asignado a menos de dos salas*/
s.t. rest2B{i in Robots}: sum{j in Salas} x[i, j] >= 2;

/*///////- 3. Un robot no puede estar asignado a más de tres salas*/
s.t. rest3B{i in Robots}: sum{j in Salas} x[i, j] <= 3;

/*///////- 4. R3, R5, R6 != oeste */
s.t. rest4B{i in Robots356, j in Salas_Oeste}: x[i,j] = 0;

/*///////- 5. R2, R4 != este  */
s.t. rest5B{i in Robots24, j in Salas_Este}: x[i,j] = 0;

/*//////- 6. Solo los robots asignados a salas A o B (o ambas) pueden asignarse a C o D (o ambas)*/
s.t. rest6B{i in Robots}: sum{j in SalasCD} x[i,j] <= 2 * sum{j in SalasAB} x[i,j];


/*///////- 8. Un robot no puede estar en una sala que requiera + energia de la disponible*/
s.t. rest8B{r in Robots}: sum{s in Salas} (x[r, s] * Energia_R_Sala[r, s]) <= Energia_total[r];

/*///////- 9. TPO >= TPE·1.1*/
s.t. rest9B: sum{r in Robots, o in Salas_Oeste} (x[r, o] * Tiempo_R_Sala[r, o]) >= (1.1 * (sum{r in Robots, e in Salas_Este} x[r, e] * Tiempo_R_Sala[r, e])) - 1;

/*/////// Funcion Objetivo ///////*/
minimize Tiempo_Espera: (sum{r in Robots, s in Salas} (x[r, s] * Tiempo_R_Sala[r, s])) +
          ((sum{p in Puertas} (Tiempo_Espera_Inicial[p] - sum{e in Elementos} Reduccion_Tiempo_Visitante[e] * y[p, e]))/3);
end;
