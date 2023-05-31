<template>
  <div class="html">
    <Header><span>我的订单</span></Header>
    <section ref="wrapper">
      <div class="section" v-if="uidlist.length">
        <ul>
          <li v-for="(item, index) in uidlist" :key="index">
            <div class="head">订单号:{{ item.order_id }}</div>
            <div class="sectionbody">
              <div class="ddanleft">
                <img :src="item.goods_imgUrl " alt="" />
              </div>
              <div class="ddanright">
                <div class="title">{{item.goods_name}}</div>
                <div class="goods_price">
                  <span> <span class="qian">￥</span> {{item.goods_price}}</span>
                  <b>×{{item.goods_num}}</b>
                </div>
              </div>
            </div>
            <div class="sectionfont">
              <div style="margin-left: 160px">
                <span>七天无忧包退换</span>
                <span>15天价保</span>
              </div>
              <div class="moni">
                实付款<span class="qian">￥</span><b>{{item.goods_price}}</b>
              </div>
            </div>
          </li>
        </ul>
      </div>
      <div v-else>
        <van-empty description="没有订单" class="bottom-button">       
        </van-empty>
      </div>
    </section>
    <Tabbar></Tabbar>
  </div>
</template>

<script>
import Header from "@/components/path/Header.vue";
import Tabbar from "@/components/common/Tabbar.vue";
import http from "@/common/api/request.js";
import { mapMutations } from "vuex";
export default {
  data() {
    return {
      uidlist: [],
    };
  },
  components: {
    Header,
    Tabbar,
  },
  created() {
    this.selectuserOrder();
  },
  mounted() {
    console.log(this.uidlist);
  },
  computed: {},
  methods: {
    ...mapMutations(["selectOrder"]),
    //查询订单
    selectuserOrder() {
      http
        .$axios({
          url: "/api/selectuserOrder",
          method: "post",
          headers: {
            token: true,
          },
          data:{
            id:2
          }
        })
        .then((res) => {
          this.selectOrder(res.data);
          this.uidlist = res.data;
        });
    },
  },
};
</script>

<style lang="less" scoped>
* {
  padding: 0;
  margin: 0;
}

.html {
  background-color: #f0f0f0;
  height: 100vh;
}
.bottom-button{
  margin-top: 50%;
}
section {
  .section {
    padding-bottom: 50px;
  }
  ul {
    margin-top: 50px;
    li {
      display: flex;
      align-items: center;
      justify-content: space-between;
      background-color: #ffffff;
      flex-direction: column;
      margin-bottom: 10px;
      border-radius: 20px;
      padding-bottom: 20px;
      .ddanleft {
        img {
          width: 140px;
          height: 140px;
          margin-top: 20px;
          margin-right: 30px;
        }
      }
      .head {
        text-align: left;
        margin-bottom: -20px;
        font-size: 0.403333rem;
        color: #999999;
        width: 100%;
        margin-left: 10px;
      }
      .sectionbody {
        display: flex;
        align-items: center;
      }
      .ddanright {
        display: flex;
        .title {
          font-size: 0.485rem;
          color: #111111;
          font-weight: 600;
          flex-wrap: wrap;
          width: 150px;
        }
      }
      .goods_price {
        display: flex;
        flex-direction: column;
        text-align: right;
      
        .qian {
          font-size: 0.43333rem;       
          margin-right: -6px; 
        }
        span {
          font-size: 0.63333rem;

        }
        b {
          color: #9c9c9c;
          font-size: 0.43333rem;
        }
      }
      .sectionfont {
        font-size: 00.433333rem;
        margin-top: -30px;
        width: 100%;
        span {
          border: 1px solid #ec612a;
          margin-left: 10px;
          color: #ec612a;
        }
        .moni {
          text-align: right;
          border: 0;
          color: #111111;
          font-size: 00.483333rem;
          margin-top: 10px;
          margin-right: 5px;
          .qian {
            border: 0;
            color: #111111;
            margin: 0;
            font-size: 00.403333rem;
          }
        }
      }
    }
  }
}
</style>