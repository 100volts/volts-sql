select * from company;
select emd.total_active_energy_import_tariff_1, time_stamp from public.electric_meter_data emd  where emd.el_meter=5 order by id desc;
