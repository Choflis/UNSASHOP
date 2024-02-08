#!"C:\xampp\perl\bin\perl.exe"
use strict;
use warnings;
use CGI;
use CGI::Session;
use CGI::Cookie;
use DBI;
use JSON;

my $cgi = CGI->new;
$cgi->charset("UTF-8");
print $cgi->header('application/json');
my $json_data = $cgi->param('POSTDATA');

my $producto = decode_json($json_input);

my $nombreP = $producto->{'nombre'};
my $precioP = $producto->{'precio'};
my $imagenP = $producto->{'imagen'};
my $stockP   = $producto->{'stock'};

my $session_cookie = $cgi->cookie("id_session") || '';
my $session = CGI::Session->new(undef, $session_cookie, {Directory => '/tmp'});

my $user_id = $session->param("session_id");
my $user_type = $session->param("session_type");

my %errors;

my $db_user = "unsashop";
my $db_password = "c!YxWLaRyvODyTWr";
my $dsn = "dbi:mysql:database=unsashop;host=127.0.0.1";
my $dbh = DBI->connect($dsn, $db_user, $db_password);

validate_data();

sub validate_data {
    if (!$nombreP || length($nombreP) == 0 || length($nombreP) > 30) {
        $errors{nombre} = "Ingrese un nombre válido.";
    }

    if ($precioP =~ /^\d+$/ && ($precioP > 100 || $precioP < 0)) {
        $errors{precio} = "Ingrese un precio válido.";
    }

    if (!$imagenP || length($imagenP) == 0 || length($imagenP) > 30 || $imagenP !~ /^(?:https?|ftp):\/\/\S+$/i) {
        $errors{imagen} = "Ingrese una imagen válida.";
    }
    
    if ($stockP !~ /^\d+$/ || $stockP > 1000 || $stockP <= 0) {
        $errors{stock} = "Ingrese un stock válido.";
    }

    #VERIFICAR QUE EL PRODCUTO NO EXISTA YA - NOMBRE
    my $sth_n = $dbh->prepare("SELECT COUNT(*) FROM producto WHERE nombre = ?");
    $sth_n->execute($nombreP);
    my $countN = $sth_n->fetchrow_array();

    if ($countN > 0) {
    $errors{nombre} = "Ya existe un producto con el mismo nombre.";
    }

    #VERIFICAR QUE EL PRODCUTO NO EXISTA YA - IMAGEN
    my $sth_i = $dbh->prepare("SELECT COUNT(*) FROM producto WHERE imagen = ?");
    $sth_i->execute($imagenP);
    my $countI = $sth_i->fetchrow_array();

    if ($countI > 0) {
    $errors{imagen} = "Ya existe un producto con el mismo nombre.";
    }
}

if (%errors == 0){
    my $sth = $dbh->prepare("INSERT INTO producto (`vendedor_id`, `nombre`, `imagen`, `precio`, `stock`) VALUES (?, ?, ?, ?, ?)");
    $sth->execute($user_id, $nombreP, $imagenP, $precioP, $stockP);

    print $cgi->redirect("http://localhost/UNSASHOP/perfilV.html");
    
} else {
    print $cgi->redirect("http://localhost/UNSASHOP/perfilV.html");
}