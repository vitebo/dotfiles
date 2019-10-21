import dump

```
psql -U <user> -d <database> -h <host> < <filename>
```


export dump

```
pg_dump -d <database> -t <table_name> -U <user> -h <host> file.sql
```
