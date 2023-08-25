use oficina;
show tables;
select * from servicos;
desc veiculos;

-- informações dos funcionários 
select f.NomeFuncionario, f.Cargo, f.CPF, d.NomeDpto as Departamento
	from funcionarios as f JOIN departamentos as d
	where f.idDepartamento = d.idDepartamento;

-- contar quantos funcionários no departamento mecânico
select count(*) from funcionarios where idDepartamento = 2;

-- veículos cadastrados dos clientes
select v.TipoVeiculo, c.NomeCompleto_Cliente, c.TipoCliente, c.Telefone 
	from veiculos v JOIN clientes c
    where v.idCliente = c.idCliente;

-- mostrar clientes PJs
select NomeCompleto_Cliente as ClientePJ, Endereco
	from clientes
    where TipoCliente = 'PJ';

-- serviços feitos de acordo com cada funcionário
select v.TipoVeiculo, v.Placa, 
	c.NomeCompleto_Cliente as Cliente, 
	s.Preco, s.DataFim,
	f.NomeFuncionario 
	from clientes c JOIN veiculos v JOIN servicos s JOIN funcionarios f
    where f.idFuncionario = s.idFuncionario and v.idCliente = c.idCliente and s.idCliente = c.idCliente;


