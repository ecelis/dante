Preguntas Frecuentes
====================

Python
------

### Como instalo Python 2.7. en Red Hat Enterprise Linux y CentOS 6?

RHEL/CentOS 6 no incluyen python 2.7, para instalarlo es necesario
habilitar el repositorio SCL.

Instala el repositorio correspondiente desde aquí
Instala python27 ejecutando el comando


    scl install python27


### Que es uWSGI?

uWSGI es un servidor de aplicaciones python que implementa la Web
Server Gateway Interface


Editor de Contenidos
--------------------

### Que hago si el editor no exporta con mensaje de error `TypeError:
Cannot read property 'meta' of undefined`.?


     exportToAPI true boolean
     Rendereando cuerpo formato
     Uniendo cuerpo de formato con su plantilla
     /home/SIGIPPEM/EDITOR/models/procedimiento.coffee:246
               if (body.meta && body.meta) {
                       ^
     TypeError: Cannot read property 'meta' of undefined


#### Respuesta

El editor no encuentra el API, revisar la URL del API en `config.json`


---
Como convierto Formatos y Pantallas a PDF?


