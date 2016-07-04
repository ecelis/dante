# Preguntas Frecuentes

### Docker

#### Como inicio un contenedor ya existente?


	docker start <uuid|name>


o
    
    
	docker start -ai <uuid|name>


### MongoDB

#### Como creo un usuario administrador de MongoDB?


	mongo
    use admin
    db.createUser({ user:"admin", pwd:"<s3cr3t>", roles:[{rol:"userAdminAnyDatabase", db:"admin"}] });
    <CTRL+D>
    
    
#### Como creo un usuario de MongoDB?
    
    
	mongo
    use <new_collection>
    db.createUser({ user:"<newuser>", pwd:"<s3cr3t>", roles:[{rol:"readWrite", db:"<new_collection>"}] });
    <CTRL+D>
    
    
#### Como creo un usuario para una coleción?


	mongo

### Nginx

#### Como instalo Nginx para LexSys?

Agrega la siguiente línea en `/etc/yum.repos.d/epel.repo` y `/etc/yum.repos.d/nginx.repo`


	exclude=nginx


### OracleDB

#### Como inicio una instancia de la base de datos?


	sqlplus /nolog
    connect / as sysdba
    startup
    <CTRL+D>
    lsnrctl start
    
    
#### Como me conecto a una instancia de OracleDB en línea de comandos? (sqlplus)


	sqlplus <user>/<pass>@<host>[:1521]/<SID>


**Examples:**


	## Conect as DB administrator
    sqlplus / as sysdba


	## Connect as lexsys' schema user on default port to LEXDB oracle
    ## instance
    sqlplus lexusr/s3cr3t@127.0.0.1/LEXDB


#### `sqlplus` me regresa el error `/usr/lib/oracle/12.1/client64/bin/sqlplus: error while loading shared libraries: libsqlplus.so: cannot open shared object file: No such file or director` que hago?


	echo 'export ORACLE_HOME=/lib/oracle/11.2' >> ~/.bashrc
	echo 'export LD_LIBRARY_PATH=$ORACLE_HOME/lib' >> ~/.bashrc


s
#### Como hago un volcado de la base de datos?


    expdp <user>/<pass>@<SID> schemas=<schema> directory=<dump_path>
      dumpfile=<dump_file> logfile=<log_file>


### PostgreSQL

#### Como crear una base de datos?

**SQL**


	CREATE DATABASE <dbname> WITH ENCODING 'UTF8'
    TEMPLATE=template0 OWNER '<owner>'
      
      
**Sistema Operativo**


	createdb -O <owner>        


### Python


#### Como instalo Python 2.7. en Red Hat Enterprise Linux y CentOS 6?

RHEL/CentOS 6 no incluyen python 2.7, para instalarlo es necesario
habilitar el repositorio SCL.

Instala el repositorio correspondiente desde aquí
Instala python27 ejecutando el comando


	scl install python27


Agrega el script que habilita python 2.7 en `~/.bash_profile`


	echo '. /opt/rh/python27/enable' >> ~/.bash_profile


#### Que es uWSGI?

uWSGI es un servidor de aplicaciones python que implementa la Web
Server Gateway Interface


### API


#### Como inicio el API en modo manual o de desarrollo?


	cd ~/wrath
    ENV/bin/python dev_server.py <nombre_de_ambiente>


#### Como consulto los eventos del API en MongoDB?


	db.getCollection('<ambiente>').find({}).sort({datetime:-1})



### Editor de Contenidos


#### Que hago si el editor no exporta con mensaje de error `TypeError: Cannot read property 'meta' of undefined`?


	exportToAPI true boolean
     Rendereando cuerpo formato
     Uniendo cuerpo de formato con su plantilla
     /home/SIGIPPEM/EDITOR/models/procedimiento.coffee:246
               if (body.meta && body.meta) {
                       ^
     TypeError: Cannot read property 'meta' of undefined


El editor no encuentra el API, revisar la URL del API en `config.json`


### Escritorio de Trabajo



### Portal de Servicios




