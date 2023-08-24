-- inserção de dados
use ecommerce_desafio;
show tables;

-- clientes
insert into clients(Fname, Mname, Lname, CPF, address, birth_date) 
	   values('Maria','M','Silva', 12346789, 'rua silva de prata 29 - Cidade das flores', '1999-05-17'),
		     ('Matheus','O','Pimentel', 987654321,'rua alemeda 289 - Cidade das flores', '1947-05-18'),
			 ('Ricardo','F','Silva', 45678913,'avenida alemeda vinha 1009- Cidade das flores', '1949-03-17'),
			 ('Julia','S','França', 789123456,'rua lareijras 861 - Cidade das flores', '2000-06-09'),
			 ('Roberta','G','Assis', 98745631,'avenidade koller 19 - Cidade das flores', '1999-12-22'),
			 ('Isabela','M','Cruz', 654789123,'rua alemeda das flores 28 - Cidade das flores', '2001-01-06');

-- produtos
insert into product (Pname, classification_kids, category, rating, size) values
							  ('Fone',false,'Eletrônico','4',null),
                              ('Barbie',true,'Brinquedos','3',null),
                              ('Microfone',False,'Eletrônico','4',null),
                              ('Sofá',False,'Móveis','3','3x57x80'),
                              ('Farinha',False,'Alimentos','2',null),
                              ('Fire Stick',False,'Eletrônico','3',null);

-- pedidos
insert into orders (idOrderClient, orderStatus, orderDescription, sendValue, paymentCash) values 
							 (1, default,'compra via aplicativo',null,1),
                             (2,default,'compra via aplicativo',50,0),
                             (3,'Confirmado',null,null,1),
                             (4,default,'compra via web site',150,0);

insert into productOrder (idPOproduct, idPOorder, prodQuantity, prodStatus) values
						 (1,1,2,null),
                         (2,1,1,null),
                         (3,2,1,null);

insert into productStorage (storageLocation,quantity) values 
							('Rio de Janeiro',1000),
                            ('Rio de Janeiro',500),
                            ('São Paulo',10),
                            ('São Paulo',100),
                            ('São Paulo',10),
                            ('Brasília',60);

insert into storageLocation (idLproduct, idLstorage, location) values
						 (1,2,'RJ'),
                         (2,6,'GO');

insert into supplier (SocialName, CNPJ, contact) values 
							('Almeida e filhos', 12345678912345,'21985474'),
                            ('Eletrônicos Silva',85451964914347,'21985484'),
                            ('Eletrônicos Valma', 93456789393695,'21975474');

insert into supplier (SocialName, CNPJ, contact) values 
						('Tech eletronics', 12345678945632, 219946287);

insert into productSupplier (idPsupplier, idProduct, quantity) values
						 (1,1,500),
                         (1,2,400),
                         (2,4,633),
                         (3,3,5),
                         (2,5,10);

insert into seller (SocialName, AbstName, CNPJ, CPF, location, contact) values 
						('Tech eletronics', null, 12345678945632, 12345678911, 'Rio de Janeiro', 219946287),
					    ('Botique Durgas',null,12345678911111,9876532112,'Rio de Janeiro', 219567895),
						('Kids World',null,45678912365448,78965412326,'São Paulo', 1198657484);

insert into productSeller (idPseller, idProduct, prodQuantity) values 
						 (1,2,80),
                         (2,3,10);

select * from orders;

insert into delivery (idDorder, trackingCode, statusDelivery) values
	(1, '2568LKJ456321', 'Enviado'),
	(2, '2568LKJ557856', 'Enviado'),
	(4, '2568LKJ445895', 'Enviado');
    