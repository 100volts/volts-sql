CREATE TABLE company_user
(
    id          BIGSERIAL        PRIMARY KEY,
    email       VARCHAR(120) NOT NULL,
    telephone   VARCHAR(15)  NOT NULL,
    password    VARCHAR(255)  NOT NULL,
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

drop table  electric_meter_data;
CREATE TABLE electric_meter_data (
    id                                  BIGINT                                 NOT NULL
        PRIMARY KEY,
    el_meter                            BIGINT                                 NOT NULL
        REFERENCES public.electric_meter(id),
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
