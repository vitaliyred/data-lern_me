# DE-101-Module-04
## Lab_4.4 - решение дз
### job для загрузки sample-superstore
*[job_download_superstore.kjb](https://github.com/vitaliyred/data-lern_me/blob/main/DE-101/Module04/Lab_4.4/pentaho_scripts/job_download_superstore.kjb)

![job_download_superstore](https://github.com/vitaliyred/data-lern_me/blob/main/DE-101/Module04/Lab_4.4/screenshot/job_download.png)

### transformations sample-superstore в orders, peoples, returns схемы stg
*[staging_orders.ktr](https://github.com/vitaliyred/data-lern_me/blob/main/DE-101/Module04/Lab_4.4/pentaho_scripts/staging_orders.ktr)

![staging_orders](https://github.com/vitaliyred/data-lern_me/blob/main/DE-101/Module04/Lab_4.4/screenshot/staging_orders.png)

### transformations таблиц схемы stg(Staging) в таблицы схемы dw(Dimension Tables)
*[dim_tables.ktr](https://github.com/vitaliyred/data-lern_me/blob/main/DE-101/Module04/Lab_4.4/pentaho_scripts/dim_tables.ktr)

*[sales_fact.ktr](https://github.com/vitaliyred/data-lern_me/blob/main/DE-101/Module04/Lab_4.4/pentaho_scripts/sales_fact.ktr)

![dim_tables](https://github.com/vitaliyred/data-lern_me/blob/main/DE-101/Module04/Lab_4.4/screenshot/dim_tables.png)
![sales_fact](https://github.com/vitaliyred/data-lern_me/blob/main/DE-101/Module04/Lab_4.4/screenshot/sales_fact.png)

### финальный job, в котором объеденены предыдущие щаги
*[final_job](https://github.com/vitaliyred/data-lern_me/blob/main/DE-101/Module04/Lab_4.4/pentaho_scripts/pentaho_job.kjb)

![final_job](https://github.com/vitaliyred/data-lern_me/blob/main/DE-101/Module04/Lab_4.4/screenshot/job_big.png)

### SQL код для создания таблиц в новой бд
*[Script_DB.sql](https://github.com/vitaliyred/data-lern_me/blob/main/DE-101/Module04/Lab_4.4/Script_DB.sql)

### Конечный результат после исполения *[final_job](https://github.com/vitaliyred/data-lern_me/blob/main/DE-101/Module04/Lab_4.4/pentaho_scripts/pentaho_job.kjb)
![result.png](https://github.com/vitaliyred/data-lern_me/blob/main/DE-101/Module04/Lab_4.4/screenshot/result.png)