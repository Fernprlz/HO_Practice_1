
/*/////////////////// E J E R C I C I O   2 ///////////////////*/
/*/////// Declaracion de conjuntos ///////*/

set Robots;
set Robots356 within Robots;
set Robots24 within Robots;
param Tiempo_objeto{r in Robots};
param Energia_objeto{r in Robots};
param Energia_total{r in Robots};

set Salas;
set SalaA within Salas;
set SalaB within Salas;
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
s.t. rest9B: sum{r in Robots, o in Salas_Oeste} (x[r, o] * Tiempo_R_Sala[r, o]) >= -1 + (1.1 * (sum{r in Robots, e in Salas_Este} x[r, e] * Tiempo_R_Sala[r, e]));

/*/////// Funcion Objetivo ///////*/
minimize Tiempo_Espera: sum{r in Robots, s in Salas} (x[r, s] * Tiempo_R_Sala[r, s]);

end;
