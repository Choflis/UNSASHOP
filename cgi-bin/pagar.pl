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

my $query_credito = "SELECT credito FROM usuario WHERE id = ?";
my $sth_credito = $dbh->prepare($query_credito);
$sth_credito->execute($user_id);

my ($credito_actual) = $sth_credito->fetchrow_array;
my $credito_final = $credito_actual - $totalD;

my $query_update_credito = "UPDATE usuario SET credito = ? WHERE id = ?";
my $sth_update_credito   = $dbh->prepare($query_update_credito);
$sth_update_credito->execute($credito_final, $user_id);

#print STDERR "Content-Type: application/json\n\n";
print $cgi->header("application/json");

$credito_final = sprintf("%.2f", $credito_final);
my $json_data = encode_json({ creditoF => $credito_final });
print $json_data;

$dbh->disconnect();