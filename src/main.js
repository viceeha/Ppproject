import Vue from "vue";
import App from "./App.vue";
import router from "./router";
import store from "./store";
import ElementUI from "element-ui";
import "element-ui/lib/theme-chalk/index.css";
import "vant/lib/index.css";

import {
  Checkbox,
  CheckboxGroup,
  Stepper,
  AddressEdit,
  RadioGroup,
  Radio,
  Empty,
  Badge,
  Field,
  Button,
  Uploader 
} from "vant";

//公共css文件
import "@/assets/css/common.css";
//字体图标css文件
import "@/assets/css/iconfont.css";
//淘宝无线适配
import "@/assets/js/flexible";

//ly-tab插件
import LyTab from "ly-tab";
Vue.use(LyTab);
Vue.use(ElementUI);
Vue.use(Checkbox, CheckboxGroup);
Vue.use(Stepper);
Vue.use(AddressEdit);
Vue.use(Radio);
Vue.use(RadioGroup);
Vue.use(Empty);
Vue.use(Badge);
Vue.use(Field);
Vue.use(Uploader);
Vue.use(Button);
//全局引入mint-ui
import MintUI from "mint-ui";
import "mint-ui/lib/style.css";
Vue.use(MintUI);

import fastClick from "fastclick";
fastClick.attach(document.body);

Vue.config.productionTip = false;

new Vue({
  router,
  store,
  render: (h) => h(App),
}).$mount("#app");
