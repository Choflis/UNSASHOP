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

my $totalD = $input_data->{total}; 

unless ($totalD =~ /^\d+(\.\d+)?$/) {
    print $cgi->header("application/json");
    my $json_data = encode_json({ error => "Total no válido" });
    print $json_data;
    exit;
}

my $db_user = "unsashop";
my $db_password = "c!YxWLaRyvODyTWr";
my $dsn = "dbi:mysql:database=unsashop;host=127.0.0.1";
my $dbh = DBI->connect($dsn, $db_user, $db_password, {RaiseError => 1, PrintError => 1})
  or die "Error de conexión: $DBI::errstr";

my $query_tarjeta_id = "SELECT tarjeta_id FROM usuario WHERE ID = ?";
my $sth_tarjeta_id = $dbh->prepare($query_tarjeta_id);
$sth_tarjeta_id->execute($user_id);

my ($tarjeta_id) = $sth_tarjeta_id->fetchrow_array;

my $query_saldo = "SELECT saldo FROM tarjeta WHERE id = ?";
my $sth_saldo = $dbh->prepare($query_saldo);
$sth_saldo->execute($tarjeta_id);

my ($saldo_actual) = $sth_saldo->fetchrow_array;
my $saldo_final = $saldo_actual - $totalD;

my $query_update_saldo = "UPDATE tarjeta SET saldo = ? WHERE id = ?";
my $sth_update_saldo   = $dbh->prepare($query_update_saldo);
$sth_update_saldo->execute($saldo_final, $tarjeta_id);

#print STDERR "Content-Type: application/json\n\n";
print $cgi->header("application/json");

$saldo_final = sprintf("%.2f", $saldo_final);
my $json_data = encode_json({ saldoF => $saldo_final });
print $json_data;

$dbh->disconnect();