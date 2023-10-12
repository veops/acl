
[![License](https://img.shields.io/badge/License-Apache2.0-brightgreen)](https://github.com/veops/cmdb/blob/master/LICENSE)
[![UI](https://img.shields.io/badge/UI-Ant%20Design%20Pro%20Vue-brightgreen)](https://github.com/sendya/ant-design-pro-vue)
[![API](https://img.shields.io/badge/API-Flask-brightgreen)](https://github.com/pallets/flask)

[English](docs/README_en.md) / [中文](README.md)
- 产品介绍：<a href="https://mp.weixin.qq.com/s/nFdLJnxkiLYOJlgyuqQ2LQ" target="_blank">一个简单通用的权限管理系统设计与实践
</a>
- 在线体验：<a href="https://cmdb.veops.cn/acl" target="_blank">ACL</a>
  - username: admin
  - password: 123456

> **重要提示**: `master` 分支在开发过程中可能处于 _不稳定的状态_ 。
> 请通过[releases](https://github.com/veops/acl/releases)获取

## 系统介绍

### 整体架构

<img src=docs/images/infra.jpg />

### 主要功能

- 支持基于角色、权限、资源的访问控制
  - 角色继承，分为全局角色和应用角色
  - 可定义资源组
- 支持接入多个应用，权限可按应用实现完全隔离
- 支持触发器，灵活定义权限规则
- 操作日志审计
- 提供REST API, 方便接入

### 相关文档

- <a href="acl-api/example.py" target="_blank">接入示例</a> 

### 更多功能

> 也欢迎移步[维易科技官网](https://veops.cn)，发现更多免费运维系统。


## 安装

### Docker一键快速构建
- 进入主目录（先安装 docker 环境）

```
docker-compose up -d
```

- 浏览器打开: [http://127.0.0.1:8000](http://127.0.0.1:8000)
- username: admin 
- password: 123456

### [本地搭建](docs/local.md)

### [Makefile 安装](docs/makefile.md)

---

_**欢迎关注公众号(维易科技OneOps)，关注后可加入微信群，进行产品和技术交流。**_

![公众号: 维易科技OneOps](docs/images/wechat.png)

