<template>
  <div>
    <div v-if="payStatus" style="font-size: 48px">恭喜您支付成功~</div>
    <div v-else>支付失败</div>
    <div class="fanhui"><span @click="$router.push('/cart')">返回首页</span></div>
  </div>
</template>

<script>
import http from "@/common/api/request.js";
import qs from "qs";
export default {
  data() {
    return {
      payStatus: false,
    };
  },
  created() {
    this.getData();
  },
  methods: {
    getData() {
      let datas = {
        out_trade_no: this.$route.query.out_trade_no,
        trade_no: this.$route.query.trade_no,
      };
      http
        .$axios({
          url: "/api/successPayment",
          method: "post",
          headers: {
            token: true,
          },
          data: qs.stringify(datas),
        })
        .then((res) => {
          console.log(res);
          if (res.code == 2) {
            this.payStatus = true;
          }
        });
    },
  },
};
</script>

<style lang="less" scoped>
.fanhui {
  position: absolute;
  top: 50%;
  text-align: center;
  font-size: 60px;
  height: 100px;
  width: 100%;
  overflow: hidden;

  span {
    align-items: center;
    background-color: #1890ff;
    border-radius: 16px;
    color: #ffffff;
    padding: 10px;
  }
}
</style>
