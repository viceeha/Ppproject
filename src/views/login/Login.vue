<template>
  <div class="login container">
    <Header></Header>
    <section>
      <div class="login-tel">
        <input
          type="text"
          v-model="userTel"
          placeholder="请输入手机号"
          pattern="[0-9]*"
        />
      </div>
      <div class="login-code">
        <input
          type="text"
          placeholder="请输入短信验证码"
          pattern="[0-9]*"
          v-model="userCode"
        />
        <div class="but">
          <button
            :disabled="disabled"
            @click="sendCode"
            :style="disabled ? 'background-color: #ccc; color:#B0352F' : ''"
          >
            {{ codeMsg }}
          </button>
        </div>
      </div>
      <div class="login-btn" @click="login">登 录</div>
      <div class="tab">
        <span @click="goUserLogin">密码登录</span>
        <span @click="goRegister">快速注册</span>
      </div>
    </section>
    <Tabbar></Tabbar>
  </div>
</template>

<script>
import Tabbar from "@/components/common/Tabbar.vue";
import Header from "./Header";
import { Toast } from "mint-ui";
import http from "@/common/api/request.js";
import {mapMutations} from 'vuex'
export default {
  data() {
    return {
      disabled: false,
      userTel: "",
      userCode: "",
      //验证规则
      rules: {
        //手机号验证
        userTel: {
          rule: /^1[23456789]\d{9}$/,
          msg: "手机号不能为空，并且是11位数字",
        },
      },
      codeMsg: "获取短信验证码",
      codeNum: 60,
      code: "",
    };
  },
  components: {
    Header,
    Tabbar,
  },
  methods: {
        ...mapMutations(['userLogin']),
    goUserLogin() {
      this.$router.push("/userLogin");
    },
    sendCode() {
      //验证
      if (!this.validate("userTel")) return;
      //请求短信验证码接口
      http
        .$axios({
          url: "/api/code",
          method: "POST",
          data: {
            phone: this.userTel,
          },
        })
        .then((res) => {
          console.log(res);
          if (res.success) {
            this.code = res.data;
          }
        });
      // console.log(this.code);
      //禁用按钮
      this.disabled = true;
      //倒计时
      this.codeMsg = "重新发送";
      let timer = setInterval(() => {
        --this.codeNum;
        this.codeMsg = `重新发送(${this.codeNum}s)`;
      }, 1000);
      //判断什么时候停止定时器
      setTimeout(() => {
        clearTimeout(timer);
        this.disabled = false;
        this.codeNum = 60;
        this.codeMsg = "获取短信验证码";
      }, 60000);
    },
    //验证信息提示
    validate(key) {
      let bool = true;
      if (!this.rules[key].rule.test(this[key])) {
        //提示信息
        Toast(this.rules[key].msg);
        bool = false;
        return false;
      }
      return bool;
    },
    //点击登录
    login() {
      if (this.code == this.userCode) {
        //证明用户输入的短信验证码是正确的
        //发送请求
        http
          .$axios({
            url: "/api/addUser",
            method: "POST",
            data: {
              phone: this.userTel,
            },
          })
          .then((res) => {
            if (!res.success) return;
            //登录成功 ==》跳转页面，存储用户信息
            this.userLogin(res.data);
            //跳转到我的页面中
            this.$router.push("/my");
          });
      } else {
        Toast("验证码错误");
      }
    },
    //注册
    goRegister() {
      this.$router.push("/register");
    },
  },
};
</script>


<style lang="less" scoped>
section {
  display: flex;
  flex-direction: column;
  align-items: center;
  background-color: #f5f5f5;
  font-size: 16px;
  div {
    margin: 0.266666rem 0;
    width: 8.933333rem;
    height: 1.173333rem;
  }
  input {
    box-sizing: border-box;
    padding: 0 0.266666rem;
    line-height: 1.173333rem;
    background-color: #ffffff;
    border: 1px solid #ccc;
    border-radius: 6px;
    font-size: 16px;
  }
  .login-tel {
    margin-top: 0.8rem;
    input {
      width: 8.933333rem;
    }
  }
  .login-code {
    display: flex;
    align-items: center;
    .but {
      display: flex;
      border-radius: 6px;
      height: 1.173333rem;
      overflow: hidden;
      button {
        height: 100%;
        width: 100%;
        color: #fff;
        background-color: #b0352f;
        border: none;
      }
    }
  }
  .login-btn {
    line-height: 44px;
    color: #fff;
    text-align: center;
    background-color: #b0352f;
    border-radius: 6px;
  }
  .tab {
    display: flex;
    justify-content: space-between;
    font-size: 0.373333rem;
  }
}
</style>