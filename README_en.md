
[![License](https://img.shields.io/badge/License-AGPLv3-brightgreen)](https://github.com/veops/cmdb/blob/master/LICENSE)
[![UI](https://img.shields.io/badge/UI-Ant%20Design%20Pro%20Vue-brightgreen)](https://github.com/sendya/ant-design-pro-vue)
[![API](https://img.shields.io/badge/API-Flask-brightgreen)](https://github.com/pallets/flask)

[English](README_en.md) / [中文](README.md)

> **Important Note**: The `master` branch may be in an _unstable state_ during development.
> Please refer to [releases](https://github.com/veops/acl/releases) for stable versions.

### Main Features

- Supports role-based access control based on roles, permissions, and resources.
  - Role inheritance, divided into global roles and application roles.
  - Customizable resource groups.
- Supports integration with multiple applications, enabling complete isolation of permissions per application.
- Provides triggers for flexible definition of permission rules.
- Audit log for operations.
- Provides REST API for easy integration.

### Document

- <a href="acl-api/example.py" target="_blank">example</a> 


### More Features

> You are also welcome to visit [VEOps official website](https://veops.cn) to discover more free operations and maintenance systems.

## Installation

### One-Click Docker Quick Build

- Prepare: install docker and docker-compose
- In directory acl
  ```
  docker-compose up -d
  ```
- View: [http://127.0.0.1:8000](http://127.0.0.1:8000)
- username: admin
- password: 123456


### [Local Setup](docs/local.md)

### [Installation with Makefile](docs/makefile.md)

---

_**Stay connected with us through our official WeChat account. Click to contact us and join our WeChat/QQ operations and maintenance groups to get more product and industry-related information.**_

![WeChat QR Code](docs/qrcode_for_gzh.jpg)
