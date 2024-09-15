CREATE TABLE company_user
(
    id          BIGSERIAL PRIMARY KEY,
    email       VARCHAR(120) NOT NULL,
    telephone   VARCHAR(15)  NOT NULL,
    password    VARCHAR(255) NOT NULL,
    first_name  VARCHAR(30)  NOT NULL,
    family_name VARCHAR(30)  NOT NULL,
    role        VARCHAR(10)  NOT NULL,
    company_id  BIGINT       NOT NULL,
    CONSTRAINT company_user_seq FOREIGN KEY (company_id) REFERENCES company (id)
);

ALTER TABLE
    company_user
    ADD CONSTRAINT fk_company_user_company FOREIGN KEY (company_id) REFERENCES company (id);

CREATE table company
(
    id   BIGINT      NOT NULL,
    name VARCHAR(30) NOT NULL,
    PRIMARY KEY (id)
);

drop table electric_meter_data;
CREATE TABLE electric_meter_data
(
    id                                  BIGINT                                 NOT NULL
        PRIMARY KEY,
    el_meter                            BIGINT                                 NOT NULL
        REFERENCES public.electric_meter (id),
    voltage_l1_n                        NUMERIC(5, 2)                          NOT NULL,
    voltage_l2_n                        NUMERIC(5, 2)                          NOT NULL,
    voltage_l3_n                        NUMERIC(5, 2)                          NOT NULL,
    current_l1                          NUMERIC(7, 4)                          NOT NULL,
    current_l2                          NUMERIC(7, 4)                          NOT NULL,
    current_l3                          NUMERIC(7, 4)                          NOT NULL,
    active_power_l1                     NUMERIC(10, 2)                         NOT NULL,
    active_power_l2                     NUMERIC(10, 2)                         NOT NULL,
    active_power_l3                     NUMERIC(10, 2)                         NOT NULL,
    power_factor_l1                     NUMERIC(8, 6)                          NOT NULL,
    power_factor_l2                     NUMERIC(8, 6)                          NOT NULL,
    power_factor_l3                     NUMERIC(8, 6)                          NOT NULL,
    total_active_power                  NUMERIC(25, 2)                         NOT NULL,
    total_active_energy_import_tariff_1 NUMERIC(12, 2)                         NOT NULL,
    total_active_energy_import_tariff_2 NUMERIC(12, 2)                         NOT NULL,
    time_stamp                          TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL
);


create table unit(
   id          SERIAL        PRIMARY KEY,
   unit_name  VARCHAR(150)  NOT NULL,
   unit_value VARCHAR(10)  NOT NULL
);

create table production_group(
   id          SERIAL        PRIMARY KEY,
   production_group_name  VARCHAR(150)  NOT NULL,
   description VARCHAR(150)  NOT NULL,
   company BIGINT NOT NULL REFERENCES public.company(id)
);

create table electric_meter_production(
   production  BIGINT NOT NULL,
   electric_meter BIGINT NOT NULL,
   PRIMARY KEY (production, electric_meter),
   FOREIGN KEY (production) REFERENCES public.production(id) ON DELETE CASCADE,
   FOREIGN KEY (electric_meter) REFERENCES public.electric_meter(id) ON DELETE CASCADE
);

create table production(
   id SERIAL        PRIMARY KEY NOT NULL,
   production_name  VARCHAR(150)  NOT NULL,
   description VARCHAR(150)  NOT NULL,
   ts timestamp not null,
   units BIGINT NOT NULL REFERENCES public.unit(id),
   company BIGINT NOT NULL REFERENCES public.company(id)
);

create table production_data
(
    id      BIGINT         NOT NULL PRIMARY KEY,
    value   NUMERIC(12, 6) NOT NULL,
    production BIGINT NOT NULL REFERENCES public.production (id)
);

create table production_production_group(
   production  BIGINT NOT NULL,
   production_group BIGINT NOT NULL,
   PRIMARY KEY (production, production_group),
   FOREIGN KEY (production) REFERENCES public.production(id) ON DELETE CASCADE,
   FOREIGN KEY (production_group) REFERENCES public.production_group(id) ON DELETE CASCADE
);

CREATE SEQUENCE production_data_seq;
CREATE SEQUENCE production_group_seq;
CREATE sequence water_data_seq;
create sequence gas_data_seq;


create table water(
   id SERIAL        PRIMARY KEY NOT NULL,
   water_name  VARCHAR(150)  NOT NULL,
   description VARCHAR(150)  NOT NULL,
   ts timestamp not null,
    company BIGINT NOT NULL REFERENCES public.company(id)
);

create table water_data
(
    id      BIGINT         NOT NULL PRIMARY KEY,
    value   NUMERIC(12, 4) NOT NULL,
    ts timestamp not null,
    water_meter BIGINT NOT NULL REFERENCES public.water (id)
);

create table gas(
   id SERIAL        PRIMARY KEY NOT NULL,
   gas_name  VARCHAR(150)  NOT NULL,
   description VARCHAR(150)  NOT NULL,
   ts timestamp not null,
    company BIGINT NOT NULL REFERENCES public.company(id)
);

create table gas_data
(
    id      BIGINT         NOT NULL PRIMARY KEY,
    value   NUMERIC(12, 2) NOT NULL,
    ts timestamp not null,
    gas_meter BIGINT NOT NULL REFERENCES public.gas (id)
);

drop table gas_data;
drop table water;
drop table water_data;

create  table key_performance_indicator_energy(
    id      BIGINT         NOT NULL PRIMARY KEY,
    index   NUMERIC(12, 2) NOT NULL,
    value   NUMERIC(16, 2) NOT NULL
);

create table key_performance_indicator_production(
    id      BIGINT         NOT NULL PRIMARY KEY,
    value   NUMERIC(12, 2) NOT NULL,
    target   NUMERIC(12, 2) NOT NULL,
    ts timestamp not null,
    production BIGINT NOT NULL REFERENCES public.production(id),
    energy BIGINT NOT NULL REFERENCES public.key_performance_indicator_energy (id)
);

drop table key_performance_indicator_production;
