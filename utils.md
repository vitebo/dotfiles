## Dump

import dump
```
psql -U <user> -d <database> -h <host> < <filename>
```

export dump
```
pg_dump -d <database> -t <table_name> -U <user> -h <host> <filename>
```


## kubernetes

update pod replic
```
kubectl scale deployment <deployment> --replicas=<number>
```


## Screem

create screen
```
screen -S screen_name
```

close screen
```
crtl d + crtl
```

attach screen
```
screen -Dr <screen_name>
```

list screen
```
screen -ls
```
