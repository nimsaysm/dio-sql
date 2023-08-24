use ecommerce_desafio;
show tables;

select count(*) from clients;
select * from clients c, orders o where c.idClient = idOrderClient;

select Fname,Lname, idOrder, orderStatus from clients c, orders o where c.idClient = idOrderClient;
select concat(Fname,' ',Lname) as Client, idOrder as Request, orderStatus as Status from clients c, orders o where c.idClient = idOrderClient;

insert into orders (idOrderClient, orderStatus, orderDescription, sendValue, paymentCash) values 
							 (2, default,'compra via aplicativo',null,1);
                             
select count(*) from clients c, orders o 
			where c.idClient = idOrderClient;

select * from clients c 
				inner join orders o ON c.idClient = o.idOrderClient
                inner join productOrder p on p.idPOorder = o.idOrder
		group by idClient; 
        
select c.idClient, Fname, count(*) as Number_of_orders from clients c 
				inner join orders o ON c.idClient = o.idOrderClient
		group by idClient; 

-- Quantos pedidos foram feitos por cada cliente?
select 
	concat(c.Fname, ' ', c.Mname, ". ", c.Lname) as client_name,
    count(*) as quantity_orders
    from clients c
		JOIN
        orders o ON c.idClient =  o.idOrderClient
        GROUP BY c.idClient
		ORDER BY client_name;


-- Algum vendedor também é fornecedor?
select 
	su.SocialName as Supplier,
    sel.SocialName as Seller
    from supplier su
    JOIN 
    seller sel ON su.SocialName = sel.SocialName;
    
-- Relação de produtos fornecedores e estoques
select 
	p.Pname as productName,
    p.category,
    ps.quantity,
    sto.location,
    p.rating,
    sup.SocialName as supplier,
    sup.contact as supplierContact
	from
		product as p JOIN 
        supplier as sup JOIN
        productsupplier as ps JOIN
        storageLocation as sto
        where ps.idPsupplier = sup.idSupplier and ps.idProduct = p.idProduct and sto.idLproduct = p.idProduct;
    
-- Relação de nomes dos fornecedores e nomes dos produtos
select 
	p.Pname as productName,
    sup.SocialName as supplier,
    ps.quantity,
    sto.location
	from
		product as p JOIN 
        supplier as sup JOIN
        productsupplier as ps JOIN
        storageLocation as sto
        where ps.idPsupplier = sup.idSupplier and ps.idProduct = p.idProduct and sto.idLproduct = p.idProduct;

-- Pedidos e entrega
select * from delivery;
select * from orders;
select * from clients;
select 
	concat(c.Fname, ' ', c.Lname) as client_name,
	c.address,
    c.typeClient,
    c.CPF, c.CNPJ,
    o.orderDescription,
    o.sendValue,
	d.statusDelivery,
    d.trackingCode
    from 
    delivery as d JOIN orders as o JOIN clients as c
    where idOrderClient = idClient and idDorder = idOrder;
    