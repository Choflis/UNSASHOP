#!"C:\xampp\perl\bin\perl.exe"
use strict;
use warnings;
use CGI;
use JSON;
use Email::Sender::Simple qw(sendmail);
use Email::Simple;
use Email::Sender::Transport::SMTP;

my $cgi = CGI->new;

# Obtener el correo electrónico del formulario
my $email = $cgi->param('email');

# Validar el correo electrónico (puedes agregar más validaciones)
unless ($email && $email =~ /\S+@\S+\.\S+/) {
    print header(-type => "application/json");
    print encode_json({ success => 0, message => "Correo electrónico no válido." });
    exit;
}

# Generar un token único (puedes usar un módulo como Data::UUID)
my $token = generate_unique_token();

# Guardar el token en la base de datos junto con la fecha de creación y el correo electrónico del usuario

# Enviar un correo electrónico con un enlace que incluye el token
my $message = Email::Simple->create(
    header => [
        To      => $email,
        From    => 'tu_correo@dominio.com',
        Subject => 'Recuperación de Contraseña',
    ],
    body => "Haz clic en el siguiente enlace para recuperar tu contraseña: http://tu_sitio.com/resetear_contraseña.html?token=$token",
);

my $transport = Email::Sender::Transport::SMTP->new({
    host => 'smtp.tu_servidor_smtp.com',
});

eval { sendmail($message, { transport => $transport }); };

# Verificar si el correo electrónico se envió con éxito
if ($@) {
    print header(-type => "application/json");
    print encode_json({ success => 0, message => "Error al enviar el correo electrónico." });
} else {
    print header(-type => "application/json");
    print encode_json({ success => 1, message => "Correo electrónico enviado con éxito." });
}
