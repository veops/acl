## Install by Makefile

- 启动 mysql 服务, redis 服务

- 创建数据库 acl
- 拉取代码

```bash
git clone https://github.com/veops/acl.git
cd acl
cp acl-api/settings.example.py acl-api/settings.py
```

**设置 acl-api/settings.py 里的 database**

- 顺序在 acl 目录下执行
  - 环境: `make env`
  - 启动 API: `make api`
  - 启动 UI: `make ui`
  - 启动 worker: `make worker`
