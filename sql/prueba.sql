--
-- Ejemplo de insersión de datos de `tarjeta` y `usuario`
--


-- TARJETAS:
INSERT INTO tarjeta (id, numero, caducidad, codigo, saldo)
VALUES (1, '1234-5678-9012-3456', '2024-12-31', 123, 1000);

INSERT INTO tarjeta (id, numero, caducidad, codigo, saldo)
VALUES (2, '9876-5432-1098-7654', '2024-12-30', 321, 10000);



-- USUARIOS:
INSERT INTO usuario (login_usuario, login_clave, nombreC, dni, celular, tipo_usuario, nombre_usuario, correo, tarjeta_id)
VALUES (
  'HernanCZU',
  '123456789',
  'Hernan Andy Choquehuanca Zapana',
  71647797,
  987654321,
  'usuario',
  'HernanCZ',
  'hchoquehuancaz@unsa.edu.pe',
  (SELECT id FROM tarjeta WHERE numero = '1234-5678-9012-3456')
);


-- VENDEDORES:

INSERT INTO vendedor (login_usuario, login_clave, nombreC, dni, celular, tipo_usuario, nombre_usuario, correo, tarjeta_id)
VALUES (
  'HernanCZV',
  '123456789',
  'Hernan Andy Choquehuanca Zapana',
  71647797,
  987654321,
  'vendedor',
  'HernanCZ',
  'hchoquehuancaz@unsa.edu.pe',
  (SELECT id FROM tarjeta WHERE numero = '9876-5432-1098-7654')
);