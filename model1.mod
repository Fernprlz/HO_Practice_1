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
/* 0.
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


/*/////// Funcion Objetivo ///////*/
minimize Tiempo_Espera_1: (sum{p in Puertas} (Tiempo_Espera_Inicial[p] - sum{e in Elementos} Reduccion_Tiempo_Visitante[e] * y[p, e]))/3;
end;
