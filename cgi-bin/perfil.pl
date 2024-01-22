#!"C:\xampp\perl\bin\perl.exe"
use strict;
use warnings;
use DBI;
use JSON;

my $db_user = "unsashop";
my $db_password = "c!YxWLaRyvODyTWr";
my $dsn = "dbi:mysql:database=unsashop;host=127.0.0.1";
my $dbh = DBI->connect($dsn, $db_user, $db_password);

my $query = "SELECT nombreC, dni, celular, tipo_usuario, nombre_usuario, correo, tarjeta_id FROM usuario WHERE ID = 1";
my $sth = $dbh->prepare($query);
$sth->execute();

my @datosUsuario = $sth->fetchrow_array;

print "Content-type: application/json\n\n";

my $json_data = encode_json(\@datosUsuario);
print $json_data;

$dbh->disconnect();