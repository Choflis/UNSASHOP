#!"C:\xampp\perl\bin\perl.exe"
use strict;
use warnings;
use CGI;
use CGI::Session;
use CGI::Cookie;
use DBI;

my $cgi = CGI->new;
$cgi->charset("UTF-8");
my $email = $cgi->param("email");
my $password = $cgi->param("password");
my $type = $cgi->param("type");
my $session_time = 86400;

my $db_email = "unsashop";
my $db_password = "c!YxWLaRyvODyTWr";
my $dsn = "dbi:mysql:database=unsashop;host=127.0.0.1";
my $dbh = DBI->connect($dsn, $db_email, $db_password);

my %errors;

if (!$email || length($email) == 0 || length($email) > 30) {
    $errors{email} = "Email inválido.";
}

if (!$password || length($password) == 0 || length($password) > 30) {
    $errors{password} = "Clave inválida.";
}

if (!$type || ($type ne "usuario" && $type ne "vendedor")) {
    $errors{type} = "Tipo inválido.";
}

login();

sub login {
    if (%errors == 0) {
        my $sth = $dbh->prepare("SELECT `id`, `nombre` FROM $type WHERE login_usuario = ? AND login_clave = ?");
        $sth->execute($email, $password);

        my @email_row = $sth->fetchrow_array;
        if (@email_row) {
            my $session = CGI::Session->new();
            $session->param("session_id", $email_row[0]);
            $session->param("session_name", $email_row[1]);
            $session->expire(time + $session_time);
            $session->flush();

            my $cookie = $cgi->cookie(
                -name    => "id_session_$type",
                -value   => $session->id(),
                -expires => time + $session_time,
                -max-age => $session_time,
                -secure  => 1,      # Solo enviar la cookie sobre HTTPS
                -httponly => 1,     # Accesible solo a través de HTTP
            );

            print $cgi->header("text/xml", -cookie => $cookie);
            return;
        }
        $errors{login} = "El usuario y la clave no coinciden.";
    }
    print $cgi->header("text/xml");
    print_errors();
}

sub print_errors {
    print "<errors>\n";
    for my $key (keys %errors) {
        print<<XML;
        <error>
            <element>$key</element>
            <message>$errors{$key}</message>
        </error>
XML
    }
    print "</errors>\n";
}
