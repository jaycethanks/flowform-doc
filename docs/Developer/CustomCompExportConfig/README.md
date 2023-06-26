# 自定义组件导出字段说明

### label

- **类型：** `String`

- **是否必填：** 是

- **详细：**

  自定义组件显示名称

### icon

- **类型：** `String`

- **是否必填：** 否

- **详细：**

  ant-design-icon 图表集 所支持的图标名

### component

- **类型：** `VueComponent`

- **是否必填：** 是

- **详细：**

  自定义组件

### type

- **类型：** `String`

- **是否必填：** 是

- **详细：**

  自定义组件类型，通常和组件名称保持一致

  组件渲染的时候,用于找到自定义组件,该字段名不可重复,且应该避免和 [预定义组件类型(见下方附录)](#) 的组件类型重名，否则不会展示自定义组件

### options

- **类型：** `String`

- **是否必填：** 是

- **详细：**

  控件的属性区域的配置

  该字段设定了 控件属性设置面板 将会有哪些配置项，可以按需扩展，但是需要在 src/lib/kform/KFormDesign/module/formItemProperties.vue 中去添加对应的字段。 这些字段也会被透传到自定义组件中

#### options.type

- **类型：** `String`

- **是否必填：** 否

- **详细：**

  该type 用于展示控件的属性区域的配置

  该type 用于展示控件的属性区域的配置   有大量的预定义属性输入控件,也可以按需自己增加,由于属性编辑是可被复用的,因此该字段是可以重复的, 如果 [预定义组件类型(见下方附录)](#) 中的类型所对应的组件配置足够你的自定义组件使用，那么你可以直接指定其中一个， 但是如果这些值无法满足你的需求时, 你应当自定义type, 并在 src/lib/kform/KFormDesign/module/formItemProperties.vue 中去预定义属性编辑输入控件, 并将值帮定到 options<br />如果该字段未指定， 那么控件属性面板将会显示最基础的配置

#### options.width

- **类型：** `String`

- **是否必填：** 否

- **详细：**

  自定义组件的百分比宽度
  默认值100%

#### options.defaultValue

- **类型：** `String`

- **是否必填：** 是

- **详细：**

  组件的默认值
  <u>该属性必须配置，但是其值可以设定为 undefined， 一般默认值是在自定义组件中去定义的。</u> 

#### options.placeholder

- **类型：** `String`

- **是否必填：** 是

- **详细：**

  placeholder
  仅在自定义组件最外层为 Input 元素时才会直接生效

#### options.clearable

- **类型：** `String`

- **是否必填：** 是

- **详细：**

  clearable 是否可清除
  仅在自定义组件最外层为 Input 元素时才会直接生效

#### options.maxLength

- **类型：** `String`

- **是否必填：** 是

- **详细：**

  maxLength 最大输入长度
  仅在自定义组件最外层为 Input 元素时才会直接生效

#### options.minLength

- **类型：** `String`

- **是否必填：** 是

- **详细：**

  minLength 最小输入长度
  仅在自定义组件最外层为 Input 元素时才会直接生效

#### options.addonBefore

- **类型：** `String`

- **是否必填：** 是

- **详细：**

  input 前缀
  仅在自定义组件最外层为 Input 元素时才会直接生效

#### options.addonAfter

- **类型：** `String`

- **是否必填：** 是

- **详细：**

  input 后缀
  仅在自定义组件最外层为 Input 元素时才会直接生效

#### options.hidden

- **类型：** `String`

- **是否必填：** 是

- **详细：**

  组件是否可见
  控制 控件属性设置面板  是否有 组件是否可见配置，如果设定为 false, 仅会控制表单默认是否可见， 流程结点配置将会不断的覆盖该设定 

#### options.disabled

- **类型：** `String`

- **是否必填：** 是

- **详细：**

  组件是否可编辑
  控制 控件属性设置面板  是否有 组件是否可编辑配置，如果设定为 false, 仅会控制表单默认是否可编辑， 流程结点配置将会不断的覆盖该设定

#### options.help

- **类型：** `String`

- **是否必填：** 是

- **详细：**

  组件帮助信息
  控制 控件属性设置面板  是否有 帮助信息配置， 会在 lable 区域展示一个帮助的 图表，悬停将提示帮助信息。 

#### options.rules

- **类型：** `Array<{message:string,required:Boolean} | {pattern:REGXP, message:string]}>`

- **是否必填：** 是

- **详细：**

  验证规则
  控制 控件属性设置面板  是否有 验证规则配置组件, 值类型为一个 数组 `[]` 



**「附录」**

预定义组件类型

```bash
'input',
'textarea',
'date',
'time',
'number',
'radio',
'checkbox',
'select',
'rate',
'switch',
'slider',
'uploadImg',
'uploadFile',
'cascader',
'treeSelect',
'batch', 
'editor', 
'selectInputList',
'button', 
'alert', 
'text', 
'html', 
'divider'
```

