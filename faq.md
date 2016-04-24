Preguntas Frecuentes
====================

Oracle
------

### Conectar con sqlplus


    sqlplus <user>/<pass>@<host>[:1521]/<SID>

En Unix puede ser necesario agergar la ruta de las bibliotecas de
Oracle a `LD_LIBRARY_PATH` cambia la versión por la que corresponda.


    export LD_LIBRARY_PATH=/lib/oracle/11.2/lib



Python
------

### Como instalo Python 2.7. en Red Hat Enterprise Linux y CentOS 6?

RHEL/CentOS 6 no incluyen python 2.7, para instalarlo es necesario
habilitar el repositorio SCL.

Instala el repositorio correspondiente desde aquí
Instala python27 ejecutando el comando


    scl install python27


Agrega el script que habilita python 2.7 en `~/.bash_profile`


    echo '. /opt/rh/python27/enable' >> ~/.bash_profile


### Que es uWSGI?

uWSGI es un servidor de aplicaciones python que implementa la Web
Server Gateway Interface


API
---


Como inicio el API en modo manual o de desarrollo?


    cd ~/wrath
    ENV/bin/python dev_server.py <nombre_de_ambiente>




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


Portal de Servicios
-------------------





Escritorio de Trabajo
---------------------







---
Como convierto Formatos y Pantallas a PDF?


