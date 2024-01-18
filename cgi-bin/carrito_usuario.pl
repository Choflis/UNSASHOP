#!perl/bin/perl.exe

# Recibe: id, action (check [revisa todos los productos], add [añade un producto], remove [remueve un producto])
#    check => nada
#    add => id
#    remove => id
# Retorna:
#    check => <products> <product> <name>nombre</name> <description>descripcion</description> <image>imagen</image> <price>precio</price> </product> </products>
# Check se deberia llamar al cargar la pagina para mostrar todas las tiendas

use strict;
use warnings;
use CGI;
use CGI::Session;
use CGI::Cookie;
use DBI;

my $cgi = CGI->new;
$cgi->charset("UTF-8");
my $product_id = $cgi->param("id");

my %cookies = CGI::Cookie->fetch();
my $session_cookie = $cookies{"id_session_cliente"};

my $db_user = "unsashop";
my $db_password = "c!YxWLaRyvODyTWr";
my $dsn = "dbi:mysql:database=unsashop;host=127.0.0.1";
my $dbh = DBI->connect($dsn, $db_user, $db_password);


if ($session_cookie) {
    my $session_id = $session_cookie->value();
    my $session = CGI::Session->load($session_id);
    my $buyer_id = $session->param("session_id");

    my $sth = $dbh->prepare("INSERT INTO carrito (usuario_id, producto_id) VALUES ($buyer_id, $product_id)");
    $sth->execute();
    print($cgi->header("text/xml"));
}
