-- criação do BD refinado para o cenário do E-commerce
create database if not exists ecommerce_desafio;
use ecommerce_desafio;

-- criar tabela cliente
create table clients (
	idClient int auto_increment primary key,
    Fname varchar(10) not null,
    Mname varchar(3),
    Lname varchar(20),
    CPF char(11),
    CNPJ char(14),
    address varchar(45),
    phone varchar(15),
    birth_date date not null,
    typeClient enum ('PJ', 'PF') default 'PF',
    constraint unique_cpf_client unique (CPF),
    constraint unique_cnpj_client unique (CNPJ)
);

alter table clients auto_increment=1;

-- criar tabela produto
create table product (
	idProduct int auto_increment primary key,
    Pname varchar(25) not null,
    classification_kids bool default false,
    category enum ('Eletrônico', 'Vestimenta', 'Brinquedos', 'Alimentos', 'Móveis') not null,
    rating float default 0,
    size varchar(10),
    constraint unique_Pname_product unique (Pname)
);

alter table product auto_increment=1;

-- criar tabela pagamentos
create table payments (
	idPayment int auto_increment primary key,
    idClient int,
    typePayment enum('Dinheiro', 'Cartão', 'Boleto', 'Dois cartões'),
    limitAvailable float,
    constraint fk_payment_client foreign key (idClient) references clients(idClient)
);

-- criar tabela pedido
create table orders (
	idOrder int auto_increment primary key,
    idOrderClient int,
	orderStatus enum('Cancelado', 'Confirmado', 'Em processamento') default 'Em processamento',
    orderDescription varchar(255),
    sendValue float default 10,
    paymentCash bool default false,
    constraint fk_orders_client foreign key (idOrderClient) references clients(idClient)
		on update cascade
);

alter table orders auto_increment=1;

-- criar tabela estoque
create table productStorage (
	idProdStorage int auto_increment primary key,
    storageLocation varchar(30),
    quantity int default 0
);

alter table productStorage auto_increment=1;

-- criar tabela fornecedor
create table supplier (
	idSupplier int auto_increment primary key,
	SocialName varchar(255) not null,
    CNPJ char(14) not null,
    contact char(11) not null,
    constraint unique_supplier unique (CNPJ)
);

alter table supplier auto_increment=1;

-- relação produto fornecedor
create table productSupplier (
	idPsupplier int,
    idProduct int,
    quantity int not null,
    primary key (idPsupplier, idProduct),
    constraint fk_productsupplier_supplier foreign key (idPsupplier) references supplier(idSupplier),
    constraint fk_productsupplier_product foreign key (idProduct) references product(idProduct)
);

-- criar tabela vendedor
create table seller (
	idSeller int auto_increment primary key,
	SocialName varchar(255) not null,
    AbstName varchar(255),
    CNPJ char(14) not null,
    CPF char(11) not null,
    contact char(11) not null,
    location varchar(60),
    constraint unique_seller unique (CNPJ),
    constraint unique_seller_id unique (CPF)
);

alter table seller auto_increment=1;

-- relação produto vendedor
create table productSeller (
	idPseller int,
    idProduct int,
    prodQuantity int default 1,
    primary key (idPseller, idProduct),
    constraint fk_product_seller foreign key (idPseller) references seller(idSeller),
    constraint fk_product_product foreign key (idProduct) references product(idProduct)
);

-- relação produto pedido
create table productOrder (
	idPOproduct int,
    idPOorder int,
    prodQuantity int default 1,
    prodStatus enum('Disponível', 'Fora de estoque') default 'Disponível',
	primary key (idPOproduct, idPOorder),
    constraint fk_poduct_product foreign key (idPOproduct) references product(idProduct),
    constraint fk_product_order foreign key (idPOorder) references orders(idOrder)
);

create table storageLocation(
	idLproduct int,
    idLstorage int,
    location varchar(255) not null,
    primary key (idLproduct, idLstorage),
    constraint fk_storage_location_product foreign key (idLproduct) references product(idProduct),
    constraint fk_storage_location_storage foreign key (idLstorage) references productStorage(idProdStorage)
);

create table delivery (
    idDorder int primary key,
    trackingCode varchar(60),
    statusDelivery enum('Cancelado','Enviado','Em trânsito','Entregue') not null,
	constraint fk_delivery_order foreign key (idDorder) references orders(idOrder)
);

show tables;
