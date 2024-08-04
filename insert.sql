insert into company(id, name) VALUES (1,'Enensist');

INSERT INTO public.electric_meter (
    id, company, el_meter_address, el_meter_name, time_stamp
) VALUES
(1, 101, 1001, 'Meter A', '2024-08-04 12:00:00+00'),
(2, 102, 1002, 'Meter B', '2024-08-04 12:05:00+00'),
(3, 103, 1003, 'Meter C', '2024-08-04 12:10:00+00');

INSERT INTO public.electric_meter_data (
    id, el_meter, voltage_l1_n, voltage_l2_n, voltage_l3_n,
    current_l1, current_l2, current_l3, active_power_l1,
    active_power_l2, active_power_l3, power_factor_l1,
    power_factor_l2, power_factor_l3, total_active_power,
    total_active_energy_import_tariff_1,
    total_active_energy_import_tariff_2, time_stamp
) VALUES
(
    1, 1, 230.50, 230.60, 230.70,
    15.1234, 14.5678, 15.9876, 3450.75,
    3400.50, 3550.25, 0.987654,
    0.976543, 0.965432, 10401.50,
    123456.78, 876543.21, '2024-08-04 12:34:56+00'
);