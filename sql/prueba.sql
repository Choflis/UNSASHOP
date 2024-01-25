--
-- Ejemplo de insersión de datos de `tarjeta` y `usuario`
--


-- TARJETAS:
INSERT INTO tarjeta (numero, caducidad, codigo, saldo)
VALUES ('1234-5678-9012-3456', '2024-12-31', 123, 1000);

INSERT INTO tarjeta (numero, caducidad, codigo, saldo)
VALUES ('9876-5432-1098-7654', '2024-12-30', 321, 10000);



-- USUARIOS:
INSERT INTO usuario (login_usuario, login_clave, nombreC, dni, celular, tipo_usuario, nombre_usuario, correo, tarjeta_id, pregunta1, pregunta2)
VALUES (
  'HernanCZU',
  '123456789',
  'Hernan Andy Choquehuanca Zapana',
  71647797,
  987654321,
  'usuario',
  'HernanCZ',
  'hchoquehuancaz@unsa.edu.pe',
  (SELECT id FROM tarjeta WHERE numero = '1234-5678-9012-3456'),
  'lia',
  'sol'
);


-- VENDEDORES:

INSERT INTO vendedor (login_usuario, login_clave, nombreC, dni, celular, tipo_usuario, nombre_usuario, correo, tarjeta_id, pregunta1, pregunta2)
VALUES (
  'HernanCZV',
  '123456789',
  'Hernan Andy Choquehuanca Zapana',
  71647797,
  987654321,
  'vendedor',
  'HernanCZ',
  'hchoquehuancaz@unsa.edu.pe',
  (SELECT id FROM tarjeta WHERE numero = '9876-5432-1098-7654'),
  'lia',
  'sol'
);