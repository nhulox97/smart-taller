create database taller_gustavo;


create table if not exists estado_registro (
	estado_registro_id serial primary key,
	estado_registro_estado varchar(25) unique not null,
	estado_registro_desc varchar(100) not null,
	estado_registro_corto varchar(3) unique not null
);


create table if not exists estado_reparacion_vehiculo (
	estado_reparacion_vehiculo_id serial primary key,
	estado_reparacion_vehiculo_estado varchar(15) unique not null,
	estado_reparacion_vehiculo_desc varchar(100) not null,
	estado_reparacion_vehiculo_corto varchar(3) unique not null
);


create table if not exists rol (
	rol_id serial primary key,
	rol_rol varchar(50) unique not null,
	rol_desc varchar(100) not null,
	rol_corto varchar(3) unique not null
);

create table if not exists permiso (
	permiso_id serial primary key,
	permiso_permiso varchar(50) unique not null,
	permiso_desc varchar(100) not null
);

create table if not exists permiso_rol (
	permiso_rol_id serial primary key,
	permiso_id int4 not null,
	rol_id int4 not null,
	constraint fk_per_rol_rol_id foreign key(rol_id) references rol(rol_id) on update cascade,
	constraint fk_per_rol_per_id foreign key(permiso_id) references permiso(permiso_id) on update cascade
);

create table usuario (
	usuario_id serial primary key,
	usuario_nombre varchar(50) not null,
	usuario_apellido varchar(50) not null,
	usuario_email varchar(320) unique not null,
	usuario_codigo varchar(10) default 'ABCD00000',
	usuario_username varchar(25) unique not null,
	usuario_password varchar(100) unique not null,
	estado_registro_id int4 not null,
	rol_id int4 not null,
	constraint fk_usr_est_reg_id foreign key(estado_registro_id)
	references estado_registro(estado_registro_id) on update cascade,
	constraint fk_usr_rol_id foreign key(rol_id) references rol(rol_id) on update cascade
);
