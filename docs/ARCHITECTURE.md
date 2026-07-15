\# ⚡ ELECTROCHILE ARCHITECTURE



Versión: 1.0



\---



\# OBJETIVO



Definir la arquitectura oficial del proyecto ElectroChile.



Toda nueva funcionalidad deberá respetar esta estructura.



\---



\# TECNOLOGÍAS



Frontend



\- Flutter



Lenguaje



\- Dart



Arquitectura



\- Feature First (evolución planificada)



Diseño



\- Material Design 3



Control de versiones



\- Git



Repositorio



\- GitHub



\---



\# ESTRUCTURA GENERAL



ElectroChile/



&#x20;   app/



&#x20;   docs/



&#x20;   roadmap/



&#x20;   changelog/



&#x20;   releases/



&#x20;   logo/



&#x20;   screenshots/



\---



\# ESTRUCTURA FLUTTER



lib/



core/



models/



services/



widgets/



screens/



utils/



assets/



\---



\# EVOLUCIÓN FUTURA



Cuando el proyecto crezca se migrará gradualmente a:



lib/



core/



shared/



features/



&#x20;   home/



&#x20;   projects/



&#x20;   electrical/



&#x20;   documents/



&#x20;   sec/



&#x20;   settings/



Cada Feature tendrá:



presentation/



domain/



data/



widgets/



\---



\# REGLAS



No duplicar código.



Toda lógica matemática debe ir en Services.



Las pantallas no deben contener cálculos.



Los Widgets deben ser reutilizables.



Cada módulo debe ser independiente.



\---



\# NOMENCLATURA



Pantallas



\*\_screen.dart



Widgets



ec\_\*.dart



Modelos



nombre.dart



Servicios



\*\_service.dart



Motores



\*\_designer.dart



\---



\# VERSIONADO



main



Versión estable.



develop



Versión en desarrollo.



Cada versión importante tendrá su TAG.



Ejemplo:



v0.3.0



v0.4.0



v1.0.0



\---



\# PRINCIPIOS



Código limpio.



Escalable.



Documentado.



Fácil mantenimiento.



Preparado para Desktop.



Preparado para Web.



\---



Fin del documento.

