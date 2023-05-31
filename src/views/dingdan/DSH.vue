<template>
  <div>
    <Header><span>待收货</span></Header>
    <section>
      <div class="dingdan1" v-if="list.length">
        <ul>
          <li v-for="(item, index) in list" :key="index">
            <header></header>
            <body>
              <div class="body-left">
                <img
                  :src="item.goods_imgUrl"
                  alt=""
                  @click="goDetail(item.goods_name)"
                />
              </div>
              <div class="body-right">
                <div class="body-right_lrft">
                  <h5>{{ item.goods_name }}</h5>
                  <span>待收货</span>
                </div>
                <div class="body-right_right">
                  <div>￥{{ item.goods_price }}</div>
                  <span>×{{ item.goods_num }}</span>
                </div>
              </div>
            </body>
            <footer>
              <div class="menni">
                已付款<span>￥{{ item.goods_price }}</span>
              </div>
              <div class="mor">
                <div class="mor-file">更多</div>
                <div class="mor-right">
                  <span @click="EDit(item)">确定收货</span>
                </div>
              </div>
            </footer>
          </li>
        </ul>
      </div>

      <div v-else>
        <van-empty description="没有待付款订单" class="bottom-button">
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
import { Dialog } from "vant";
import { mapMutations } from "vuex";
export default {
  data() {
    return {
      list: [],
    };
  },
  components: {
    Header,
    Tabbar,
  },
  created() {
    this.selectuserOrder();
  },
  methods: {
    ...mapMutations(["SELECTDSH"]),
    //查询订单
    selectuserOrder() {
      http
        .$axios({
          url: "/api/selectuserOrder",
          method: "post",
          headers: {
            token: true,
          },
          data: {
            id: 2,
          },
        })
        .then((res) => {
          this.list = res.data;
          this.SELECTDSH(res.data);
          //   console.log(this.list);
        });
    },
    //从购物车前往商品详情
    goDetail(name) {
      http
        .$axios({
          url: "/api/selectshapinid",
          method: "post",
          headers: {
            token: true,
          },
          data: {
            name: name,
          },
        })
        .then((res) => {
          console.log(res);
          this.$router.push({
            path: "/detail",
            query: {
              id: res,
            },
          });
        });
    },
    //确定收货
    EDit(row) {
      console.log(row);
      Dialog.confirm({
        message: "是否确定收货？",
      }).then(() => {
        http
          .$axios({
            url: "/api/quedingrOrder",
            method: "post",
            headers: {
              token: true,
            },
            data: {
              id: row.id,
            },
          })
          .then((res) => {
            if (res.code == 200) {
              this.selectuserOrder();
            }
          });
      });
    },
  },
};
</script>

<style lang='less' scoped>
* {
  padding: 0;
  margin: 0;
}
.bottom-button {
  margin-top: 50%;
}

section {
  background-color: #f0f0f0;
  overflow: hidden;
  padding-bottom: 60px;

  .dingdan1 {
    padding-top: 60px;
    ul {
      li {
        background-color: #ffffff;
        border-radius: 10px;
        height: 200px;
        margin-bottom: 10px;
        header {
          color: #ec652e;
          font-size: 00.385rem;
          text-align: right;
          margin-right: 10px;
          padding: 6px 0;
        }
        body {
          display: flex;
          .body-left {
            width: 100px;
            height: 90px;
            background-color: red;
            margin: 0 10px;
            img {
              width: 100%;
              height: 100%;
            }
          }
          .body-right {
            display: flex;
            .body-right_lrft {
              width: 240px;
              padding-right: 10px;
              h5 {
                font-size: 0.4rem;
                white-space: nowrap;
                text-overflow: ellipsis;
                overflow: hidden;
              }
              span {
                font-size: 00.4rem;
                color: #e7ab55;
              }
            }
            .body-right_right {
              font-size: 00.45rem;
              text-align: right;
              span {
                color: #ccc;
              }
            }
          }
        }
        footer {
          .menni {
            font-size: 0.5rem;
            font-weight: 600;
            text-align: right;
            span {
            }
          }
          .mor {
            display: flex;
            justify-content: space-between;
            font-size: 00.5rem;
            padding-top: 10px;
            .mor-file {
              color: #ccc;
              padding-left: 16px;
            }
            .mor-right {
              span {
                border: 1px solid #e7ab55;
                padding: 6px;
                color: #e7ab55;
                border-radius: 20px;
                margin-right: 16px;
              }
            }
          }
        }
      }
    }
  }
}
</style>