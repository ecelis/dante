# LexSys

## Guia de Instalación
Revisión 3
Ernesto Celis <ernesto@tic.uno>


### Convenciones usadas en el documento

Las siguientes convenciones tipográficas ocurren durante este texto:

* **negritas** indican palabras o frases que se encuentran en el sistema, nombre de aplicaciones, cajas de diálogo, etc.

* **_negritas itálicas_** notas importantes para el lector.

* _itálicas_ indican variables reemplazables por el usuario, texto en itálicas **_NO para copiar y Pegar_**, también indican la salida de ejemplo de algunos comandos.

* `código` indica texto que el usuario debe teclear o copiar y pegar.

Las siguientes variables de entorno son utilizadas en el texto y los valores sugeridos que además están pre-configurados en los scripts de instalación. Esto valores se pueden modificar en tiempo de ejecución de los scripts o en una instalación manual.


* **$LEXUSR** el usuario del sistema operativo con el que se ejecuta LexSys. **lexusr**

* **\$LEXHOME** directorio base de instalación de LexSys. **/home/$LEXUSR**

* **\$LEXDB** motor de base de datos puede ser **oracle** o **postgresql**

* **\$LEXAPI** ruta de instalación del API. **LEXHOME/wrath**.

* **\$LEXEDITOR** ruta de instalación del Editor de Contenidos **LEXHOME/EDITOR**

* **\$LEXDESK** ruta de instalación del Escritorio de Trabajo **$LEXHOME/wrpide**

* **\$LEXPORTAL** ruta de instalación del Portal de Servicios **$LEXPORTAL/sloth**

* **\$OS\_VERSION** sistema operativo de la instalación. Solo los sistemas operativos Red Hat
Enterprise Linux versiones 6 y 7 y CentOS 6 y 7 están soportados.

* **\$TMPDIR** directorio para archivos temporales **/tmp**


### Notas para el administrador

* LexSys se desarrolla y prueba en sistemas de 64 bit, las instalaciones
en sistemas operativos de 32 bit no están soportadas.

* Para instalaciones en Red Hat Enterprise Linux 6 y 7 es indispensable contar
con una subscripción vigente de Red Hat para cada sistema instalado. Sin una
subscripción es imposible habilitar los repositorios **Software Collections** e
instalar los paquetes requeridos y actualizacones del sistema.

* SELinux se configura como `permissive`



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



### Dependencias

Enseguida se listan los paquetes .rpm necesarios para instalar y ejecutar LexSys
en RHEL/CentOS 6 y 7, además de las dependencias necesarias para cada motor de
base de datos a usar, Oracle Database o PostgreSQL.

#### RHEL 6

* tar
* gzip
* make
* gcc
* gcc-c++
* git
* openssl-devel
* pcre-devel
* rsync
* zlib-devel
* rh-mongodb26
* rh-mongodb26-mongodb-server
* rh-mongodb26-mongodb-runtime
* rh-mongodb26-mongodb-devel
* wget
* unzip


#### RHEL 7

* tar
* gzip
* make
* gcc
* gcc-c++
* git
* openssl-devel
* pcre-devel
* rsync
* zlib-devel
* python-pip
* python-devel
* python-virtualenv
* python-virtualenvwrapper
* rh-mongodb26
* mongodb-server
* mongodb-devel
* wget
* unzip


#### Oracle

* libaio
* oracle-instantclient12.1-basic
* oracle-instantclient12.1-devel


Oracle Instant Client debe descargarse directamente del sitio web
http://www.oracle.com/technetwork/database/features/instant-client/index.html
los archivos se deben descargar en el directorio **$TEMPDIR**


#### PostgreSQL

* libpqxx
* libpqxx-devel
* postgresql94
* postgresql94-contrib
* postgresql94-devel


#### MongoDB

* TODO


#### Repositorios YUM adicionales

Es necesario habilitar los repositorios **'Optional'**, **'Extra'**, **Software
Collections** y **EPEL** para instalar todas las dependencias requeridas.


##### Repositorio EPEL RHEL 6/7

Agrega el paquete del repositorio correspondiente desde
https://fedoraproject.org/wiki/EPEL


##### Repositorios Optional y Software Collections en RHEL 6


		subscription-manager repos --enable rhel-server-rhscl-6-rpms
		subscription-manager repos --enable rhel-6-server-optional-rpms


##### Repositorios Optional y Software Collections en RHEL 7


    subscription-manager repos --enable rhel-server-rhscl-7-rpms
    subscription-manager repos --enable rhel-7-server-optional-rpms


##### Python 2.7 Software Collection CentOS 6/7


    yum -y install centos-release-scl


##### EPEL CentOS 6/7


    yum -y install epel-release


### Instalación Manual

El script `bootstrap.sh` configura una instalación mínima del sistema
operativo preparándolo para la instalación de los componentes de LexSys.


	curl -LO https://github.com/ecelis/acedia/releases/download/v1.0rc1/bootstrap.sh
	chmod +x bootstrap.sh
  ./bootstrap.sh


Este script automatiza los pasos referidos en la sección siguiente:
**Preparativos para la instalación**, si ejecutaste `bootstrap.sh`
puedes ir al punto **Instalacion de Módulos LexSys**


### Preparativos para la instalación

Para la instalación es necesario que los servidores puedan acceder a
la Internet, este requisito es solo necesario durante la instalación o
actualización del sistema

LexSys puede ejecutarse como cualquier usuario sin privilegios.


    useradd -m -G wheel $LEXUSR
    passwd $LEXUSR
    chmod 755 $LEXHOME


Los archivos de log se almacenan en _$LEXHOME/log_ es necesario crear
este directorio.


    mkdir -p $LEXHOME/log
    chown -R $LEXUSR:$LEXUSR $LEXHOME/log


Los pasos siguientes aplican tanto para instalaciones en un solo
servidor o donde se quiera separar la Base de Datos de la Aplicación
Web.

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


Paquetes de PostgreSQL requeridos tanto en el servidor de Base de Datos como en el servidor de aplicaciones.


    yum -y install libpqxx libpqxx-devel \
      postgresql94 postgresql94-contrib postgresql94-devel


#### Dependencias Oracle Database


    yum -y install libaio
    rpm -Uvh /tmp/oracle-instantclient12.1-basic-12.1.0.2.0-1.x86_64.rpm
    rpm -Uvh /tmp/oracle-instantclient12.1-devel-12.1.0.2.0-1.x86_64.rpm


###  Bases de Datos

#### Servidor PostgreSQL

1. Instala los paquetes de PostgreSQL
2. Inicializa PostgreSQL
3. Habilita PostgreSQL para iniciar con el sistema operativo
4. Habilita el firewall para permitir conexiones a PostgrSQL, en el caso de instalación en servidor de Base de Datos independiente.
5. Configura entorno del usuario lexusr.
6. Crea el usuario de PostgreSQL y la Base de Datos


	    yum -y install postgresql94-server postgresql94-contrib
	    /usr/pgsql-9.4/bin/postgresql94-setup initdb
	    systemctl enable postgresql-9.4.service
	    systemctl start postgresql-9.4.service
	    echo 'export PATH=/usr/pgsql-9.4/bin:$PATH' \
	      >> /home/lexusr/.bashrc
	    su -c 'createuser -lsP lexusr' - postgres
	    su -c 'createdb -O lexusr lexsys' - postgres


**P/PGSQL**


    CREATE DATABASE lexsys WITH TEMPLATE=template0 ENCODING 'UTF8'
      OWNER lexusr;



Los archivos de configuración de PostgreSQL se encuentran en el
directorio **data**, normalmente en la ruta
**/var/lib/pgsql/9.4/data**.

La autenticación de los clientes de PostgreSQL se controla en el
archivo de configuración **pg_hba.conf**, este archivo esta bien
comentado y explica las diversas formas para configurar la
autenticación. En instalaciones donde la aplicación y la base de
datos viven en el mismo equipo una línea como la siguiente es
suficiente:


        host    all             all             127.0.0.1/32            md5


Para el caso de servidor de base de datos en un equipo dedicado se debe
agregar el segmento de red o la(s) IP del servidor de aplicaciones.

Por último, en una instalación con servidor dedicado a base de
datos, es necesario editar el archivo **postgresql.conf** y modificar
el valor de **listen_addresses** con la IP donde el servidor
debe escuchar por conexiones. Normalmente esta línea esta
comentada y PostgreSQL solo escucha en **localhost**.



#### Servidor Oracle Database

Instala Oracle Database de acuerdo a la _Database Installation Guide_
   http://docs.oracle.com/database/121/LADBI/toc.htm



      -- DDL para generar el esquema y usuario. Los datafiles se crearan en el
      -- path default a menos que se indique el path dedicado...
      CREATE TABLESPACE LEXSYS_DAT DATAFILE 'LEXSYS_DATA.DBF' SIZE 200M
        AUTOEXTEND ON NEXT 50M MAXSIZE UNLIMITED LOGGING
        EXTENT MANAGEMENT LOCAL AUTOALLOCATE BLOCKSIZE 8K
        SEGMENT SPACE MANAGEMENT AUTO FLASHBACK ON;

      CREATE TABLESPACE LEXSYS_INX DATAFILE 'LEXSYS_INX.DBF' SIZE 100M
        AUTOEXTEND ON NEXT 50M MAXSIZE UNLIMITED LOGGING
        EXTENT MANAGEMENT LOCAL AUTOALLOCATE BLOCKSIZE 8K
        SEGMENT SPACE MANAGEMENT AUTO FLASHBACK ON;

      CREATE USER <DBUSER> IDENTIFIED BY <DBPASS> DEFAULT TABLESPACE "LEXSYS_DAT"
        QUOTA UNLIMITED ON "LEXSYS_DAT";

      GRANT "CONNECT" TO <DBUSER>;
      GRANT RESOURCE TO <DBUSER>;

      ALTER USER <DBUSER> QUOTA UNLIMITED ON "LEXSYS_INX";

      COMMIT;


#### Servidor MongoDB


Se sugiere utilizar discos SSD en RAID1.


Deshabilita **noatime** en el sistema de archivos donde viven los archivos de
MongoDB.


		LABEL=/var	/var	xfs		noatime,defaults 	0 1


Los límites para proces (**ulimit -u**) y descriptores de archivo
(**ulimit -n**) deben estar configurados con valores superiores a 20,000. Edita `/etc/security/limits.conf`


    *    soft    nproc 65000
    *    hard    nproc 65365
    *    soft    nofile 65000
    *    soft    nofile 65365



Asegurate que la cofiguración de **readahead** para los dispositivos que
almacenan las bases de datos sean valores bajos. 32 (16kb) usualmente funciona
bien.


		blockdev --report
		blockdev --setra 32 /dev/vol-Group-03


Habilita e inicia el servicio MongoDB.

**CentOS/RHEL 6**


    chkconfig rh-mongodb26-mongod on
    service rh-mongodb26-mongod start



**CentOS/RHEL 7**


    systemctl enable rh-mongodb26-mongod
    systemctl start rh-mongodb26-mongod



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


    yum -y install tar gzip gcc gcc-c++ git xz \
      openssl-devel pcre-devel zlib-devel \
      rh-mongodb26 rh-mongodb26-mongodb-server \
      rh-mongodb26-runtime rh-mongodb26-devel \
      python27 python27-python-devel \
      python27-python-pip python27-python-virtualenv sudo
      mongodb mongodb-server mongodb-devel
    easy_install-2.7 -U setuptools pip
    pip2.7 install uwsgi virtualenv
    cd /tmp
    curl -LO https://nodejs.org/dist/v4.2.6/node-v4.2.6-linux-x64.tar.gz
    cd /usr/local
    tar --strip-components=1 -xvzf
      /tmp/node-v4.2.6-linux-x64.tar.gz
    npm install --loglevel info -g pm2 bower gulp grunt-cli coffee-script


##### Dependencias de LexSys en RHEL/CentOS 7


    yum -y install tar gzip gcc gcc-c++ git xz \
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
    db.createUser({ user:"<MONGO_ADMIN>", pwd:"<ADMIN_PASS>",
      roles: ["userAdminAnyDatabase"] });
    use lexeditor
    db.createUser({user:"lexusr",pwd:"<EDITOR_PASS>",
      roles:["readWrite"]});
    use lexsys_log
    db.createUser({user:"lexusr",pwd:"<LOG_PASS>",
      roles:["readWrite"]});
    exit


### Instalación API

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

En el directorio **wrath/config** están los archivos globales de configuración
y los sub-directorios contienen archivos de configuración exclusivos para
cada entorno que se desee ejecutar del API. Es posible ejecutar más de
una instancia del API con el mismo código creando nuevos directorios en
**wrath/config**.


#### Configuración de Carga Masiva


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


#### Configuración de la Base de Datos


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
			        "path": "config/<ambiente>\_catalogs.xlsx",
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


    su - LEXUSR
    cd LEXHOME/EDITOR
    virtualenv ENV
    npm install --loglevel info
    bower install
    vi config.json
    vi LEXHOME/deployment/pm2.json
    grunt assets
    pm2 start LEXHOME/deployment/pm2.json
    pm2 status


#### Configuración Editor de Contenidos

Una copia del código del Editor de Contenidos puede servir 1 o más
instancias escuchando en diferentes puertos TCP. El puerto
predeterminado es 3001, este y otros parámetros se configuran en el
archivo **config.json**.


    {
      "entornos": {
        "<entorno>": {
          "app": {
            "puerto": 3000,
            "ip": "localhost",
            "API_URL": "<https://wrath.url>",
            "privateSubfolder": "<entorno>",
            "pythonPath": "/home/lexusr/EDITOR/ENV/bin/python"
          },
          "DB": {
            "uri": "mongodb://<usuario_mongo>:<password>@<host>[:27017]/base_de_datos"
          }
        }
      }
    }


* **entorno** es una etiqueta que identifica el entorno que se
  iniciará, también debe existir un directorio llamado **entorno** en la
ruta **$LEXEDITOR/views/plantillas**, en este directorio se encuentran
las plantillas HTML que se incluyen a los formatos PDF generados por el
sistema.

* **puerto** PM2 el servidor de aplicaciones JavaScript escucha en este
  puerto.

* **API__URL** URL del API

* **DB uri** Cadena de conexión para MongoDB


#### Configuración PM2

PM2 es el servidor de aplicaciones JavaScript que mueve al Editor de
Contenidos. PM2 es capáz de servir 1 o más instancias del editor se
configura normalmente en el archivo **$LEXHOME/deployment/pm2.json**


    {
      "apps": [
        {
          "name": "<entorno>",
          "cwd": "/home/lexusr/EDITOR",
          "args": [
            "<entorno>"
          ],
          "script": "app.coffee",
          "exec_interpreter": "coffee",
          "out_file": "/home/lexusr/log/pm2-out.log",
          "error_file": "/home/lexusr/log/pm2-error.log"
        }
      ]
    }


### Portal de Servicios

1. Instala los módulos de nodejs y bower
2. Edita `config-<ambiente>.js` de acuerdo a tu ambiente de instalación
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


    yum -y install \
			https://download.lexsys.net/el6/nginx-1.8.0-TIC.1.el6.centos.ngx.x86_64.rpm


**RHEL/CentOS 7**


    yum -y install \
			https://download.lexsys.net/el7/nginx-1.8.0-TIC.1.el7.centos.ngx.x86_64.rpm


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


#### Ejemplo de configuración de Nginx

El siguiente ejemplo muestra una configuración para una instalación
completa del sistema en un solo servidor. Es necesario adecuar esta
configuración en casos donde el proxy HTTP vive en un servidor y el API y
Editor en otros.



    user nginx;
    worker_processes auto;
    error_log /var/log/nginx/error.log;
    pid /var/run/nginx.pid;

    events {
      worker_connections 1024;
    }

    http {
      log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                        '$status $body_bytes_sent "$http_referer" '
                        '"$http_user_agent" "$http_x_forwarded_for"';

      access_log  /var/log/nginx/access.log  main;

      sendfile                  on;
      send_timeout              300s;
      client_body_in_file_only  clean;
      client_body_buffer_size   16K;
      client_max_body_size      300M;

      tcp_nopush          on;
      tcp_nodelay         on;
      keepalive_timeout   90;
      types_hash_max_size 2048;

      include             /etc/nginx/mime.types;
      default_type        application/octet-stream;

      gzip on;
      gzip_disable "msie6";
      gzip_min_length  5;
      gzip_level 6;
      gzip_proxied     expired no-cache no-store private auth;
      gzip_types       text/plain application/xml application/javascript text/css application/x-javascript application/json;

      # Load modular configuration files from the /etc/nginx/conf.d directory.
      # See http://nginx.org/en/docs/ngx_core_module.html#include
      # for more information.
      include /etc/nginx/conf.d/*.conf;

      # WPRIDE
      server {
        listen 80;
        charset utf-8;

        root /home/<lexusr>/wpride/dist-<entorno>;
        index index.html index.htm;

        location / {
          try_files $uri $uri/ /index.html;
        }
      }

      # API
      server {
        listen 3001;
        charset utf-8;

        location / {
          proxy_set_header Host $host;
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

        more_set_headers 'Access-Control-Expose-Headers: Content-disposition';

        if ($request_method = 'OPTIONS') {
          more_set_headers 'Access-Control-Allow-Origin: $http_origin';
          more_set_headers 'Access-Control-Allow-Methods: GET, POST, OPTIONS, PATCH, PUT, DELETE';
          more_set_headers 'Access-Control-Allow-Credentials: true';
          more_set_headers 'Access-Control-Allow-Headers: Authorization,Content-Type,Accept,Origin,User-Agent,DNT,Cache-Control,X-Mx-ReqToken,Keep-Alive,X-Requested-With,If-Modified-Since,Timestamp';

          add_header Content-Length 0;
          add_header Content-Type text/plain;
          return 204;
        }

        more_set_headers 'Access-Control-Allow-Origin: $http_origin';
        more_set_headers 'Access-Control-Allow-Credentials: true';
        more_set_headers 'Access-Control-Expose-Headers: Content-Disposition';

        proxy_buffers 40 8k;
        proxy_read_timeout 90s;
          proxy_pass http://127.0.0.1:3000;
        }
      }

      # EDITOR
      server {
        listen 3002;
        charset utf-8;

        location /public {
          alias /home/<lexusr>/EDITOR/public;
        }
        # Redirect to Node.js server
        location / {
          proxy_pass http://127.0.0.1:3003;
        }
      }

      # PS
      server {
        listen 3004;
        charset utf-8;

        root /home/<lexusr>/sloth/dist-<entorno>;
        index pages/login.html pages/login.htm;

        location / {
          try_files $uri $uri/ /login.html;
        }
      }

    }



### Instalacion distribuida


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
            "app_key": "<APP_KEY>",
            "approved_ip": "<IP_AUTORIZADA>",
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
            "api_url": "http://<API_URL>",
            "app_key": "<APP_KEY>",
            "app_secret": "<APP_SECRET>"
          }
        },
        "api_xyz": {
          "local": {
            "app_key": "<APP_KEY>",
            "approved_ip": "<IP_AUTORIZADA>",
            "operators":[
              "XYZ.DP",
              "XYZ.AJ"
            ]
          },
          "remote":{
            "api_url": "http://<API_URL>",
            "app_key": "<APP_KEY>",
            "app_secret": "<APP_SECRET>"
          }
        }
      }
    }


#### Ejecución de eventos programada

La ejecución de eventos programada se utiliza solo en casos de
instalaciones distribuidas, este mecanismo transfiere los casos entre
las instancias del API participantes.


    crontab -e
    * * * * * /usr/bin/curl -X POST http://<apiurl>/time_events \
      --header "Content-Type:application/json" --data "{}" \
      >> /var/log/lexsys/pooling.log 2>&1


### Seguridad


#### HTTPS


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


##### Configuración de Nginx


    mkdir /etc/nginx/ssl
    cd /etc/nginx/ssl
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout \
      /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt


Ejemplo de configuración HTTPS en Nginx.


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


### Respaldos


#### Respaldo de Bases de Datos

##### Volcado de Oracle Database

Nombre del directorio en la DB (debe existir el path físico con permisos de
lectura/escritura a nivel OS para el owner de la DB), permisos de
lectura/escritura sobre el directorio a nivel DB para el usuario owner del
schema.
El nombre del directorio deberá ser adecuado al path a utilizer para actividades
de export/import.


    grant READ, WRITE on DIRECTORY DATA_PUMP_DIR to LEXUSR;
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


Parametro JOB_QUEUE_PROCESSES configurado en al menos 5


    show parameter JOB_QUEUE_PROCESSES


Ejecuta `expdp` para crear el volcado del esquema de base de datos.


	expdp <DBUSER>/<DBPASS>@<DBHOST>/<SID> DIRECTORY=DATA_PUMP_DIR \
    FILE=$ORACLE_SID-`date +%F-%H-%M`.dmp


##### Importar volcado de Oracle Database


    impdp <DBUSER>/<DBPASS>@<DBHOST>/<SID> \
			schemas=<LEXDB> directory=<DATA_PUMP_DIR> \
			dumpfile=<dumpfileLEXUSR.dmp> logfile=<impdp_dumpfileLEXUSR.log>


Si los schemas y tablespaces difieren entre origen y destino, es necesario
emplear **remap_schema** y **remap_tablespace**


	impdp SYSTEM/<PASSWORD>@<DBHOST>/<SID> schemas=LEXUSR directory=DATA_PUMP_DIR \
    dumpfile=dumpfileLEXUSR.dmp logfile=impdp_dumpfileLEXUSR.log \
    REMAP_TABLESPACE=source_tablespace:target_tablespace \
    REMAP_TABLESPACE=source_tablespace:target_tablespace \
    remap_schema=source_schema:target_schema


##### Volcado de PostgreSQL

Para hacer un respaldo binario y comprimido de la base de datos ejecuta


    pg_dump -h <host> -U <usuario> -W -Fc <base_de_datos> > <respaldo.bak>


##### Importar volcado de PostgreSQL

Para restaurar el respaldo creado con `pg_dump`


    pg_restore -d <base_de_datos> <respaldo.bak>


##### Volcado de MongoDB

Para respaldar la base de datos mongoDB se ejecuta `mongodump` con el
nombre de la base de datos y el directorio destino para el respaldo.

    mongodump -h <host> -u <usuario> -p <password> \
      --db <base_de_datos> --out <ruta_respaldo>


##### Importar volcado de MongoDB

Los respaldos de mongoDB generados con `mongodump` se pueden
restaurar en otra instanacia de mongoDB o en una base de datos
diferente ejecutando el comando `mongorestore` que toma parametros de
base de datos donde restaurar las colecciones de documentos en el
respaldo y la ruta donde se encuentra el respaldo.

    mongorestore --host <host> --username <usuario> --pawwsord <password> \
      --db <base_de_datos> <ruta_respaldo>


### Referencias

* [HTTP sobre TLS](https://tools.ietf.org/html/rfc2818)
* [TLS 1.2](https://tools.ietf.org/html/rfc5246)
* [SHA-1 Hash Algorithm Migration for SSL & Code Signing Certificates](http://www.symantec.com/page.jsp?id=sha2-transition)
* https://access.redhat.com/documentation/en-US/Red_Hat_Software_Collections/2/html/2.0_Release_Notes/chap-RHSCL.html
* https://docs.mongodb.com/manual/release-notes/2.6/

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
