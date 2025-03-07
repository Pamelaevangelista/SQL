CREATE DATABASE IF NOT EXISTS empresa;

USE empresa;
 
 CREATE TABLE Departamentos (
 Codigo INT AUTO_INCREMENT PRIMARY KEY,
 Nome VARCHAR(255) NOT NULL,
 Localizacao VARCHAR(255) NOT NULL,
 CodigoFuncionarioGerente INT
 );
 
 CREATE TABLE Funcionarios (
	Codigo INT AUTO_INCREMENT PRIMARY KEY,
    PrimeiroNome VARCHAR(100) NOT NULL,
    SegundoNome VARCHAR(100) NOT NULL,
    UltimoNome VARCHAR(100) NOT NULL,
    DataNascimento DATE NOT NULL,
    CPF VARCHAR(11) UNIQUE NOT NULL,
    RG VARCHAR(10) UNIQUE NOT NULL,
    Endereco VARCHAR(255) NOT NULL,
    CEP VARCHAR(8) NOT NULL,
    Cidade VARCHAR(100) NOT NULL,
    Fone VARCHAR(13) NOT NULL,
    CodigoDepartamento INT,
    Funcao VARCHAR(100) NOT NULL,
    Salario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (CodigoDepartamento) REFERENCES Departamentos(Codigo)
);

ALTER TABLE Departamentos
ADD CONSTRAINT fk_GerenteDepartamento
FOREIGN KEY (CodigoFuncionarioGerente) REFERENCES Funcionarios(Codigo);

INSERT INTO Departamentos (Nome, LOcalizacao, CodigoFuncionarioGerente)
VALUES 
('RH', 'São Paulo', Null),
('TI', 'Rio de Janeiro', Null),
('Vendas', 'São Paulo', Null),
('Marketing', 'Curitiba', NULL),
('Financeiro', 'Belo Horizonte', NULL);

INSERT INTO Funcionarios (
    PrimeiroNome, SegundoNome, UltimoNome, DataNascimento, CPF, RG, Endereco, CEP, Cidade, Fone, CodigoDepartamento, Funcao, Salario)
VALUES 
('João', 'Antônio', 'Silva', '1990-01-01', '12345678901', '1234567', 'Rua Teste, 123', '01001000', 'São Paulo', '(11) 1234-5678', 1, 'Gerente RH', 8000.00),
('Maria', NULL, 'Oliveira', '1992-02-02', '23456789012', '2345678', 'Rua Teste, 456', '20001000', 'Rio de Janeiro', '(21) 5678-9012', 2, 'Gerente TI', 9000.00),
('Pedro', 'Henrique', 'Santos', '1991-03-03', '34567890123', '3456789', 'Rua Teste, 789', '01002000', 'São Paulo', '(11) 9012-3456', 3, 'Gerente Vendas', 8500.00),
('Ana', 'Beatriz', 'Lima', '1993-04-04', '45678901234', '4567890', 'Rua Teste, 012', '80001000', 'Curitiba', '(41) 1234-5678', 4, 'Gerente Marketing', 8200.00),
('Carlos', NULL, 'Gomes', '1994-05-05', '56789012345', '5678901', 'Rua Teste, 345', '30001000', 'Belo Horizonte', '(31) 5678-9012', 5, 'Gerente Financeiro', 8800.00);
    
    ALTER TABLE Funcionarios
    MODIFY COLUMN CEP VARCHAR (9) NOT NULL;
    
    ALTER TABLE Funcionarios
    MODIFY COLUMN Fone VARCHAR (14) NOT NULL;
    
    ALTER TABLE Funcionarios
    MODIFY COLUMN SegundoNome VARCHAR (100);
    
SELECT * FROM Funcionarios;
SELECT * FROM Departamentos;

SET SQL_SAFE_UPDATES = 0;

UPDATE departamentos 
SET CodigoFuncionarioGerente = (
	SELECT Codigo
	FROM funcionarios
	WHERE Funcao   LIKE '%Gerente%' AND CodigoDepartamento = Departamentos.Codigo
);

SELECT * FROM Funcionarios;
SELECT * FROM Departamentos;

#listar Nome e sobrenome ordenados por sobrenome 
SELECT 
	PrimeiroNome AS Nome,
    UltimoNome AS Sobrenome
FROM 
	Funcionarios
ORDER BY
	UltimoNome ASC;

#liste todos os campos de funcionarios ordenados por cidade:
SELECT * FROM Funcionarios
ORDER BY Cidade ASC;

#liste data de nascimento e o primeiro nome dos funcionarios,
#ordenar do mais novo para o mais velho 
SELECT 
	DataNascimento,PrimeiroNome
FROM
	Funcionarios
ORDER BY 
	DataNascimento DESC;
    
#liste os funcionarios em fromato de listagem telefônica,
#mostrando nome completo e telefone
#Forma 1

SELECT 
	IFNULL (
	CONCAT(PrimeiroNome,' ',SegundoNome,' ',UltimoNome),
    CONCAT(PrimeiroNome,' ',UltimoNome)
    )
AS NomeCompleto,
	Fone AS Telefone
FROM
	Funcionarios
ORDER BY 
	PrimeiroNome ASC, UltimoNome Asc;

#Forma 2 IF 
SELECT 
	IF (
	SegundoNome IS NULL,
    CONCAT(PrimeiroNome,' ',UltimoNome),
    CONCAT(PrimeiroNome,' ',SegundoNome,' ',UltimoNome)
    ) AS NomeCompleto,
	Fone AS Telefone
FROM
	Funcionarios
ORDER BY 
	PrimeiroNome ASC, UltimoNome Asc;
    
#Forma 3
SELECT 
	CASE
		WHEN SegundoNome IS NULL THEN CONCAT(PrimeiroNome,' ',UltimoNome)
        ELSE CONCAT( PrimeiroNome,' ',SegundoNome,' ',UltimoNome)
    END AS NomeCompleto,
	Fone AS Telefone
FROM
	Funcionarios
ORDER BY 
	PrimeiroNome ASC, UltimoNome Asc;

#Exiba o nome completo dos funcionarios,
#O nome do departamento ao qual pertencem e a função de cada um 

SELECT
	IFNULL (
		CONCAT(PrimeiroNome,' ',SegundoNome,' ',UltimoNome),
		CONCAT(PrimeiroNome,' ',UltimoNome)
    ) AS NomeCompleto, 
	d.Nome AS NomeDepartamento,
    f.Funcao
FROM 
	Funcionarios f 
JOIN 	
	Departamentos d ON f.CodigoDepartamento = d.Codigo
ORDER BY
	f.UltimoNome ASC, f.PrimeiroNome ASC;
    
    
    
