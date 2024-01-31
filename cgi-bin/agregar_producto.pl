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

my $db_user = "unsashop";
my $db_password = "c!YxWLaRyvODyTWr";
my $dsn = "dbi:mysql:database=unsashop;host=127.0.0.1";
my $dbh = DBI->connect($dsn, $db_user, $db_password);

#AGREGAR VERIFICACION DE DATOS CORRECTOS

my %errors;

if () {
    
}

agregarP();

sub agregarP {
    if (%errors == 0) {
        
        my $sth = $dbh->prepare("INTERT INTO producto (`vendedor_id`, `nombre`, `imagen`, `precio`) VALUES ('$session_id', '$nombreP', '$precioP', '$imagenP')");
        $sth->execute;

        print $cgi->redirect("http://localhost/UNSASHOP/index.html");
        return;
    }
    print_errors();
}