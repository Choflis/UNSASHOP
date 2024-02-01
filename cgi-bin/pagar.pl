#!"C:\xampp\perl\bin\perl.exe"
use strict;
use warnings;
use CGI;
use CGI::Session;
use DBI;
use JSON;

my $cgi = CGI->new;
$cgi->charset("UTF-8");

my $session_cookie = $cgi->cookie("id_session") || '';
my $session = CGI::Session->new(undef, $session_cookie, {Directory => '/tmp'});

my $user_id = $session->param("session_id");

my $json_input = $cgi->param('POSTDATA') || '';
my $input_data = decode_json($json_input);

my $productos = $input_data->{productos} || {};

my $db_user = "unsashop";
my $db_password = "c!YxWLaRyvODyTWr";
my $dsn = "dbi:mysql:database=unsashop;host=127.0.0.1";
my $dbh = DBI->connect($dsn, $db_user, $db_password, {RaiseError => 1, PrintError => 1})
  or die "Error de conexión: $DBI::errstr";

my $costo_total = 0;

foreach my $idP (keys %productos) {
    my $id       = $producto->{idP};
    my $cantidad = $producto->{cantidad};

    #hallando precio
    my $query_precio = "SELECT precio FROM producto WHERE id = ?";
    my $sth_precio   = $dbh->prepare($query_precio);
    $sth_precio->execute($id);
    my ($precio) = $sth_precio->fetchrow_array;

    #calculando aporte del producto
    $costo_total_producto += $precio * $cantidad;
    $costo_total += $costo_total_producto;
    #AGREGANDOS saldo a vendedor
    #obtener id vendedor
    my $query_vendedor_id = "SELECT vendedor_id FROM tarjeta WHERE id = ?";
    my $sth_vendedor_id = $dbh->prepare($query_vendedor_id);
    $sth_vendedor_id->execute($id);
    my ($id_vendedor) = $sth_vendedor_id->fetchrow_array;
    #obtener tarjeta vendedor
    my $tarjeta_vendedor = "SELECT tarjeta_id FROM vendedor WHERE ID = ?";
    my $sth_tarjeta_idV = $dbh->prepare($tarjeta_vendedor);
    $sth_tarjeta_idV->execute($id_vendedor);
    my ($tarjeta_idV) = $sth_tarjeta_idV->fetchrow_array;
    #consultando saldo de la tarjeta
    my $query_saldoV = "SELECT saldo FROM tarjeta WHERE id = ?";
    my $sth_saldoV = $dbh->prepare($query_saldoV);
    $sth_saldoV->execute($tarjeta_idV);
    my ($saldo_actualV) = $sth_saldoV->fetchrow_array;
    my $saldofinalP = $saldo_actualV + $costo_total_producto;
    #agregar credito a la tarjeta
    my $nuevo_saldo_vendedor = $saldo_vendedor + $aporte_producto;
    my $query_update_saldo_vendedor = "UPDATE tarjeta SET saldo = ? WHERE id = ?"; 
    my $sth_update_saldo_vendedor   = $dbh->prepare($query_update_saldo_vendedor);
    $sth_update_saldo_vendedor->execute($saldofinalP, $id_vendedor);
}

#RESTANDO SALDO DE USUARIO
my $query_tarjeta_id = "SELECT tarjeta_id FROM usuario WHERE ID = ?";
my $sth_tarjeta_id = $dbh->prepare($query_tarjeta_id);
$sth_tarjeta_id->execute($user_id);

my ($tarjeta_id) = $sth_tarjeta_id->fetchrow_array;

my $query_saldo = "SELECT saldo FROM tarjeta WHERE id = ?";
my $sth_saldo = $dbh->prepare($query_saldo);
$sth_saldo->execute($tarjeta_id);

my ($saldo_actual) = $sth_saldo->fetchrow_array;
my $saldo_final = $saldo_actual - $costo_total;

my $query_update_saldo = "UPDATE tarjeta SET saldo = ? WHERE id = ?";
my $sth_update_saldo   = $dbh->prepare($query_update_saldo);
$sth_update_saldo->execute($saldo_final, $tarjeta_id);

#print STDERR "Content-Type: application/json\n\n";
print $cgi->header("application/json");

$saldo_final = sprintf("%.2f", $saldo_final);
my $json_data = encode_json({ saldoF => $saldo_final });
print $json_data;

$dbh->disconnect();
#a