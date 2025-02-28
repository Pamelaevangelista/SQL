/* Script DDL*/

CREATE DATABASE nome_do_banco;
/*sempre clicar duas vezes para selecionar a tabela*/

CREATE TABLE nome_tabela(
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(150) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    telefone VARCHAR(15) NOT NULL,
    data_nascimento DATE NOT NULL,
    data_cadastro  TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
    /* Timestemp: tipo de dado da coluna 
	Current_timestamp: se não ocorrer o registro da data e hora,
    o BD vai fazer isso automaticamente*/
);

SHOW TABLES;
/*Modificar tabela*/

ALTER TABLE nome_tabela
ADD COLUMN endereco VARCHAR(225);
/*altere a tabela e adicioine a coluna endereço*/

/*excluir uma tabela*/ 
/*DROP TABLE nome_tabela*/

SELECT * FROM nome_tabela;
