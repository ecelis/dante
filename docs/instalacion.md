LexSys
======


Guia de Instalación
-------------------


### Requisitos del Sistema

* [Red Hat Enterprise Linux 6 o 7 / CentOS 6 o 7][rhel]
* [PostgreSQL 9.4][psql] / [Oracle Database][oracle]
* [MongoDB 2.6][mongodb]
* [Python 2.7][python]
* [setuptools 19.x.x][setuptools]
* [pypi 8.x.x][pypi]
* [Virtualenv][virtualenv]
* [uWSGI 2.0][uwsgi]
* [NodeJS 4.2][nodejs]


LexSys esta soportado para ejecutarse en el sistema operativo Red Hat
Enterprise Linux versiones 6 o 7 o clones de este. CentOS es una
distribución de GNU/Linux derivada de las fuentes de Red Hat
Enterprise Linux (RHEL) donde LexSys ha sido probado.

LexSys se desarrolla y prueba en sistemas de 64 bit, las instalaciones
en sistemas operativos de 32 bit no están soportadas.


### Dependencias

Enseguida se listan los paquetes .rpm necesarios para instalar y
ejecutar LexSys en RHEL/CentOS 6 y 7, además de las dependencias
necesarias para cada motor de base de datos a usar, Oracle Database o
PostgreSQL.

#### RHEL 6

En Red Hat Enterprise Linux 6 asegurate de habilitar los
repositorios Optional y Software Collections para instalar Python 2.7 y
MongoDB 2.6


    subscription-manager repos --enable rhel-server-rhscl-6-rpms
    subscription-manager repos --enable rhel-6-server-optional-rpms


* tar
* gzip
* make
* gcc
* gcc-c++
* git
* openssl-devel
* pcre-devel
* zlib-devel
* rh-mongodb26
* rh-mongodb26-mongodb-server
* rh-mongodb26-mongodb-runtime
* rh-mongodb26-mongodb-devel

#### RHEL 7

En Red Hat Enterprise Linux 7 asegurate de habilitar los
repositorios Optional y Software Collections para instalar MongoDB 2.6


    subscription-manager repos --enable rhel-server-rhscl-7-rpms
    subscription-manager repos --enable rhel-7-server-optional-rpms


* tar
* gzip
* make
* gcc
* gcc-c++
* git
* openssl-devel
* pcre-devel
* zlib-devel
* python-pip
* python-devel
* python-virtualenv
* python-virtualenvwrapper
* rh-mongodb26
* mongodb-server
* mongodb-devel

#### Oracle

* libaio
* oracle-instantclient12.1-basic
* oracle-instantclient12.1-devel

_Oracle Instant Client debe descargarse directamente del sitio web
http://www.oracle.com/technetwork/database/features/instant-client/index.html
los archivos se deben descargar en el directorio_ `/tmp`

#### PostgreSQL

* libpqxx
* libpqxx-devel
* postgresql94
* postgresql94-contrib
* postgresql94-devel


#### Repositorios YUM adicionales

Es necesario habilitar los repositorios **'optional'** y **'extra'**
para utilizar paquetes de EPEL que dependen de paquetes que existen en
estos repositorios.


##### EPEL CentOS 6/7


    yum -y install epel-release


##### EPEL RHEL 6/7

Agrega el paquete del repositorio correspondiente desde
https://fedoraproject.org/wiki/EPEL


##### Python 2.7 Software Collection RHEL 6


    sh -c 'http://people.redhat.com/bkabrda/scl_python27.repo \
      >> /etc/yum.repos.d/scl.repo'


##### Python 2.7 Software Collection CentOS 6


    yum -y install centos-release-scl


### Instalación Semi-Automática

El script `bootstrap.sh` configura una instalación mínima del sistema
operativo preparandolo para la instalación de los componentes de LexSys.
`lexinstall_<DB>_<OS>.run` descomprime los componentes de LexSys en el
directorio del usuario dueño del sistema.


    curl -o bootstrap.sh http://download.lexsys.net/bootstrap.sh
    ./bootstrap.sh


Como usuario `lexusr` ejecuta el archivo de instalación de LexSys.


    curl -o lexinstall_<DB>_<OS>.run \
      http://download.lexsys.net/lexinstall_<DB>_<OS>.run
    ./lexinstall_<DB>_<OS>.run


### Instalación Manual


#### Preparativos para la instalación


**Para la instalación es necesario que los servidores puedan acceder a
la Internet, este requisito es solo necesario durante la instalación o
actualización del sistema**

LexSys puede ejecutarse como cualquier usuario sin privilegios, sin
embargo se sugiere crear un usuario `lexusr`.


    useradd -m -G wheel $LEXUSR
    passwd $LEXUSR
    chmod 755 $LEXHOME


Los archivos de log se almacenan en `/var/log/lexsys` es necesario crear
este directorio.


    mkdir -p $LOGDIR
    chown -R $LEXUSR:$LEXUSR $LOGDIR


_Los pasos siguientes aplican tanto para instalaciones en un solo
servidor o donde se quiera separar la Base de Datos de la Aplicación
Web_


1. Actualiza el sistema operativo
2. Instalación de dependencias según motor de base de datos


    yum -y update


#### Dependencias PostgreSQL

##### Repositorio YUM PostgreSQL en RHEL/CentOS 6


    yum -y install \
      http://yum.postgresql.org/9.4/redhat/rhel-6-x86_64/pgdg-redhat94-9.4-1.noarch.rpm


##### Repositorio YUM PostgreSQL en RHEL/CentOS 7


    yum -y install \
      http://yum.postgresql.org/9.4/redhat/rhel-7-x86_64/pgdg-centos94-9.4-2.noarch.rpm


_Paquetes de PostgreSQL requeridos tanto en el servidor de Base de
Datos como en el servidor de aplicaciones._


    yum -y install libpqxx libpqxx-devel \
      postgresql94 postgresql94-contrib postgresql94-devel


#### Dependencias Oracle Database


    yum -y install libaio
    rpm -Uvh /tmp/oracle-instantclient12.1-basic-12.1.0.2.0-1.x86_64.rpm
    rpm -Uvh /tmp/oracle-instantclient12.1-devel-12.1.0.2.0-1.x86_64.rpm


### Servidor de Base de Datos

#### Servidor PostgreSQL

1. Instala los paquetes de PostgreSQL
2. Inicializa PostgreSQL
3. Habilita PostgreSQL para iniciar con el sistema operativo
4. Habilita el firewall para permitir conexiones a PostgrSQL, en el
   caso de instalación en servidor de Base de Datos independiente
5. Configura entorno del usuario lexusr
6. Crea el usuario de PostgreSQL y la Base de Datos


	    yum -y install postgresql94-server postgresql94-contrib
	    /usr/pgsql-9.4/bin/postgresql94-setup initdb
	    systemctl enable postgresql-9.4.service
	    systemctl start postgresql-9.4.service
	    echo 'export PATH=/usr/pgsql-9.4/bin:$PATH' \
	      >> /home/lexusr/.bashrc
	    su -c 'createuser -lsP lexusr' - postgres
	    su -c 'createdb -O lexusr lexsys' - postgres


Los archivos de configuración de PostgreSQL se encuentran en el
directorio `data` del servidor. Normalmente en la ruta
`/var/lib/pgsql/9.4/data`.

La autenticación de los clientes de PostgreSQL se controla en el
archivo de configuración `pg_hba.conf`, este archivo esta bien
comentado y explica las diversas formas para configurar la
autenticación. En instalaciones donde la aplicación y la base de
datos viven en el mismo equipo una línea como la siguiente es
suficiente:


        host    all             all             127.0.0.1/32            md5


Para el caso de servidor de base de datos en un equipo dedicado se debe
agregar el segmento de red o la(s) IP del servidor de aplicaciones.

Por último, en una instalación con servidor dedicado a base de
datos, es necesario editar el archivo `postgresql.conf` y modificar
el valor de `listen_addresses` con la IP donde el servidor
debe escuchar por conexiones. Normalmente esta línea esta
comentada y PostgreSQL solo escucha en `localhost`.


#### Servidor Oracle Database

Instala Oracle Database de acuerdo a la _Database Installation Guide_
   http://docs.oracle.com/database/121/LADBI/toc.htm



        --DDL para generar el esquema y usuario:
         
        --Los datafiles se crearan en el path default a menos que se indique el path dedicado...
        CREATE TABLESPACE LEXSYS_DAT DATAFILE 'LEXSYS_DATA.DBF' SIZE 200M
	        AUTOEXTEND ON NEXT 50M MAXSIZE UNLIMITED LOGGING 
	        EXTENT MANAGEMENT LOCAL AUTOALLOCATE BLOCKSIZE 8K
	        SEGMENT SPACE MANAGEMENT AUTO FLASHBACK ON;

        CREATE TABLESPACE LEXSYS_INX DATAFILE 'LEXSYS_INX.DBF' SIZE 100M
	        AUTOEXTEND ON NEXT 50M MAXSIZE UNLIMITED LOGGING
	        EXTENT MANAGEMENT LOCAL AUTOALLOCATE BLOCKSIZE 8K
	        SEGMENT SPACE MANAGEMENT AUTO FLASHBACK ON;
         
        CREATE USER LEXUSR IDENTIFIED BY nsjp01 DEFAULT TABLESPACE "LEXSYS_DAT"
	        QUOTA UNLIMITED ON "LEXSYS_DAT";
         
        GRANT "CONNECT" TO LEXUSR;
        GRANT RESOURCE TO LEXUSR;
         
        ALTER USER LEXUSR QUOTA UNLIMITED ON "LEXSYS_INX";
        
        COMMIT;
        
        --Tablespaces por schema
        SELECT OWNER, TABLESPACE_NAME, SUM(BYTES) /1048576 AS MBYTES
        FROM DBA_SEGMENTS
        GROUP BY OWNER, TABLESPACE_NAME
        ORDER BY OWNER, TABLESPACE_NAME;

        --Datafiles por Tablespaces:
        Select file_name, BYTES, blocks, autoextensible,
               nvl(increment_by, 0) increment_by, maxbytes, maxblocks, status,
               maxblocks maxextend, file_id
        from   sys.dba_data_files
        where  TABLESPACE_NAME = 'LEXSYS_DAT';
         
        Select file_name, BYTES, blocks, autoextensible,
               nvl(increment_by, 0) increment_by, maxbytes, maxblocks, status,
               maxblocks maxextend, file_id
        from   sys.dba_data_files
        where  TABLESPACE_NAME = 'LEXSYS_INX';
         
         
         

### Instalacion de Módulos LexSys

1. Instala las dependencias necesarias desde los repositorios de
   RHEL/CentOS
2. Instala virtualenv y uwsgi
3. Instala nodejs 4 y los módulos de nodejs necesarios para compilar las
   aplicaciones
4. Habilita e inicia el servicio MongoDB
5. Crea un usario administrador de MongoDB y las bases de datos para log
   del API y contenidos del Editor


##### Dependencias de LexSys en RHEL/CentOS 6


    yum -y install tar gzip gcc gcc-c++ git \
      openssl-devel pcre-devel zlib-devel \
      python27 python27-python-devel \
      mongodb mongodb-server mongodb-devel
    easy_install-2.7 -U setuptools pip
    pip2.7 install uwsgi virtualenv
    cd /tmp
    wget https://nodejs.org/dist/v4.2.6/node-v4.2.6-linux-x64.tar.gz
    cd /usr/local
    tar --strip-components=1 -xvzf
      /tmp/node-v4.2.6-linux-x64.tar.gz
    npm install --loglevel info -g pm2 bower gulp grunt-cli coffee-script


##### Dependencias de LexSys en RHEL/CentOS 7


    yum -y install tar gzip gcc gcc-c++ git \
      openssl-devel pcre-devel zlib-devel \
      python-pip python-devel python-virtualenv \
      mongodb mongodb-server mongodb-devel
    pip install virtualenv uwsgi
    cd /tmp
    wget https://nodejs.org/dist/v4.2.6/node-v4.2.6-linux-x64.tar.gz
    cd /usr/local
    tar --strip-components=1 -xvzf
      /tmp/node-v4.2.6-linux-x64.tar.gz
    npm install --loglevel info -g pm2 bower gulp grunt-cli coffee-script



##### Habilita MongoDB en RHEL/CentOS 6


    chkconfig mongod on
    service start mongod


##### Habilita MongoDB en RHEL/CentOS 7


    systemctl enable mongod
    systemctl start mongod


##### Configuración de MongoDB


    mongo
    use admin
    db.createUser({ user:"admin", pwd:"adminpassword",
      roles: ["userAdminAnyDatabase"] });
    use lexeditor
    db.createUser({user:"lexusr",pwd:"editorpassword",
      roles:["readWrite"]});
    use api_log
    db.createUser({user:"lexusr",pwd:"apilogpassword",
      roles:["readWrite"]});
    exit


#### Código Fuente LexSys

El código fuente de las versiones publicadas de LexSys se puede
descargar en http://descarga.lexsys.net usando las credenciales de
acceso proporcionadas junto con el software y esta guia.


#### Instalación API

Instalación de entorno virtual y dependencias del API.


    su - $LEXUSR
    cd $LEXHOME/wrath
    rm -rf ENV
    virtualenv ENV
    $LEXHOME/wrath/ENV/bin/pip install -r $LEXHOME/wrath/requirements.txt


Genera la documentación del API.


    su - $LEXUSR
    cd $LEXHOME/wrath
    . ENV/bin/activate
    cd doc
    mkdocs build --clean


#### Configuración API


##### Configuración de Carga Masiva


`cm.json` configura las rutas para la carga masiva de datos.


`dir`: Ruta de los archivos Excel, estos deben estar dentro de un
subdirectorio debajo de esta ruta con nombre que coincida con la fecha
de la carga en format YYYYMMD. `ej.: 20160420000`


`sheet_config`: Ruta relativa al directorio de instalación del API que
indica el archivo `.json` que contiene el mapeo de las hojas de Excel a
las tablas y columnas de la base de datos de LexSys.


        {
	        "dir": "/home/lexusr/cm/<ambiente>",
	        "sheet_config": "config/sheet_config.json"
        }


##### Configuración de la Base de Datos



`database.json` configura la conexión con la base de datos y rutas de
archivos Excel con catálogos estáticos exclusivos para cada instalación.


        {
	        "engine": "<postgresql|oracle|sqlite>",
	        "server": "<db_host>",
	        "port": <db_tcp_port>,
	        "user": "<bd_user>",
	        "password": "<db_password>",
	        "id": "<db_name>",
	        "catalogs_sheet_config": "config/sheet_config.json",
	        "exec_scripts_config": "gluttony/<postgresql|oracle|sqlite>/scripts.json",
	        "catalogs": [
		        {
			        "path": "config/catalogs.xlsx",
			        "sheets": [
				        "entity_types",
				        "person_types",
				        "proceeding_types",
				        "transition_types",
				        "proceeding_status",
				        "resources",
				        "domains",
				        "domain_resources",
				        "penal_codes"
			        ]
		        },
		        {
			        "path": "config/dev_data.xlsx",
			        "sheets": [
				        "case_fields",
				        "law_types",
				        "law_entry_types",
				        "apps",
				        "app_installs",
				        "app_domains"
			        ]
		        },
		        {
			        "path": "config/static_catalogs.xlsx",
			        "sheets": [
				        "catalogs_index",
				        "system_catalogs"
			        ]
		        },
		        {
			        "path": "config/<ambiente>_catalogs.xlsx",
			        "sheets": [
				        "catalogs_index",
				        "system_catalogs"
			        ]
		        },
		        {
			        "path": "/home/lexusr/cm/operation.xlsx",
			        "sheets": [
				        "towns",
				        "territorial_trees",
				        "institutions",
				        "operators",
				        "proceedings",
				        "transitions",
				        "legacy_formats",
				        "territorial_levels",
				        "territorial_units",
				        "territorial_mappings",
				        "titles",
				        "users",
				        "offices",
				        "territorial_offices",
				        "positions",
				        "roles_wr",
				        "title_roles",
				        "role_proceedings",
				        "tags",
				        "proceeding_tags"
			        ]
		        },
		        {
			        "path": "/home/lexusr/cm/crimes.xlsx",
			        "sheets": [
				        "laws",
				        "law_entry_levels",
				        "law_entries",
				        "law_entry_references"
			        ]
		        },
		        {
			        "path": "/home/lexusr/cm/series.xlsx",
			        "sheets": [
				        "series_types"
			        ]
		        }
	        ]
        }



Copia Los archivos de configuración de uWSGI a `/etc`


        su - $LEXUSR
        cd ~
        cp -r $LEXHOME/deployment/uwsgi /etc
        chown -R $LEXUSR:$LEXUSR /var/log/lexsys


Es necesario configurar un ambiente en el directorio `wrath/config`, la
instalación incluye un directorio `lexbuild` que se puede copiar y
modificar los archivos de configuración incluidos para que se ajusten a
la instalación de la institucion.

Generalmennte solo es necesario editar `wrath/config/database.json`.


    cp -r $LEXHOME/wrath/config/example $LEXHOME/wrath/config/<AMBIENTE>


El paso final en la instalación del API es poblar la base de datos con
la información inicial para catálogos, procedimientos, sequencias y
usuarios del sistema. Esto se lleva a cabo utilizando arvhivos de excel
que se colocan en el directorio `cargas_masivas` en `$LEXHOME` del usuario
dueño de la aplicación, `lexusr` si se usa el usuario sugerido en esta
guía de instalación.


    su - $LEXUSR
    cd $LEXHOME/wrath
    ENV/bin/python db_generator.py <nombre_de_ambiente>


### Editor de Contenidos

1. Crea un entorno virtual de python
2. Instala los módulos de nodejs y bower
3. Edita `config.json`
3. Compila la aplicación
4. Inicia el servidor de aplicaciones NodeJS pm2


	    su - $LEXUSR
	    cd $LEXHOME/EDITOR
	    virtualenv ENV
	    npm install --loglevel info
	    bower install
	    vi config.json
	    vi $LEXHOME/deployment/pm2.json
	    grunt assets
	    pm2 start $LEXHOME/deployment/pm2.json
	    pm2 status


### Portal de Servicios

1. Instala los módulos de nodejs y bower
2. Edita `config-<nombre_de_ambiente>.js` de acuerdo a tu ambiente de instalación
apunte a la instalación del API
3. Compila la aplicación


	    su - $LEXUSR
	    cd $LEXHOME/sloth
	    npm install --loglevel info
	    bower install
	    vi config-<nombre_de_ambiente>.js
	    grunt assets --env <nombre_de_ambiente>


### Escritorio de Trabajo

1. Instala los módulos de nodejs y bower
2. Edita `src/config.json`
3. Compila la aplicación


	    su - $LEXUSR
	    cd $LEXHOME/wpride
	    npm install --loglevel info
	    vi src/config.json
	    gulp build --env production --target <nombre_de_ambiente>


### Proxy HTTP

Los diferentes módulos de LexSys son expuestos vía HTTP, el _único_
servidor web que se ha probado y se sugiere para despligues de
producción es Nginx.

LexSys requiere una versión de Nginx con el plugin nginx_headers_more
que el paquete nginx de RHEL/CentOS 6 y 7 disponible en sus repositorios
YUM no incluye.

Puedes instalar un paquete RPM con el plugin ya compilado para
RHEL/CentOS 6 y 7.


**RHEL/CentOS 6**


    yum -y install https://download.lexsys.net/el6/nginx-1.8.0-TIC.1.el6.centos.ngx.x86_64.rpm


**RHEL/CentOS 7**


    yum -y install https://download.lexsys.net/el7/nginx-1.8.0-TIC.1.el7.centos.ngx.x86_64.rpm


Configura Nginx


    su -
    cp -r ~/deployment/nginx.conf /etc/nginx
    vi /etc/nginx/nginx.conf


Habilita e inicia el servicio nginx

**RHEL/CentOS 6**


    su -
    chkconfig nginx on
    service start nginx


**RHEL/CentOS 7**


    su -
    systemctl enable nginx
    systemctl start nginx


#### Instalacion distribuida


Editar el archivo distributed.json

**enabled**: true | false Habilita la configuración distribuida

**delete_processed_**: true | false Borra los casos de la instancia una
vez que han sido enviados a instancias remotas del API.

**timeout**: segundos Tiempo de caducidad de TODO ?

**apis**: Conjunto de APIs distribuidas que son conocidas



        "api_xyz": { ## Nombre del API remota
          "local": { 
            "app_key": "UUID de el API", 
            "approved_ip": "IP Permitida",
            "operators":[ ## Areglo de operadores conocidos por esa aPI
              "XYZ.DP",
              "XYZ.AJ"
            ]
          },
          "remote":{
            "api_url": "URL del API remota",
            "app_key": "UUID aceptada por el API",
            "app_secret": "Hash del app_key"
          }

**Ejemplo completo**


    {
      "enabled": true, 
      "delete_processed": false,
      "timeout": 8,
      "apis":
      {
        "api_ssp": {
          "local": { 
            "app_key": "ey918669-797d-4488-97ed-a99c6fdce203", 
            "approved_ip": "localhost",
            "operators":[ 
              "SSP.PP",
              "SSP.PR",
              "SSP.MC",
              "SSP.CD",
              "SSP.CR",
              "SSP.SM",
              "FGE.MP"
            ]
          },
          "remote":{
            "api_url": "http://162.40.6.40:6061",
            "app_key": "tx35615f-8677-419b-ae47-5f83f94gtqer",
            "app_secret": "1234560e314df2219b2a3d1a29bec3fab0333ca6a9e67dc59e469da7b7890123"
          }
        },
        "api_xyz": {
          "local": { 
            "app_key": "ctyui113-6b71-480f-8799-e1180caewasd", 
            "approved_ip": "localhost",
            "operators":[ 
              "XYZ.DP",
              "XYZ.AJ"
            ]
          },
          "remote":{
            "api_url": "http://192.66.6.00",
            "app_key": "12345567-8677-419b-ae47-5f83f9890421",
            "app_secret": "ewqtyu0e314df2219b2a3d1a29bec3fab0333ca6a9e67dc59e469da7bfgvcesq"
          }
        }
      }
    }


**Ejecución de eventos programada**

    crontab -e
    * * * * * /usr/bin/curl -X POST http://<apiurl>/time_events \
      --header "Content-Type:application/json" --data "{}" \
      >> /var/log/lexsys/pooling.log 2>&1


Seguridad
---------


### HTTPS


HTTPS también HTTP sobre TLS, HTTP sobre SSL o HTTP Seguro es un
protocolo para comunicación segura ampliamente usado en aplicaciones
web. HTTPS consiste de comunicación encriptada por TLS o su
predecesesor SSL, se usa para proteger la autenticación de usuarios en
la aplicación web y el intercambio de datos entre el navegador web y el
API de la aplicación.

LexSys usa Nginx como proxy http, para que aceptar conexiones HTTPS el
administrador debe crear un certificado de llave pública para Nginx.
**Este certificado debe estar firmado por una autoridad de certificación
confiable para que el navegador web lo acepte sin presentar
adevertencias al usuario**. Organizaciones privadas pueden también ser
su propia autoridad certificadora, pero deben ocuparse de agregar copias
de su propio certificado de firma en los navegadores web de la
organización.


### Configuración de Nginx


    mkdir /etc/nginx/ssl
    cd /etc/nginx/ssl
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout \
      /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt


Ejemplo de configuración HTTPS en Nginx


    server {
        listen 80 default_server;
        listen [::]:80 default_server ipv6only=on;

        listen 443 ssl;

        root /usr/share/nginx/html;
        index index.html index.htm;

        server_name your_domain.com;
        rewrite     ^   https://$server_name$request_uri? permanent;
        ssl_certificate /etc/nginx/ssl/nginx.crt;
        ssl_certificate_key /etc/nginx/ssl/nginx.key;

        location / {
                try_files $uri $uri/ =404;
        }
    }


Respaldos
---------

### Respaldo de Bases de Datos


#### Oracle Database


**Respaldo**


    TODO


    -Nombre del directorio en la DB (debe existir el path físico con permisos de lectura/escritura a nivel OS para el owner de la DB)

    --Permisos de lectura/escritura sobre el directorio a nivel DB para el usuario owner del schema.

    --El nombre del directorio deberá ser adecuado al path a utilizer para actividades de export/import...
    grant READ, WRITE on DIRECTORY DATA_PUMP_DIR to EDOMEX_USR;	

    grant DATAPUMP_EXP_FULL_DATABASE to LEXUSR;
    grant DATAPUMP_IMP_FULL_DATABASE to LEXUSR;
    grant CREATE JOB to LEXUSR;
    grant SCHEDULER_ADMIN to LEXUSR;
    grant SELECT on DBA_SCHEDULER_JOB_RUN_DETAILS to LEXUSR;
    grant SELECT on DBA_SCHEDULER_RUNNING_JOBS to LEXUSR;
    grant SELECT on DBA_SCHEDULER_JOBS to LEXUSR;
    grant SELECT on DBA_OBJECTS to LEXUSR;
    grant CONNECT to LEXUSR;
    grant RESOURCE to LEXUSR;
    grant CREATE VIEW to LEXUSR;

    --Parametro JOB_QUEUE_PROCESSES seteado en al menos 5

    show parameter JOB_QUEUE_PROCESSES


**Import Volcado de la Base de Datos**


    impdp LEXUSR@DB_NAME schemas=LEXUSR directory=DATA_PUMP_DIR dumpfile=dumpfileLEXUSR.dmp logfile=impdp_dumpfileLEXUSR.log

    --Si los schemas y tablespaces difieren entre origen y destino, es necesario emplear remap_schema y remap_tablespace:

    --impdp SYS@DB_NAME schemas=LEXUSR directory=DATA_PUMP_DIR dumpfile=dumpfileLEXUSR.dmp logfile=impdp_dumpfileLEXUSR.log REMAP_TABLESPACE=source_tablespaceData:target_tablespaceData REMAP_TABLESPACE=source_tablespaceIndex:target_tablespaceIndex remap_schema=source_schema:USERNAME_USR(target_schema)


#### PostgreSQL


Para hacer un respaldo binario y comprimido de la base de datos ejecuta:


    pg_dump -h <host> -U <usuario> -W -Fc <base_de_datos> > <respaldo.bak>


Para restaurar el respaldo creado con `pg_dump`


    pg_restore -d <base_de_datos> <respaldo.bak>


#### MongoDB

Para respaldar la base de datos mongoDB se ejecuta `mongodump` con el
nombre de la base de datos y el directorio destino para el respaldo.

    mongodump -h <host> -u <usuario> -p <password> \
      --db <base_de_datos> --out <ruta_respaldo>


Los respaldos de mongoDB generados con `mongodump` se pueden
restaurar en otra instanacia de mongoDB o en una base de datos
diferente ejecutando el comando `mongorestore` que toma parametros de
base de datos donde restaurar las colecciones de documentos en el
respaldo y la ruta donde se encuentra el respaldo.

    mongorestore --host <host> --username <usuario> --pawwsord <password> \
      --db <base_de_datos> <ruta_respaldo>


Referencias
-----------

* [HTTP sobre TLS](https://tools.ietf.org/html/rfc2818)
* [TLS 1.2](https://tools.ietf.org/html/rfc5246)
* [SHA-1 Hash Algorithm Migration for SSL & Code Signing Certificates](http://www.symantec.com/page.jsp?id=sha2-transition)
* https://access.redhat.com/documentation/en-US/Red_Hat_Software_Collections/2/html/2.0_Release_Notes/chap-RHSCL.html

---

[rhel]: https://access.redhat.com/documentation/en/red-hat-enterprise-linux/
[psql]: http://www.postgresql.org/docs/9.4/static/index.html
[mongodb]: https://docs.mongodb.org/v2.6/
[python]: https://python.org/
[virtualenv]: https://virtualenv.pypa.io/en/latest/
[uwsgi]: http://uwsgi-docs.readthedocs.org/en/latest/
[nodejs]: https://nodejs.org/en/docs/
[nginx]: http://nginx.org/en/docs/
[oracle]: http://www.oracle.com
