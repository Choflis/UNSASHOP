#!"C:\xampp\perl\bin\perl.exe"
use strict;
use warnings;
use DBI;
use JSON;

my $db_user = "unsashop";
my $db_password = "c!YxWLaRyvODyTWr";
my $dsn = "dbi:mysql:database=unsashop;host=127.0.0.1";
my $dbh = DBI->connect($dsn, $db_user, $db_password);
my $query = "SELECT nombreC, dni, celular, tipo_usuario, nombre_usuario, correo, tarjeta.numero FROM usuario JOIN tarjeta ON usuario.tarjeta_id = tarjeta.id WHERE usuario.ID = 1";
my $sth = $dbh->prepare($query);
$sth->execute();

my @datosUsuario = $sth->fetchrow_array;
$datosUsuario[6] =~ s/(\d{4})(?=\d{4})/$1-/g; 
print "Content-type: application/json\n\n";

my $json_data = encode_json(\@datosUsuario);
print $json_data;

$dbh->disconnect();