# Preguntas Frecuentes


### API


#### ¿BAD REQUEST - Timestamp header required with UTC datetime in ISO 8601 format?

TODO


### Docker

#### ¿Como inicio un contenedor ya existente?


	docker start <uuid|name>


o


	docker start -ai <uuid|name>


### MongoDB

#### ¿Como creo un usuario administrador de MongoDB?


	mongo
    use admin
    db.createUser({ user:"admin", pwd:"<s3cr3t>", roles:[{rol:"userAdminAnyDatabase", db:"admin"}] });
    <CTRL+D>


#### ¿Como creo un usuario de MongoDB?


	mongo
    use <new_collection>
    db.createUser({ user:"<newuser>", pwd:"<s3cr3t>", roles:[{rol:"readWrite", db:"<new_collection>"}] });
    <CTRL+D>


#### ¿Como asigno otros roles a un usuario existente?


    use <colección>
      db.grantRolesToUser(
      "<usuario>", [{ role: "readWrite", db: "<base_de_datos>" }])



#### ¿Como creo un usuario para una colección?


    mongo
    use <collection>
    db.createUser({ user:"<user>",
      pwd:"<s3kr33t>", roles: [
        {role: "readWrite", db: "<db>"}]});



#### ¿Como importar un archivo de JSON?


    mongoimport -d <database> -c <colletion> --jsonArray < <file.json>


El archivo debe tener un formato:


    { key:value, nestedvalues: { anarray: [firts, secon, third] } }



#### ¿Como hacer búsquedas en el log de eventos?

La siguiente sentencia busca todos los eventos que fuerón exitosos:
_OK_, _ERROR_ también se puede usar.


    db.<collection>.find({level:'INFO', status:'OK'})


#### ¿Como busco por fechas?


#### ¿Como inicio MongoDB en Docker?

Para ejecutar una instancia de MongoDB en Docker con seguridad
habilitada.


    docker run --name mongodb -d -P -p 27017:27017 mongo --auth


Si no se desea seguridad puede omitirse el parámetro `--auth`
db.createUser({user:"admin",pwd:"Qwzx!",roles:[{role:"userAdminAnyDatabase",db:"admin"}]});


### Nginx

#### ¿Como instalo Nginx para LexSys?

Agrega la siguiente línea en `/etc/yum.repos.d/epel.repo` y `/etc/yum.repos.d/nginx.repo`


    exclude=nginx


### OracleDB

#### ¿Como inicio una instancia de la base de datos?


    sqlplus /nolog
    connect / as sysdba
    startup
    <CTRL+D>
    lsnrctl start


#### ¿Como me conecto a una instancia de OracleDB en línea de comandos? (sqlplus)


    sqlplus <user>/<pass>@<host>[:1521]/<SID>


**Examples:**


    ## Conect as DB administrator
      sqlplus / as sysdba


    ## Connect as lexsys' schema user on default port to LEXDB oracle
      ## instance
      sqlplus lexusr/s3cr3t@127.0.0.1/LEXDB


#### sqlplus: /usr/lib/oracle/12.1/client64/bin/sqlplus: error while loading shared libraries: libsqlplus.so: cannot open shared object file: No such file or director


    echo 'export ORACLE_HOME=/lib/oracle/11.2' >> ~/.bashrc
    echo 'export LD_LIBRARY_PATH=$ORACLE_HOME/lib' >> ~/.bashrc



#### ¿Como hago un volcado de la base de datos?


    expdp <user>/<pass>@<SID> schemas=<schema> directory=<dump_path>
      dumpfile=<dump_file> logfile=<log_file>



#### ORA-12162: TNS:net service name is incorrectly specified


    export ORACLE_SID=<INSTANCIA>
      export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe
      export PATH=$ORACLE_HOME/bin:$PATH


#### ORA-01078: failure in processing system parameters. LRM-00109: could not open parameter file

Copiar init.ora a init\<INSTANCIA>.ora


    cp


#### ¿Como saber el tablespace del esquema?


	 select owner, table_name, tablespace_name
     from dba_tables
     where table_name='<SOME_TABLE>'


#### ¿Como instalo oracle DB en Docker?


    docker run -dit -p 1521:1521 -p 2222:22 -v /home/oracle:/mnt -v /home/oracle/u01:/u01 --name oracledb centos:7 /bin/bash



### PostgreSQL

#### ¿Como crear una base de datos?

**SQL**


	CREATE DATABASE <dbname> WITH ENCODING 'UTF8'
    TEMPLATE=template0 OWNER '<owner>'


**Sistema Operativo**


	createdb -O <owner>


#### ¿Como busco por coincidencia parcial ignorando mayúsculas o minúsculas?


	select case_id, summary from cases
    where summary ilike any (array ['prueba%','Prueba%']);



#### ¿Como inicio PostgreSQL en un contenedor Docker?


    docker run -d -P -p <host-ip>:5432:5432 -e POSTGres_PASsword=<pass>
--name <some-name> postgres



### Python


#### ¿Como instalo Python 2.7. en Red Hat Enterprise Linux y CentOS 6?

RHEL/CentOS 6 no incluyen python 2.7, para instalarlo es necesario
habilitar el repositorio SCL.

Instala el repositorio correspondiente desde aquí
Instala python27 ejecutando el comando


	scl install python27


Agrega el script que habilita python 2.7 en `~/.bash_profile`


	echo '. /opt/rh/python27/enable' >> ~/.bash_profile


#### ¿Que es uWSGI?

uWSGI es un servidor de aplicaciones python que implementa la Web
Server Gateway Interface


### API


#### ¿Como inicio el API en modo manual o de desarrollo?


	cd ~/wrath
    ENV/bin/python dev_server.py <nombre_de_ambiente>


#### ¿Como consulto los eventos del API en MongoDB?


	db.getCollection('<ambiente>').find({}).sort({datetime:-1})



### Editor de Contenidos


#### ¿Que hago si el editor no exporta con mensaje de error `TypeError: Cannot read property 'meta' of undefined`?


	exportToAPI true boolean
     Rendereando cuerpo formato
     Uniendo cuerpo de formato con su plantilla
     /home/SIGIPPEM/EDITOR/models/procedimiento.coffee:246
               if (body.meta && body.meta)

     TypeError: Cannot read property 'meta' of undefined


El editor no encuentra el API, revisar la URL del API en `config.json`


### Escritorio de Trabajo



### Portal de Servicios



### Unix/Linux

#### ¿Como sincronizo la hora de los servidores?


    ntpdate -s time.nist.gov

#### ¿Como genero el digest para las peticiones al API en el shell?


    echo -n "value" | openssl dgst -sha1 -hmac "key" | cut -d ' ' -f 2
