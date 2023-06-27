# 自定义组件 - 表单录入

定义一个能够被提交时验证的自定义组件， 和普通的字段录入自定义组件是类似的， 唯一的区别是你需要额外提供一个 名为 `validateCurrentForm` 的验证函数。

其他的部分则和 [自定义组件 - 普通字段录入组件](/Developer/CustomFields/) 中提及的保持一致，这里不再赘述。

唯一值得说明的是 `validateCurrentForm` 函数，应当返回一个 Promise, 并在该 Promise 中去完成当前表单的验证

```vue
<template>
  <a-form-model
    ref="ruleForm"
    :model="exposeFields"
    :rules="rules"
    :label-col="labelCol"
    :wrapper-col="wrapperCol"
  >
    <a-form-model-item
      v-if="!exposeFields.name.hidden"
      ref="name"
      label="Activity name"
      prop="name"
    >
      <a-input
        :disabled="disabled || exposeFields.name.disabled"
        v-model="exposeFields.name.value"
      />
    </a-form-model-item>
    <a-form-model-item
      v-if="!exposeFields.region.hidden"
      label="Activity zone"
      required
      prop="region"
    >
      <a-select
        :disabled="disabled || exposeFields.region.disabled"
        v-model="exposeFields.region.value"
        placeholder="please select your zone"
      >
        <a-select-option value="shanghai"> Zone one </a-select-option>
        <a-select-option value="beijing"> Zone two </a-select-option>
      </a-select>
    </a-form-model-item>
    <a-form-model-item
      v-if="!exposeFields.date1.hidden"
      label="Activity time"
      required
      prop="date1"
    >
      <a-date-picker
        :disabled="disabled || exposeFields.date1.disabled"
        v-model="exposeFields.date1.value"
        show-time
        type="date"
        placeholder="Pick a date"
        style="width: 100%"
      />
    </a-form-model-item>
    <a-form-model-item
      v-if="!exposeFields.delivery.hidden"
      label="Instant delivery"
      prop="delivery"
    >
      <a-switch
        :disabled="disabled || exposeFields.delivery.disabled"
        v-model="exposeFields.delivery.value"
      />
    </a-form-model-item>
    <a-form-model-item
      v-if="!exposeFields.type.hidden"
      label="Activity type"
      prop="type"
    >
      <a-checkbox-group
        :disabled="disabled || exposeFields.type.disabled"
        v-model="exposeFields.type.value"
      >
        <a-checkbox value="1" name="type"> Online </a-checkbox>
        <a-checkbox value="2" name="type"> Promotion </a-checkbox>
        <a-checkbox value="3" name="type"> Offline </a-checkbox>
      </a-checkbox-group>
    </a-form-model-item>
    <a-form-model-item
      v-if="!exposeFields.resource.hidden"
      :disabled="disabled || exposeFields.resource.disabled"
      label="Resources"
      required
      prop="resource"
    >
      <a-radio-group
        :disabled="disabled || exposeFields.type.disabled"
        v-model="exposeFields.resource.value"
      >
        <a-radio value="1"> Sponsor </a-radio>
        <a-radio value="2"> Venue </a-radio>
      </a-radio-group>
    </a-form-model-item>
    <a-form-model-item
      v-if="!exposeFields.desc.hidden"
      label="Activity form"
      required
      prop="desc"
    >
      <a-input
        :disabled="disabled || exposeFields.desc.disabled"
        v-model="exposeFields.desc.value"
        type="textarea"
      />
    </a-form-model-item>
    <a-form-model-item :wrapper-col="{ span: 14, offset: 4 }">
      <a-button style="margin-left: 10px" @click="resetForm"> Reset </a-button>
    </a-form-model-item>
  </a-form-model>
</template>
<script>
export default {
  props: ['value', 'disabled'],
  data() {
    return {
      labelCol: { span: 4 },
      wrapperCol: { span: 14 },
      other: '',
      exposeFields: {
        name: {
          value: '',
          disabled: false,
          hidden: false,
        },
        region: {
          value: undefined,
          disabled: false,
          hidden: false,
        },
        date1: {
          value: undefined,
          disabled: false,
          hidden: false,
        },
        delivery: {
          value: false,
          disabled: false,
          hidden: false,
        },
        type: {
          value: [],
          disabled: false,
          hidden: false,
        },
        resource: {
          value: '',
          disabled: false,
          hidden: false,
        },
        desc: {
          value: '',
          disabled: false,
          hidden: false,
        },
      },
      rules: {
        region: [
          {
            validator: (rule, { value }, cb) => {
              if (!value) {
                cb(new Error(`不可为空！`))
              } else {
                cb()
              }
            }
          }],
        date1: [
          {
            validator: (rule, { value }, cb) => {
              if (!value) {
                cb(new Error(`不可为空！`))
              } else {
                cb()
              }
            }
          }
        ],
        resource: [
          {
            validator: (rule, { value }, cb) => {
              if (!value) {
                cb(new Error(`不可为空！`))
              } else {
                cb()
              }
            }
          },
        ],
        desc: [{
          validator: (rule, { value }, cb) => {
            if (!value) {
              cb(new Error(`不可为空！`))
            } else {
              cb()
            }
          }
        }],
      },
    };
  },
  watch: {
    exposeFields: {
      handler: function () {
        const form = {};
        for (let i in this.exposeFields) {
          form[i] = this.exposeFields[i].value;
        }
        this.$emit("change", form)
      },
      immediate: true,
      deep: true
    },
    value: {
      handler: function () {
        if (!this.value) return
        for (let i in this.value) {
          this.exposeFields[i].value = this.value[i];
        }
      },
      immediate: true,
      deep: true
    }
  },

  methods: {

    resetForm() {
      this.$refs.ruleForm.resetFields();
    },

    /**
     * @description:
     */
    validateCurrentForm() {
      return new Promise((resolve, reject) => {
        if (this.$refs.ruleForm) {
          this.$refs.ruleForm.validate(valid => {
            if (valid) {
              resolve()
            } else {
              reject(err)
            }
          })
        }
      })
    },
  },
};
</script>

```

![image-20230627105828987](./README.assets/image-20230627105828987.png)

![image-20230627105859996](./README.assets/image-20230627105859996.png)
