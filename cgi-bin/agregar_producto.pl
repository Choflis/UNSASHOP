#!"C:\xampp\perl\bin\perl.exe"
use strict;
use warnings;
use CGI;
use CGI::Session;
use CGI::Cookie;
use DBI;
use DateTime;

my $cgi = CGI->new;
$cgi->charset("UTF-8");

my $session_cookie = $cgi->cookie("id_session") || '';
my $session = CGI::Session->new(undef, $session_cookie, {Directory => '/tmp'});

my $user_id = $session->param("session_id");
my $user_type = $session->param("session_type");

my $nombreP = $cgi->param("name_AP");
my $precioP = $cgi->param("precio_AP");
my $imagenP = $cgi->param("url_AP");
my $stock   = $cgi->param("stock_AP");

my $db_user = "unsashop";
my $db_password = "c!YxWLaRyvODyTWr";
my $dsn = "dbi:mysql:database=unsashop;host=127.0.0.1";
my $dbh = DBI->connect($dsn, $db_user, $db_password);

my %errors;

validate_data();

sub validate_data {
    if () {

    }

    #name que no pase del tamaño permitido
    #precio positivo y en numeros
    #url que tenga la forma de una con una expresion regular
    #stock,1 a mas

    #para cuando agregue un producto con el nombre ya existente, entonces se le agregue el numero
    #de stock
}

if () {
    
}

agregarP();

sub agregarP {
    if (%errors == 0) {
        
        my $sth = $dbh->prepare("INTERT INTO producto (`vendedor_id`, `nombre`, `imagen`, `precio`, `stock`) VALUES ('$session_id', '$nombreP', '$precioP', '$imagenP', '$stock')");
        $sth->execute;

        print $cgi->redirect("http://localhost/UNSASHOP/index.html");
        return;
    }
    print_errors();
}