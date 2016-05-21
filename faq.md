Frequently Asked Questions
==========================


Nginx
-----


Agrega la siguiente línea en `/etc/yum.repos.d/epel.repo` y `/etc/yum.repos.d/nginx.repo`


    exclude=nginx

Docker
------


Como inicio un contenedor ya existente, pero que se detuvo por
cualquier motivo?


    docker start <uuid|name>


    docker start -ai <uuid|name>


Oracle
------

### Conect to data base comman line interface (sqlplus)


    sqlplus <user>/<pass>@<host>[:1521]/<SID>


Examples:


    ## Conect as DB administrator
    sqlplus / as sysdba


    ## Connect as lexsys' schema user on default port to LEXDB oracle
    ## instance
    sqlplus lexusr/s3cr3t@127.0.0.1/LEXDB



In Unix systems the system library path must be set to include Oracle's
install path in order to run `sqlplus`.


Example:


    ## Must be run as root or with sudo
    export LD_LIBRARY_PATH=/lib/oracle/11.2/lib



### Database dump


    expdp <user>/<pass>@<SID> schemas=<schema> directory=<dump_path>
      dumpfile=<dump_file> logfile=<log_file>


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

### Como inicio el API en modo manual o de desarrollo?


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




MongoDB
-------


### Como consulto los eventos del API en MongoDB?


        db.getCollection('<ambiente>').find({}).sort({datetime:-1})



---
### Como convierto Formatos y Pantallas a PDF?


