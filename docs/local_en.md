### Install

- Start mysql, redis
- Create mysql database: acl
- Pull code

  ```bash
  git clone https://github.com/veops/acl.git
  cd acl
  cp acl-api/settings.example.py acl-api/settings.py
  ```

  **set database in config file acl-api/settings.py**

- Install library
  - backend: `cd acl-api && pipenv run pipenv install && cd ..`
  - frontend: `cd acl-ui && yarn install && cd ..`
- Suggest step: (default: user:demo,password:123456)
- Create tables of acl database:
  in **acl-api** directory: `pipenv run flask db-setup && pipenv run flask init-acl`

  ` source docs/acl.sql`

- Start service

  - backend: in **acl-api** directory: `pipenv run flask run -h 0.0.0.0`
  - frontend: in **acl-ui** directory: `yarn run serve`
  - worker: 
    - in **acl-api** directory: `pipenv run celery -A celery_worker.celery worker -E -Q acl_async --concurrency=1 -D`

  - homepage: [http://127.0.0.1:8000](http://127.0.0.1:8000)
    - if not run localhost: please change ip address(**VUE_APP_API_BASE_URL**) in config file **acl-ui/.env** into your backend ip address
