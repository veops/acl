### Install by Makefile

- Start mysql,redis
- Create mysql database: acl
- Pull code

  ```bash
  git clone https://github.com/veops/acl.git
  cd acl
  cp acl-api/settings.example.py acl-api/settings.py
  ```

  **set database in config file acl-api/settings.py**

- In acl directory,start in order as follows:
  - enviroment: `make env`
  - start API: `make api`
  - start UI: `make ui`
  - start worker: `make worker`
