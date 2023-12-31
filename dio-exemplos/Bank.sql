select now as Timestamp;
create database if not exists manipulation;
use manipulation;

CREATE TABLE bankAccounts (
	Id_account INT auto_increment PRIMARY KEY,
    Ag_num INT NOT NULL,
    Ac_num INT NOT NULL,
    Saldo FLOAT,
    CONSTRAINT identification_account_constraint UNIQUE (Ag_num, Ac_num)
);

insert into bankAccounts (Ag_num, Ac_num, Saldo) values (789,123456,0);
select * from bankAccounts;

-- alter table nome_tabela tipo_modificação coluna nome_atributo tipo_dados condição
alter table bankAccounts add LimiteCredito float not null default 500.00;
alter table bankAccounts add email varchar(60);
alter table bankAccounts drop email;

desc bankAccounts;

CREATE TABLE bankClient(
	Id_client INT auto_increment,
    ClientAccount INT,
    CPF CHAR(11) NOT NULL,
    RG CHAR(9) NOT NULL,
    Nome VARCHAR(50) NOT NULL,
    Endereço VARCHAR(100) NOT NULL,
    Renda_mensal FLOAT,
    primary key (iD_Client, ClientAccount),
    CONSTRAINT fk_account_client foreign key (ClientAccount) REFERENCES bankAccounts(Id_account)
    ON UPDATE CASCADE
);

alter table bankClient add UFF char(2) not null default 'SP';

insert into bankClient (ClientAccount, CPF, RG, Nome, Endereço, Renda_mensal) values (1,12345678912,123456789,'Yasmin','Rua X',5000.60);

update bankClient set UFF='MG' where Nome='Yasmin';

select * from bankClient;

CREATE TABLE bankTransactions(
	Id_transaction INT auto_increment PRIMARY KEY,
    Ocorrencia datetime,
    Status_transaction VARCHAR(20),
    Valor_transferido FLOAT,
    Source_account INT,
    Destination_account INT,
    CONSTRAINT fk_source_transaction foreign key (Source_account) REFERENCES 
    bankAccounts(Id_account),
    CONSTRAINT fk_destination_transaction foreign key (Destination_account) REFERENCES
    bankAccounts(Id_account)
);
