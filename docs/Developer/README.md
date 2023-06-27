# 扩展开发指南

对于开发人员，主要是对表单的扩展开发， 当基础的拖拽组件不满足业务需求时， 就需要开发自定义组件以满足需求。 自定义组件，从功能上分类，大致上可以分为**两类**: 

1. 一类是普通字段录入组件， 
2. 另一类是表单组件(也就是嵌套表单)。

对于这些组件的开发需要解决一些问题， 例如 普通的字段录入组件中的字段怎么在流程设计中，在流程节点上进行控制。 又或者 对于嵌套表单， 如何在提交时进行验证。 这些问题在下面的文档中会进行说明 。

所有的自定义组件，都暴露在: `src/CusComponents4FormDesign` 开发目录

创建一个自定义组件大致步骤：
1. 创建自定义组件目录
   ```bash
   mkdir src/CusComponents4FormDesign/CompomentName/
   ```

2. 创建 组件 以及导出出口文件

   ```bash
   touch src/CusComponents4FormDesign/CompomentName/CompomentName.vue index.js
   ```

3. 在自定义组件出口引入自定义组件，并统一导出

   > 在 src/CusComponents4FormDesign/index.js 中引入创建的组件，并导出