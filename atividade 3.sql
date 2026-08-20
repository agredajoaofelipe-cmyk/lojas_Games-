create database loja_Games;
use loja_Games;
create table cliente (
id_cliente int auto_increment primary key,
nome varchar(100) not null,
cpf varchar(14) not null unique,
email varchar(100) not null unique,
telefone varchar(16),
data_nascimento date not null,
cidade varchar(50) not null,
estado char(2) not null,
data_cadastro date not null
);

show tables;

create table funcionario (
    id_funcionario int auto_increment primary key,
    nome varchar(100) not null,
    cpf varchar(11) unique not null,
    cargo varchar(50),
    salario decimal(10,2)
);

create table fronecedor(
id_fornecedor int auto_increment primary key,
razao_social varchar(150) not null,
nome_fantasia varchar(100) not null,
cnpj varchar(18) not null unique,
email varchar (50)not null,
estado char (2)
);

create table categoria (
id_categoria int auto_increment primary key,
nome varchar(100) not null unique,
descricao varchar(255)
);
show tables;

create table produto (
id_produto int auto_increment primary key,
id_categoria int not null,
id_fornecedor int not null,
nome varchar(150) not null,
descricao TEXT,
preco decimal (10,2) not null,
custo decimal (10,2) unique,
codigo_barras varchar(30)unique,
marca varchar(100) not null,
modelo varchar(100) not null,
data_cadastro date not null
);
show tables;

alter table produto add constraint fk_produto_categoria foreign key
(id_categoria) references categoria(id_categoria),
add constraint fk_produto_fornecedor foreign key (id_fornecedor)
references fornecedor(id_fronecedor);

select * from produto;

create table estoque (
id_estoque int auto_increment primary key,
id_produto int not null unique,
quantidade int not null default 0,
estoque_minimo int not null default 5,
ultima_atualizacao datetime not null,

foreign key (id_produto) references produto(id_produto)
);

show tables;

alter table produto rename column codigo_barras to cord_barras;

create table pedido(
id_pedido int auto_increment primary key,
id_cliente int not null,
id_funcionario int not null,
data_pedido datetime not null,
status varchar(30) not null,
valor_total decimal(10,2) not null,

foreign key (id_cliente) references cliente(id_cliente),
foreign key (id_funcionario) references funcionario(id_funcionario)
);

select * from funcionario;

create table item_pedido (
id_item int auto_increment primary key,
id_pedido int not null,
id_produto int not null,
quantidade int not null,
preco_unitario decimal (10, 2) not null,
desconto decimal(10, 2) default 0,

foreign key (id_pedido) references pedido(id_pedido),
foreign key (id_produto) references produto(id_produto)
);

create table pagamento (
id_pagamento int auto_increment primary key,
id_pedido int not null,
data_pagamento datetime,
valor decimal(10,2) not null,
forma_pagamento varchar(30) not null,
status varchar(20) not null,

foreign key (id_pedido) references pedido(id_pedido)
);