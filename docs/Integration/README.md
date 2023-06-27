# FlowForm 业务系统集成

工单系统为三方的业务系统提供了 `<iframe>` 的方式嵌入， 提供了以下页面以供访问：

| 页面名         | base path                       |
| -------------- | ------------------------------- |
| 模板与流程管理 | '/platform/flowformManagement'  |
| 我的发起       | '/platform/workorder/myapply'   |
| 我的代办       | '/platform/workorder/mytodo'    |
| 我的已办       | '/platform/workorder/mydone'    |
| 抄送我的       | '/platform/workorder/mycopied'  |
| 工单统计       | '/platform/workorder/statistic' |

本文档后面将把这些页面统称为 **业务页面**

这些页面的嵌入方式, 都是类似的。 依特定的要求，拼接好 URL ， 嵌入 `iframe` 标签即可。 

## URL 拼接

它们都需要以下特定 URL 参数， URL 分为四个部分:

1. **`FLOWFORM_PLATFORM_ADDRESS` (工单平台的部署 IP + 端口)**

   > 工单平台部署的地址， 如果是非复杂系统， 这里可以直接写在 `.env` 环境变量中， 例如本例中 将该地址存储为 `VUE_APP_FLOWFORM_ADDRESS` 环境变量

2. **basePath**

   指定页面的 基本路由

3. **必传 query 参数**

   - `uniTenantId` :  统一租户 ID
   - `bizToken`: 业务系统 授权 Token

4. **可选 query 参数**

   - `lang` ; 业务系统当前语言环境(不传递时，默认为 英文) 
   
     > 工单系统本地语言支持 中英法葡萄牙以及阿拉伯五种语言， 对应的标识为：`[zh, en, fr, pt, ar]`
   
   - `recent` : 过滤查询条件 - 时间范围的默认值， 从现在开始，到起始时间 的间隔数(number 类型， 默认不填写为3, 时间单位为月)
   
   - `statsLevel` : 
   
     用于统计页面，控制过滤结果的权限 ， 取值范围 [1,2,3] ， 默认为 3。
   
     * `1` : 起人 （发起人、查看全部的人)
   
     * `2` : 参与人 （发起人、参与人、查看全部的人)
   
     * `3` : 全部   (发起人、发起人部门及其子部门、参与人、查看全部的人)

**一个示例的 URL 如下：**

```bash
${FLOWFORM_PLATFORM_ADDRESS}${this.basePath}?uniTenantId=${UNI_TENANT_ID}&bizToken=${token}&lang=${lang}
```





以 `模板与流程管理` 页面为例:  某个业务系统中， 可以这样去集成:

```vue
<template>
  <iframe :src="src" frameborder="0"></iframe>
</template>
<script>
import { ACCESS_TOKEN } from '@/store/mutation-types';
import Vue from 'vue';
const token = Vue.ls.get(ACCESS_TOKEN);
const FLOWFORM_PLATFORM_ADDRESS = process.env.VUE_APP_FLOWFORM_ADDRESS;    
export default {
  data(){
    return{
      basePath:'/platform/flowformManagement'
    }
  },
  computed: {
    src: function () {
      const UNI_TENANT_ID = this.$store.state.user.info.sysDept.config.uniTenantId;
      const _lang = this.$store.state.user.info.language;
      const lang = _lang ? _lang.split('_')[0] : 'en';
      return `${FLOWFORM_PLATFORM_ADDRESS}${this.basePath}?uniTenantId=${UNI_TENANT_ID}&bizToken=${token}&lang=${lang}`;
    },
  },    
}
</script>
<style scoped>
iframe {
  width: 100%;
  height: calc(100vh - 134px);
  background: url('data:image/svg+xml;charset=utf-8,<svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24"><path fill="none" stroke="currentColor" stroke-dasharray="15" stroke-dashoffset="15" stroke-linecap="round" stroke-width="2" d="M12 3C16.9706 3 21 7.02944 21 12"><animate fill="freeze" attributeName="stroke-dashoffset" dur="0.3s" values="15;0"/><animateTransform attributeName="transform" dur="0.5s" repeatCount="indefinite" type="rotate" values="0 12 12;360 12 12"/></path></svg>')
    0px 0px no-repeat;
  background-position: 50% 50%;
}
</style>
```

建议将公用的部分进行封装抽离:

```vue
<template>
  <iframe :src="src" frameborder="0"></iframe>
</template>
<script>
import handleIframeMixin from "@/mixins/handleIframeMixin.js"
export default {
  mixins: [handleIframeMixin],
  data(){
    return{
      basePath:'/platform/flowformManagement'
    }
  }
}
</script>
<style scoped>
@import '~@assets/style/iframBaseStyle.css';
</style>

```

