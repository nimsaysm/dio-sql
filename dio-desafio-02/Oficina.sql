create database if not exists oficina;
use oficina;

-- tabela de departamentos
create table departamentos (
	idDepartamento int primary key auto_increment,
    NomeDpto varchar(60) not null
);

alter table departamentos auto_increment=1;

-- tabela de funcionários 
create table funcionarios (
	idFuncionario int auto_increment,
    NomeFuncionario varchar(45) not null,
    CPF CHAR(11) not null,
    Cargo VARCHAR(45) not null,
    idDepartamento int,
    constraint pk_funcionarios primary key (idFuncionario, idDepartamento),
    constraint fk_funcionarios_depto foreign key (idDepartamento) references departamentos(idDepartamento)
);

alter table funcionarios auto_increment=1;
alter table funcionarios 
	add constraint unique_funcionario unique (CPF);
    
-- tabela de clientes
create table clientes (
	idCliente int primary key auto_increment,
    NomeCompleto_Cliente varchar(60) not null,
    TipoCliente enum('PF', 'PJ') default 'PF',
    CPF char(11),
    CNPJ char(14),
    Telefone varchar(11),
    Endereco varchar(60)
);

alter table clientes
	add constraint unique_cpf_cliente unique (CPF),
	add constraint unique_cnpj_cliente unique (CNPJ);

-- tabela de veículos
create table veiculos (
	idVeiculo int auto_increment,
    idCliente int not null,
    Placa varchar(7) not null,
    TipoVeiculo enum('Carro', 'Moto', 'Caminhão') not null,
    constraint pk_veiculos primary key (idVeiculo, idCliente),
    constraint fk_veiculo_cliente foreign key (idCliente) references clientes(idCliente)
);

alter table veiculos
	add constraint unique_placa_veiculo unique (placa);

alter table veiculos auto_increment=1;

-- tabela de serviços
create table servicos (
	idServico int auto_increment,
	idCliente int not null,
    idVeiculo int not null,
    idFuncionario int not null,
	Preco float not null,
    TipoPgto enum('Dinheiro', 'Cartão', 'Dois cartões', 'Boleto') not null,
    Descricao varchar(225),
    DataInicio date not null,
	DataFim date not null,
    constraint pk_servicos primary key (idServico, idCliente, idVeiculo, idFuncionario),
	constraint fk_servico_cliente foreign key (idCliente) references clientes(idCliente),
	constraint fk_servico_veiculo foreign key (idVeiculo) references veiculos(idVeiculo),
	constraint fk_servico_funcionario foreign key (idFuncionario) references funcionarios(idFuncionario)
);

alter table servicos auto_increment=1;
