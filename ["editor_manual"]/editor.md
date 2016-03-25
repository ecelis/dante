# LEXSYS EDITOR (modificación, borrado, creación de documentos)
------------------------------------------

## INTRODUCCIÓN

La plataforma LEXSYS EDITOR es la herramienta que permite al administrador técnico del sistema modificar, borrar y crear los distintos procedimientos y formatos que se encuentran dentro del Escritorio de Trabajo para el uso de los usuarios finales. Desarrollado en un ambiente gráfico de fácil manejo, mismo que refleja los cambios realizados en tiempo real. 
 
USUARIO: El usuario administrador del sistema deberá poner el nombre que se le asignó para ingresar a LEXSYS EDITOR con el fin de realizar los cambios que se requieran.

CONTRASEÑA: El usuario ingresará la contraseña asignada o seleccionada según sea el caso.
 
INICIO: Regresa a los usuarios a la pantalla de inicio, en la que se visualizan todos los procedimientos que integran el sistema
Nombre del usuario (cuando copies la imagen se ve mi nombre, no pude agruparle una forma para taparlo,  ten cuidado de no dejar mi nombre)
SALIR: Cierra sesión del usuario.

TODOS: Muestra la lista de todos los procedimientos que se encuentran dentro del sistema. Cuenta con la función de visualizar los procedimientos por proceso, mostrando el nombre del mismo

HERRAMIENTAS: son herramientas que se utilizan para el desarrollo del sistema.

SELECCIONAR TODO: selecciona todos los procedimientos y formatos que se encuentran cargados en el sistema.

SELECCIONAR PROCESO SELECCIONADO: Solo selecciona el proceso y formatos que se visualizan en la pantalla en ese momento.

SELECCIONAR NADA: Quita la selección de los procedimientos o formatos seleccionados.

VER: Esta función permite ver las pantallas o procedimientos con los códigos que se deberán replicar en el formato para que se hereden los campos en el ET.
VER: Permite ver los formatos con los códigos que se obtuvieron de la pantalla en el lugar que deben colocarse. 

Los códigos comienzan con los primeros 3 dígitos de cada procedimiento o los 4 primeros de los subprocedimientos más un número consecutivo que el sistema arroja automáticamente seguido del nombre que se le asigna al campo.

Los códigos que aparecen en pantalla deben ser replicados en formatos para que se visualicen en el ET al momento en el que el usuario llena el campo.

EDITAR: Esta opción nos permite eliminar, crear, mover o modificar los campos que aparecen en la pantalla.

EDITAR: Permite modificar o eliminar códigos o texto de los formatos que se tienen en el sistema clasificados por procedimientos.


Se observará el nombre del procedimiento al que fue asignada esta pantalla junto con los códigos ya existentes en la misma.

Es importante señalar que para que un código se refleje en los formatos, debe de estar colocado con anterioridad en esta pantalla: 

VER CÓDIGOS: Permite observar los códigos que se deben de replicar en el formato seleccionado.

VISTA PRELIMINAR: Permite visualizar como quedará la pantalla sin los recuadros grises.

DESCARGAR: Descarga un archivo en json de la pantalla.

Vista de pantalla con códigos
 

Vista de pantalla con vista preliminar
 

Elemento de edición de pantalla
 

Sirve para eliminar toda una fila.
Permite incluir una nueva fila.
Mensaje que aparece al seleccionar la opción de eliminar fila

 
Todas las pantallas están divididas en secciones por formato.
Permite mover el campo a diferentes recuadros de la pantalla.
Despliega una ventana de opciones para la edición de los campos.
Permite borrar campo sin eliminar los demás de la fila.
 

 
Al seleccionar Serie en la lista de tipo, da la opción de incluir un folio consecutivo y automático para los formatos del sistema.
Se deberá de asignar un nombre al campo de manera obligatoria.
Indica el número de columnas que ocupara el campo, el máximo son 3.
Para guardar el cambio se debe de dar en aceptar y este se reflejará en pantalla.

## SECCIÓN
------------------

Esta opción se utiliza para crear un campo de texto a manera de título en la pantalla, lo cual nos perite seccionar la pantalla para que los usuarios llenen la parte correspondiente del formato o formatos que requieran.
 




## HEREDADO
---------------

Hay información que fue capturada en pantallas previas que se utiliza a lo largo del procedimiento; por medio de esta opción podemos incluir esta información, seleccionando el procedimiento del que se deberá de llamar.
 

Desplegará una lista en donde se deberá de elegir el campo que se quiere heredar .
 
CONSTANCIA
Esta opción inserta un campo alfanumérico de mayor tamaño para que el usuario visualice con mayor facilidad el texto capturado en el mismo.
 
NUMÉRICO
Esta opción solo permite que el usuario capture dígitos numérico.
 
ALFANUMÉRICO
Esta opción permite que el usuario capture números y letras dentro de este campo.
 
SI/NO
Es un campo de decisión que permite al usuarios poner un indicador si la aseveración es verdadera.
 
OPCIONES INCLUYENTES
Permite ingresar una lista de opciones en las que el usuario puede elegir mas de una opción de la lista, mostrando todas las que se capturaron; las opciones se deberán de ingresar en el campo Opciones/Columna.
 
OPCIONES EXCLUYENTES
Permite ingresar una lista de opciones en las que el usuario solo puede elegir una opción de la lista, mostrando todas las que se capturaron; las opciones se deberán de ingresar en el campo Opciones/Columna.
 
LISTA
Permite ingresar una lista de opciones en las que el usuario solo puede elegir una opción de la lista, mostrando solamente la seleccionada; las opciones se deberán de ingresar en el campo Opciones/Columna.
 
HORA
Esta opción permite capturar un campo que se reflejará en formato de hora
 
FECHA
Esta opción permite capturar un campo que se reflejará en formato de fecha
 
TABLA
Permite insertar filas y columnas configurables según las necesidades del formato 
 
EDICIÓN DE FORMATOS
La edición de formatos cuenta con funciones de edición de texto tales como negritas, cursiva, subrayado, alineación a la derecha, centrado, alineación a la izquierda, justificado, eliminar estilos, minúsculas, mayúsculas, inserción de tabla, etc.   
Los formatos se pueden copiar desde un Word y pegar en la plantilla del formato dentro del sistema, solo se verá el texto plano, se deberá de editar dentro del sistema.
 
CREACIÓN DE NUEVO PROCEDIMIENTO 
Para la creación de un nuevo procedimiento se deberá de seleccionar la opción de Nuevo procedimiento y nos desplegará una venta en la que se deberá de ingresar el código asignado dependiendo del proceso al que pertenezca y el nombre del procedimiento.   
 
 
A continuación el procedimiento creado en editor se deberá de dar de alta en el Excel de gestión en la pestaña de formatos asignándole el operador al que pertenece, en la pestaña de roles_proced, al igual que en el Excel de estructuras.   
 
 
ACTUALIZAR LAS IMÁGENES
CRECIÓN DE UN NUEVO FORMATO
Para realizar la creación de un nuevo formato, se deberá elegir la opción de Nuevo formato, la cual desplegara una venta en la que debemos poner el código del nuevo formato a crear, este debe de ser diferente a los que ya se tienen creados y deberá de ser un número de 5 caracteres también se seleccionará la plantilla que se  asignará.
 
Se deberá de dar de alta en el Excel de Gestión en la pestaña de formatos.   
 
