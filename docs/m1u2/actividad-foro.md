# Actividad foro

## Los invitamos a que averigue y comparta alguno de estos temas como es en su organización: 

1. Versionado y estrategias de código: En nuestra empresa hemos desarrollado una api que hace de intermediaria entre Jira, gitlab y nuestro circuito de ci-cd. Cuando un PO define una version nueva de código (estas versiones se definen bajo sus propios criterios) la api de versiones realiza una llamada a gitlab creando un release nuevo y empaquetando el código con el tag de la version ingresada.
A si mismo esta api crea las ramas de cada ticket para que queden vinculados los tickets de jira con los desarrollos.

2. Testing, Unit Test & Test Driven Development: Actualmente estamos utilizando Jest para realizar pruebas unitarias, no implementamos TDD ni nada similar, estamos en una etapa temprana de testings. Hemos integrado al circuito de ci-cd algunas herramientas como SonarCube o Snyk así como la ejecución de test en los MR. Está un poco crudo, solamente ejecuta los testing y frena los MR en caso de que falle alguno.

3. Interfaces entre aplicaciones: poco que comentar, a nivel arquitectura estamos implementando DDD con lo cual la interacción entre aplicaciones se da bajo la definición de DTOs y Eventos.