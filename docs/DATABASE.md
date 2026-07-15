\# ⚡ ELECTROCHILE DATABASE



Versión: 1.0



\---



\# OBJETIVO



Definir la estructura de almacenamiento de datos de ElectroChile.



Toda la información del usuario deberá organizarse de forma escalable y preparada para futuras sincronizaciones.



\---



\# MOTOR DE BASE DE DATOS



Versión inicial



SQLite



(Evaluaremos Drift como capa de acceso durante el desarrollo de la v0.3.0).



\---



\# ENTIDADES PRINCIPALES



\## Proyecto



Cada proyecto representa una instalación eléctrica.



Campos:



\- id

\- nombre

\- cliente

\- dirección

\- comuna

\- región

\- distribuidora

\- observaciones

\- fecha\_creación

\- fecha\_modificación



\---



\## Circuito



Cada proyecto puede contener múltiples circuitos.



Campos:



\- id

\- proyecto\_id

\- nombre

\- tipo

\- sistema

\- potencia

\- corriente

\- voltaje

\- longitud

\- conductor

\- protección

\- diferencial

\- canalización

\- caída\_tensión

\- observaciones



\---



\## Cálculo



Historial de cálculos rápidos.



Campos:



\- id

\- tipo

\- entrada

\- resultado

\- fecha



\---



\## Configuración



Preferencias del usuario.



Campos:



\- tema

\- empresa

\- instalador

\- clase\_sec

\- logo



\---



\# RELACIONES



Proyecto



↓



Muchos Circuitos



↓



Cada circuito puede generar



↓



Documentación



↓



PDF



↓



Formulario TE



\---



\# RESPALDO



Versión inicial



Local



Versión futura



Sincronización en la nube.



\---



\# PRINCIPIOS



Nunca duplicar información.



No almacenar datos calculables.



Mantener relaciones simples.



Preparar para crecimiento futuro.



\---



Fin del documento.

