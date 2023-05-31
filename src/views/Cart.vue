<template>
  <div class="cart container">
    <header>
      <i
        class="iconfont icon-xiangzuojiantou"
        @click="$router.push('/home')"
      ></i>
      <span>购物车</span>
      <span @click="isNavBar" v-text="isNavStatus ? '完成' : '编辑'"></span>
    </header>
    <section v-if="list.length">
      <div class="cart-title">
        <van-checkbox @click="checkAllFn" :value="isCheckedAll"></van-checkbox>
        <span>商品</span>
      </div>
      <ul>
        <li v-for="(item, index) in list" :key="index">
          <div class="check">
            <van-checkbox
              @click="checkItem(index)"
              v-model="item.checked"
            ></van-checkbox>
          </div>
          <h2>
            <img
              :src="item.goods_imgUrl"
              alt=""
              @click="goDetail(item.goods_name)"
            />
          </h2>
          <div class="goods">
            <div class="goods-title">
              <span>{{ item.goods_name }}</span>
              <i
                class="iconfont icon-lajitong"
                @click="delGoodsFn(item.id)"
              ></i>
            </div>
            <div class="goods-price">¥{{ item.goods_price }}</div>
            <van-stepper
              @change="changeNum($event, item)"
              v-model="item.goods_num"
              integer
            />
          </div>
        </li>
      </ul>
    </section>
    <section v-else>
      <van-empty description="没有购物车数据" />
      <router-link to="/home">
        <div class="gohome"><span>去首页逛逛吧</span></div>
      </router-link>
    </section>
    <footer v-if="list.length">
      <div class="radio">
        <van-checkbox @click="checkAllFn" :value="isCheckedAll"></van-checkbox>
      </div>
      <div class="total" v-show="!isNavStatus">
        <div>
          共有
          <span class="total-active">{{ total.num }}</span>
          件商品
        </div>
        <div>
          <span>总计：</span>
          <span class="total-active"
            >¥{{ total.price.toFixed(2) }}(不含邮费)</span
          >
        </div>
      </div>
      <div class="order" v-if="isNavStatus" @click="delGoodsFn">删除</div>
      <div class="order" v-else @click="goOrder">去结算</div>
    </footer>
    <Tabbar></Tabbar>
  </div>
</template>

<script>
import http from "@/common/api/request.js";
import { Toast } from "mint-ui";
import { mapState, mapMutations, mapGetters, mapActions } from "vuex";
import Tabbar from "@/components/common/Tabbar.vue";
export default {
  name: "Cart",
  data() {
    return {
      value: "",
      isNavStatus: false,
      checked: true,
    };
  },
  components: {
    Tabbar,
  },
  computed: {
    ...mapState({
      list: (state) => state.cart.list,
      selectList: (state) => state.cart.selectList,
    }),
    ...mapGetters(["isCheckedAll", "total"]),
    goodsList() {
      return this.selectList.map((id) => {
        return this.list.find((v) => v.id == id);
      });
    },
  },
  created() {
    if (!JSON.parse(window.localStorage.getItem("teaUserInfo"))) return;
    this.getData();
  },
  methods: {
    ...mapMutations(["cartList", "checkItem", "initOrder"]),
    ...mapActions(["checkAllFn", "delGoodsFn"]),
    async getData() {
      let res = await http.$axios({
        url: "/api/selectCart",
        method: "post",
        headers: {
          token: true,
        },
      });

      res.data.forEach((v) => {
        v["checked"] = true;
      });

      this.cartList(res.data);
    },
    isNavBar() {
      this.isNavStatus = !this.isNavStatus;
    },
    changeNum(value, item) {
      //当前 购物车商品的 id以及  修改后的数量==》传递给后端
      //value 就是修改后的数量
      //item.id 就是购物车商品的id
      http.$axios({
        url: "/api/updateNum",
        method: "post",
        headers: {
          token: true,
        },
        data: {
          id: item.id,
          num: value,
        },
      });
    },
    //去结算
    goOrder() {
      if (!this.selectList.length) {
        Toast("请至少选择一件商品");
        return;
      } else {
        let newList = [];
        this.list.forEach((item) => {
          this.selectList.filter((v) => {
            if (v == item.id) {
              newList.push(item);
            }
          });
        });
        //生成一个订单
        http
          .$axios({
            url: "/api/addOrder",
            method: "post",
            headers: {
              token: true,
            },
            data: {
              arr: newList,
            },
          })
          .then((res) => {
            if (!res.success) return;
            //存储订单号
            this.initOrder(res.data);
            //进入提交订单页面
            this.$router.push({
              path: "/order",
              query: {
                detail: JSON.stringify(this.selectList),
                goodsList: JSON.stringify(this.goodsList),
              },
            });
            console.log(res.data);
          });
      }
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
  },
};
</script>

<style lang="less" scoped>
header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  height: 1.173333rem;
  color: #fff;
  background-color: #b0352f;
  i {
    padding: 0 0.4rem;
    font-size: 0.686666rem;
  }
  span {
    padding: 0 0.4rem;
    font-size: 0.526666rem;
  }
}
section {
  background-color: #f5f5f5;
  .cart-title {
    display: flex;
    padding: 0.533333rem;

    span {
      padding: 0 0.4rem;
      font-weight: 500;
      font-size: 0.48rem;
    }
  }

  ul {
    display: flex;
    flex-direction: column;

    li {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 0.16rem 0.533333rem;
      margin: 0.213333rem 0;
      background-color: #fff;
      .check {
        padding-right: 0.373333rem;
      }
      .goods {
        display: flex;
        flex-direction: column;
        padding-left: 0.4rem;
        font-size: 0.32rem;
        .goods-title {
          display: flex;
          i {
            font-size: 0.586666rem;
          }
        }
        .goods-price {
          padding: 0.08rem 0;
          color: #b0352f;
        }
        ::v-deep .van-stepper {
          text-align: right;
        }
      }
      img {
        width: 1.973333rem;
        height: 1.973333rem;
      }
    }
  }
  .gohome {
    text-align: center;
    width: 100%;
    background-color: #f5f5f5;
    color: black;
    span {
      background-color: #b0352f;
      padding: 10px;
      border-radius: 20px;
      color: #f5f5f5;
    }
  }
}

footer {
  position: absolute;
  bottom: 0;
  left: 0;
  display: flex;
  justify-content: space-between;
  align-items: center;
  height: 1.28rem;
  width: 100%;
  border-top: 0.053333rem solid #ccc;
  padding-bottom: 62px;
  .radio {
    display: flex;
    padding: 0 0.4rem;

    span {
      font-size: 14px;
      margin-left: 0.2rem;
    }
  }
  .total {
    flex: 1;
    font-size: 0.32rem;
    .total-active {
      color: #b0352f;
    }
  }
  .order {
    width: 3.2rem;
    line-height: 1.28rem;
    color: #fff;
    text-align: center;
    font-size: 0.426666rem;
    border-radius: 10px;
    background-color: #b0352f;
  }
}
</style>