#!perl/bin/perl.exe
use strict;
use warnings;
use DBI;

# Configuración de la base de datos (ajusta según tu configuración)
my $db_name = 'nombre_de_la_base_de_datos';
my $db_user = 'nombre_de_usuario';
my $db_pass = 'contraseña';
my $db_host = 'nombre_del_servidor';

# Establecer la conexión a la base de datos
my $dbh = DBI->connect("DBI:mysql:$db_name:$db_host", $db_user, $db_pass, {RaiseError => 1});

# Realizar la consulta para obtener los datos del usuario (ajusta según tu estructura de base de datos)
my $query = "SELECT nombreC, dni, celular, tipo_usuario, nombre_usuario, correo, id_tarjeta FROM usuarios WHERE id_usuario = 1";
my $sth = $dbh->prepare($query);
$sth->execute();

# Obtener el resultado de la consulta
my @datosUsuario = $sth->fetchrow_array;

# Imprimir los datos separados por comas
print join(',', @datosUsuario);

# Cerrar la conexión a la base de datos
$dbh->disconnect();
