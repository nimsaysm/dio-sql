use oficina;
show tables;
desc servicos;
select * from veiculos;

insert into departamentos (NomeDpto) values ('Administração'), ('Mecânicos');

insert into funcionarios (NomeFuncionario, CPF, Cargo, idDepartamento)
				values ('Sérgio Paulo', '7956862157', 'Dono', 1),
						('Maria Ingrid', '4956856847', 'Sócia', 1),
                        ('João Batista', '98564137254', 'Mecânico', 2),
                        ('Marcos Lima', '9256862157', 'Mecânico chefe', 2),
                        ('Ulisses Salvador', '6546862157', 'Mecânico', 2);

insert into clientes (NomeCompleto_Cliente, TipoCliente, CPF, CNPJ, Telefone, Endereco)
				values ('Mecânica BR Ltda', 'PJ', null, '13654789532468', null, 'Rua X, 995'),
						('Aurora Silva', null, '78965413521', null, '11987364759', 'Rua Z, 15'),
                        ('Supermercado Total', 'PJ', null, '46685113586264', null, 'Avenida BR, 987'),
                        ('Kaio Loures', null, '12365478998', null, '11986543678', 'Rua Y, 50');

insert into veiculos (idCliente, Placa, TipoVeiculo)
			values (1, 'ABC6547', 'Carro'),
					(1, 'CML6547', 'Carro'),
                    (2, 'LMF6547', 'Moto'),
                    (3, 'LMK6594', 'Caminhão'),
                    (4, 'GML6547', 'Carro');

insert into servicos (idCliente, idVeiculo, idFuncionario, Preco, TipoPgto, DataInicio, DataFim)
				values (1, 1, 3, 300.00, 'Cartão', '2023-05-18', '2023-05-20'),
						(2, 3, 4, 170.00, 'Dinheiro', '2023-07-20', '2023-07-21'),
                        (3, 4, 5, 200.00, 'Cartão', '2023-08-05', '2023-08-05');
                        