create database smart_taller;

create table if not exists estado_registro (
	estado_registro_id serial primary key,
	estado_registro_estado varchar(25) unique not null,
	estado_registro_desc varchar(100) not null,
	estado_registro_corto varchar(3) unique not null
);

insert into
	estado_registro(
		estado_registro_estado,
		estado_registro_desc,
		estado_registro_corto
	)
values
	('ACTIVO', 'Resgitro activo', 'ACT');

create table if not exists estado_reparacion (
	estado_reparacion_id serial primary key,
	estado_reparacion_estado varchar(15) unique not null,
	estado_reparacion_desc varchar(100) not null,
	estado_reparacion_corto varchar(3) unique not null
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

create table if not exists usuario (
	usuario_id serial primary key,
	usuario_nombre varchar(50) not null,
	usuario_apellido varchar(50) not null,
	usuario_email varchar(320) unique not null,
	usuario_codigo varchar(10) default 'ABCD00000',
	usuario_username varchar(25) unique not null,
	usuario_password varchar(100) unique not null,
	estado_registro_id int4 not null,
	rol_id int4 not null,
	constraint fk_usr_est_reg_id foreign key(estado_registro_id) references estado_registro(estado_registro_id) on update cascade,
	constraint fk_usr_rol_id foreign key(rol_id) references rol(rol_id) on update cascade
);

create table if not exists cliente(
	cliente_id serial primary key,
	cliente_nombre varchar(50) not null,
	cliente_apellido varchar(50) not null,
	cliente_DUI varchar(10) unique not null,
	cliente_telefono varchar(9) unique not null,
	cliente_email varchar(320) unique not null,
	cliente_direccion varchar(300) not null,
	cliente_fecha_creacion date default current_date,
	cliente_fecha_actualizacion date default null,
	estado_registro_id int4 not null,
	usuario_id int4 not null,
	constraint fk_cli_est_reg_id foreign key(estado_registro_id) references estado_registro(estado_registro_id) on update cascade,
	constraint fk_cli_usr_id foreign key(usuario_id) references usuario(usuario_id) on update cascade
);

create table if not exists tipo_vehiculo(
	tipo_vehiculo_id serial primary key,
	tipo_vehiculo_tipo varchar(20) unique not null,
	estado_registro_id int4 not null,
	constraint fk_tip_veh_est_reg_id foreign key(estado_registro_id) references estado_registro(estado_registro_id) on update cascade
);

create table if not exists marca_vehiculo(
	marca_vehiculo_id serial primary key,
	marca_vehiculo_marca varchar(20) unique not null,
	estado_registro_id int4 not null,
	constraint fk_mar_veh_est_reg_id foreign key(estado_registro_id) references estado_registro(estado_registro_id) on update cascade
);

create table if not exists tipo_marca_vehiculo(
	tipo_marca_vehiculo_id serial primary key,
	marca_vehiculo_id int4 not null,
	tipo_vehiculo_id int4 not null,
	estado_registro_id int4 not null,
	constraint fk_tip_mar_veh_tip_veh_id foreign key(tipo_vehiculo_id) references tipo_vehiculo(tipo_vehiculo_id) on update cascade,
	constraint fk_tip_mar_veh_mar_veh_id foreign key(marca_vehiculo_id) references marca_vehiculo(marca_vehiculo_id) on update cascade,
	constraint fk_tip_mar_veh_est_reg_id foreign key(estado_registro_id) references estado_registro(estado_registro_id) on update cascade
);

create table if not exists modelo_vehiculo(
	modelo_vehiculo_id serial primary key,
	tipo_marca_vehiculo_id int4 not null,
	estado_registro_id int4 not null,
	constraint fk_mod_vej_tip_mar_veh_id foreign key(tipo_marca_vehiculo_id) references tipo_marca_vehiculo(tipo_marca_vehiculo_id) on update cascade,
	constraint fk_mod_veh_est_reg_id foreign key(estado_registro_id) references estado_registro(estado_registro_id) on update cascade
);

create table if not exists vehiculo(
	vehiculo_id serial primary key,
	vehiculo_placa varchar(8) unique not null,
	vehiculo_chasis varchar(25) unique not null,
	vehiculo_tarjeta_circulacion varchar(18) unique not null,
	vehiculo_color varchar(15) not null,
	vehiculo_anio varchar(4) not null,
	vehiculo_fecha_creacion date default current_date,
	vehiculo_fecha_actualizacion date default null,
	modelo_vehiculo_id int4 not null,
	usuario_id int4 not null,
	estado_registro_id int4 not null,
	constraint fk_veh_mod_veh_id foreign key(modelo_vehiculo_id) references modelo_vehiculo(modelo_vehiculo_id) on update cascade,
	constraint fk_veh_usr_id foreign key(usuario_id) references usuario(usuario_id) on update cascade,
	constraint fk_veh_est_reg_id foreign key(estado_registro_id) references estado_registro(estado_registro_id) on update cascade
);

create table if not exists vehiculo_cliente(
	vehiculo_cliente_id serial primary key,
	vehiculo_cliente_fecha_creacion date default current_date,
	vehiculo_cliente_fecha_actualizacion date default null,
	cliente_id int4 not null,
	vehiculo_id int4 not null,
	usuario_id int4 not null,
	estado_registro_id int4 not null,
	constraint fk_veh_cli_cli_id foreign key(cliente_id) references cliente(cliente_id) on update cascade,
	constraint fk_veh_cli_veh_id foreign key(vehiculo_id) references vehiculo(vehiculo_id) on update cascade,
	constraint fk_veh_cli_usr_id foreign key(usuario_id) references usuario(usuario_id) on update cascade,
	constraint fk_veh_cli_est_reg_id foreign key(estado_registro_id) references estado_registro(estado_registro_id) on update cascade
);

create table if not exists tipo_servicio(
	tipo_servicio_id serial primary key,
	tipo_servicio_tipo varchar(25) not null,
	tipo_servicio_desc varchar(150) not null,
	estado_registro_id int4 not null,
	constraint fk_tip_ser_est_reg_id foreign key(estado_registro_id) references estado_registro(estado_registro_id) on update cascade
);

create table if not exists estado_vehiculo(
	estado_vehiculo_id serial primary key,
	estado_vehiculo_nivel_combustible int not null,
	estado_vehiculo_llanta_repuesto varchar(15) not null,
	estado_vehiculo_gato_hidraulico varchar(15) not null,
	estado_vehiculo_extintor varchar(15) not null,
	estado_vehiculo_triangulo varchar(15) not null,
	estado_vehiculo_retrovisor varchar(15) not null,
	estado_vehiculo_tarjeta_circulacion varchar(15) not null,
	estado_vehiculo_cinturones varchar(15) not null,
	estado_vehiculo_asientos varchar(15) not null,
	estado_vehiculo_alfombras varchar(15) not null,
	estado_vehiculo_equipo_sonido varchar(15) not null,
	estado_vehiculo_reloj varchar(15) not null,
	estado_vehiculo_aire_acondicionado varchar(15) not null,
	estado_vehiculo_espejos_laterales varchar(15) not null,
	estado_vehiculo_vias varchar(15) not null,
	estado_vehiculo_silvines varchar(15) not null,
	estado_vehiculo_cricos varchar(15) not null,
	estado_vehiculo_fecha_creacion timestamp default current_timestamp,
	estado_vehiculo_fecha_actualizacion timestamp default null,
	usuario_id int4 not null,
	constraint fk_est_veh_usr_id foreign key(usuario_id) references usuario(usuario_id)
);

create table if not exists fotografia_vehiculo(
	fotografia_vehiculo_id serial primary key,
	fotografia_vehiculo_frontal varchar(200) not null,
	fotografia_vehiculo_lateral_derecha varchar(200) not null,
	fotografia_vehiculo_trasera varchar(200) not null,
	fotografia_vehiculo_lateral_izquierda varchar(200) not null,
	fotografia_vehiculo_fecha_creacion timestamp default current_timestamp,
	fotografia_vehiculo_fecha_actualizacion timestamp default null
);

create table if not exists reparacion(
	reparacion_id serial primary key,
	reparacion_fecha_recibido timestamp default current_timestamp,
	reparacion_fecha_promesa timestamp not null,
	reparacion_total_estimado decimal(6, 2) not null,
	estado_vehiculo_id int4 not null,
	tipo_servicio_id int4 not null,
	usuario_id int4 not null,
	estado_reparacion_id int4 not null,
	fotografia_vehiculo_id int4 not null,
	constraint fk_rep_est_veh_id foreign key(estado_vehiculo_id) references estado_vehiculo(estado_vehiculo_id) on update cascade,
	constraint fk_rep_tip_ser_id foreign key(tipo_servicio_id) references tipo_servicio(tipo_servicio_id) on update cascade,
	constraint fk_rep_usr_id foreign key(usuario_id) references usuario(usuario_id) on update cascade,
	constraint fk_rep_est_rep_id foreign key(estado_reparacion_id) references estado_reparacion(estado_reparacion_id) on update cascade,
	constraint fk_rep_fot_veh_id foreign key(fotografia_vehiculo_id) references fotografia_vehiculo(fotografia_vehiculo_id) on update cascade
);