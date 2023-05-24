-- create database project_manager

create type perfil as enum ('Admin', 'Usuário');
create type classificacao as enum ('Alta', 'Média', 'Baixa');

create table usuario (
   id serial,
   nome varchar (100),
   email varchar (100),
   senha varchar (100),
   perfil perfil,
   primary key (id)
);

create table projeto (
    id serial,
    nome varchar (100),
    descricao varchar (150),
    primary key (id)
);

create table requisito (
    id serial,
    id_projeto integer references projeto,
    nome varchar(100),
    descricao varchar(150),
    prioridade classificacao,
    complexidade classificacao,
    versao varchar(10),
    criado_em date not null default CURRENT_DATE,
    atualizado_em date not null default CURRENT_DATE,
    primary key (id)
);

alter sequence usuario_id_seq restart with 1;
alter sequence projeto_id_seq restart with 1;
alter sequence requisito_id_seq restart with 1;

insert into usuario values (default, 'admin', 'admin@admin.com', 'admin', 'Admin');
insert into usuario values (default, 'usuario', 'usuario@usuario.com', 'user', 'User');

