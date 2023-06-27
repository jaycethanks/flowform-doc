module.exports = {
  title: 'FlowForm 工单系统集成说明文档',
  description: 'Just playing around',
  themeConfig: {
    nav: [
      // {
      //   text: 'Home', link: '/'
      // }
    ],
    sidebar: [
      '/',
      {
        title: '系统集成',
        path: '/Integration/',
        sidebarDepth: 1,
        collapsable: false,
        children: [
          '/Integration/FlowFormManagement/',
          '/Integration/MyApply/',
          '/Integration/MyTodo/',
          '/Integration/MyDone/',
          '/Integration/MyCopied/',
          '/Integration/Statistic/',
        ]
      },
      {
        title: '扩展开发指南',
        path: '/Developer/',
        sidebarDepth: 1,
        collapsable: false,
        children: [
          'Developer/CustomFields/',
          'Developer/CustomForm/',
          'Developer/CustomCompExportConfig/'
        ]
      },
    ]

  }
}