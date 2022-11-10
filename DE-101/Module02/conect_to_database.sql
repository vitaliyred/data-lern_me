-- Команды для подключения к БД(удаленной)
-- вводятся от именя суперпользователя (непосредственно в БД)

ALTER SCHEMA name_schema OWNER TO name_user;

GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA name_schema TO name_user;

GRANT USAGE ON SCHEMA name_schema TO name_user;
