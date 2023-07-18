const appConfig = {
  buildModules: ['acl'], // 需要编译的模块
  redirectTo: '/acl', // 首页的重定向路径
  ssoLogoutURL: '/api/sso/logout',
  showDocs: false,
}

export default appConfig
