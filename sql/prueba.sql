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

-- PRODUCTO:

INSERT INTO producto (vendedor_id, nombre, imagen, precio)
VALUES (
    (SELECT id FROM vendedor WHERE login_usuario = 'HernanCZV'),
    'Pepsi 500 mL',
    'https://github.com/Choflis/UNSASHOP/blob/main/img/pepsi.jpg?raw=true',
    'https://github.com/Choflis/UNSASHOP/blob/main/img/pepsi.jpg?raw=true',
    2.40
);

INSERT INTO producto (vendedor_id, nombre, imagen, precio)
VALUES (
    (SELECT id FROM vendedor WHERE login_usuario = 'HernanCZV'),
    'Coca Cola 500ml',
    'https://github.com/Choflis/UNSASHOP/blob/main/img/cocacola.jpg?raw=true',
    'https://github.com/Choflis/UNSASHOP/blob/main/img/cocacola.jpg?raw=true',
    2.90
);

INSERT INTO producto (vendedor_id, nombre, imagen, precio)
VALUES (
    (SELECT id FROM vendedor WHERE login_usuario = 'HernanCZV'),
    'Sprite 500ml',
    'https://github.com/Choflis/UNSASHOP/blob/main/img/sprite.jpg?raw=true',
    'https://github.com/Choflis/UNSASHOP/blob/main/img/sprite.jpg?raw=true',
    2.50
);

INSERT INTO producto (vendedor_id, nombre, imagen, precio)
VALUES (
    (SELECT id FROM vendedor WHERE login_usuario = 'HernanCZV'),
    'Inca Kola Sin Azucar 500ml',
    'https://github.com/Choflis/UNSASHOP/blob/main/img/inkacola.jpg?raw=true',
    'https://github.com/Choflis/UNSASHOP/blob/main/img/inkacola.jpg?raw=true',
    2.90
);

INSERT INTO producto (vendedor_id, nombre, imagen, precio)
VALUES (
    (SELECT id FROM vendedor WHERE login_usuario = 'HernanCZV'),
    'Oreo Original 108g',
    'https://github.com/Choflis/UNSASHOP/blob/main/img/oreo.jpg?raw=true',
    'https://github.com/Choflis/UNSASHOP/blob/main/img/oreo.jpg?raw=true',
    2.60
);

INSERT INTO producto (vendedor_id, nombre, imagen, precio)
VALUES (
    (SELECT id FROM vendedor WHERE login_usuario = 'HernanCZV'),
    'Papas Nativas Inka Chips 135g',
    'https://github.com/Choflis/UNSASHOP/blob/main/img/inka.jpg?raw=true',
    'https://github.com/Choflis/UNSASHOP/blob/main/img/inka.jpg?raw=true',
    8.00
);

INSERT INTO producto (vendedor_id, nombre, imagen, precio)
VALUES (
    (SELECT id FROM vendedor WHERE login_usuario = 'HernanCZV'),
    'Chizitos Sabor Queso 190g',
    'https://github.com/Choflis/UNSASHOP/blob/main/img/chizito.jpg?raw=true',
    'https://github.com/Choflis/UNSASHOP/blob/main/img/chizito.jpg?raw=true',
    6.90
);

INSERT INTO producto (vendedor_id, nombre, imagen, precio)
VALUES (
    (SELECT id FROM vendedor WHERE login_usuario = 'HernanCZV'),
    'Battimix Vainilla 146g',
    'https://github.com/Choflis/UNSASHOP/blob/main/img/batimix.jpg?raw=true',
    'https://github.com/Choflis/UNSASHOP/blob/main/img/batimix.jpg?raw=true',
    4.60
);

INSERT INTO producto (vendedor_id, nombre, imagen, precio)
VALUES (
    (SELECT id FROM vendedor WHERE login_usuario = 'HernanCZV'),
    'Cono Frio Rico Choco Chips 130ml',+
    'https://github.com/Choflis/UNSASHOP/blob/main/img/friorico.jpg?raw=true',
    4.90
);
