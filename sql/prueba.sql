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
    'http://drive.google.com/uc?export=view&id=1ffibXlCWbl5BkonA-zQNWYoTY2gyhl8u',
    2.40
);

INSERT INTO producto (vendedor_id, nombre, imagen, precio)
VALUES (
    (SELECT id FROM vendedor WHERE login_usuario = 'HernanCZV'),
    'Coca Cola 500ml',
    'https://drive.google.com/file/d/1iGMlJ0pEm1jUKqN1h_d-1VHKWkV1PiN6/view?usp=drive_link',
    2.90
);

INSERT INTO producto (vendedor_id, nombre, imagen, precio)
VALUES (
    (SELECT id FROM vendedor WHERE login_usuario = 'HernanCZV'),
    'Sprite 500ml',
    'https://drive.google.com/file/d/1S9cyU1JZYKhGSXvHT4QGX8EnBRLZhTeK/view?usp=drive_link',
    2.50
);

INSERT INTO producto (vendedor_id, nombre, imagen, precio)
VALUES (
    (SELECT id FROM vendedor WHERE login_usuario = 'HernanCZV'),
    'Inca Kola Sin Azucar 500ml',
    'https://drive.google.com/file/d/1G-k6wdSvDyYfL1foNslnWTeVOWkA1ar2/view?usp=drive_link',
    2.90
);

INSERT INTO producto (vendedor_id, nombre, imagen, precio)
VALUES (
    (SELECT id FROM vendedor WHERE login_usuario = 'HernanCZV'),
    'Oreo Original 108g',
    'https://drive.google.com/file/d/1kv866UTTYQ0ZvViLCupcZneV6OcTXrhm/view?usp=drive_link',
    2.60
);

INSERT INTO producto (vendedor_id, nombre, imagen, precio)
VALUES (
    (SELECT id FROM vendedor WHERE login_usuario = 'HernanCZV'),
    'Papas Nativas Inka Chips 135g',
    'https://drive.google.com/file/d/1fyBqq5xQbQJsXGJDqzs_2Yo13gMI5GZ8/view?usp=drive_link',
    8.00
);

INSERT INTO producto (vendedor_id, nombre, imagen, precio)
VALUES (
    (SELECT id FROM vendedor WHERE login_usuario = 'HernanCZV'),
    'Chizitos Sabor Queso 190g',
    'https://drive.google.com/file/d/1QglExijLtYIvJA_UP4Hk1x29BjuBjD4J/view?usp=drive_link',
    6.90
);

INSERT INTO producto (vendedor_id, nombre, imagen, precio)
VALUES (
    (SELECT id FROM vendedor WHERE login_usuario = 'HernanCZV'),
    'Battimix Vainilla 146g',
    'https://drive.google.com/file/d/1d1ZTrsfTmZrmNmkLHWujpQyrx2_mu3zG/view?usp=drive_link',
    4.60
);

INSERT INTO producto (vendedor_id, nombre, imagen, precio)
VALUES (
    (SELECT id FROM vendedor WHERE login_usuario = 'HernanCZV'),
    'Cono Frio Rico Choco Chips 130ml',
    'https://drive.google.com/file/d/1OEltQ68ROwpZD-9Lu6Jnd9OVwf6C4Reo/view?usp=drive_link',
    4.90
);
