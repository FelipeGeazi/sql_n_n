DROP TABLE IF EXISTS controle;

DROP TABLE IF EXISTS usuarios;

DROP TABLE IF EXISTS livros;

CREATE TABLE IF NOT EXISTS usuarios (
 id BIGSERIAL PRIMARY KEY,
 nome VARCHAR(128) NOT NULL,
 cpf VARCHAR(128) NOT NULL
);

CREATE TABLE IF NOT EXISTS livros (
 id BIGSERIAL PRIMARY KEY,
 titulo VARCHAR(128) NOT NULL,
 autor VARCHAR(128) NOT NULL,
 publicado_em TIMESTAMP NOT NULL
);

CREATE TABLE IF NOT EXISTS controle (
 id BIGSERIAL PRIMARY KEY,
 usuario_id INTEGER NOT NULL,
 livro_id INTEGER NOT NULL,
 retirado_em TIMESTAMP NOT NULL,
 devolvido_em TIMESTAMP,
 FOREIGN KEY (usuario_id) REFERENCES usuarios (id) ON DELETE CASCADE,
 FOREIGN KEY (livro_id) REFERENCES livros (id) ON DELETE CASCADE
);

INSERT INTO
 usuarios (nome, cpf)
VALUES
 ('Marcela', '12345678910'),
 ('Alfredo', '09876543211'),
 ('Lucas', '15326589481'),
 ('Larissa', '78945612312'),
 ('Felipe', '75648956121');

INSERT INTO
 livros (titulo, autor, publicado_em)
VALUES
 ('Hábitos Atômicos', 'James Clear', '2019-08-08'),
 ('Código Limpo', 'Robert C. Martin', '2009-09-08'),
 (
  'Arquitetura Limpa',
  'Robert C. Martin',
  '2019-04-23'
 ),
 (
  'Domain-Driven Design',
  'Eric Evans',
  '2016-12-16'
 );

INSERT INTO
 controle (usuario_id, livro_id, retirado_em, devolvido_em)
VALUES
 (1, 1, '2022-02-21 08:02:13', null),
 (
  1,
  2,
  '2022-01-13 11:23:30',
  '2022-02-13 10:44:32'
 ),
 (
  2,
  2,
  '2022-02-18 09:30:42',
  '2022-03-18 14:49:23'
 ),
 (3, 4, '2021-08-21 10:32:01', null);

SELECT
 l.titulo
FROM
 livros l
 INNER JOIN controle c ON l.id = c.livro_id
WHERE
 c.devolvido_em IS NULL;

SELECT
 u.nome,
 l.titulo,
 c.retirado_em,
 c.devolvido_em
FROM
 usuarios u
 INNER JOIN controle c ON u.id = c.usuario_id
 INNER JOIN livros l ON c.usuario_id = l.id;