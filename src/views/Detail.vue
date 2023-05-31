<template>
  <div class="detail">
    <header>
      <div class="header-returns" v-show="isShow">
        <div @click="goBack">
          <i class="iconfont icon-xiangzuojiantou"></i>
        </div>
        <div>
          <i class="iconfont icon-kefu"></i>
        </div>
      </div>
      <div class="header-bar" v-show="!isShow" :style="styleOption">
        <div @click="goBack">
          <i class="iconfont icon-xiangzuojiantou"></i>
        </div>
        <div>
          <span>商品详情</span>
          <span>商品评价</span>
        </div>
        <div>
          <i class="iconfont icon-kefu"></i>
        </div>
      </div>
    </header>
    <section ref="wrapper">
      <div>
        <div class="swiper-main">
          <swiper :options="swiperOption">
            <swiper-slide>
              <img :src="goods.imgUrl" alt />
            </swiper-slide>
          </swiper>
          <div class="swiper-pagination"></div>
        </div>

        <div class="goods-name">
          <h1>{{ goods.name }}</h1>
          <div>性价首选，茶感十足、鲜醇耐泡的大众口粮茶</div>
        </div>
        <div class="goods-price">
          <div class="oprice">
            <span>￥</span>
            <b>{{ goods.price }}</b>
          </div>
          <div class="pprice">
            <span>价格:</span>
            <del>¥{{ `${Math.trunc(goods.price * 1.2)}` }}</del>
          </div>
        </div>
        <div>
          <ul class="PJ">
            <h3>评价</h3>
            <li v-for="(item, index) in pjlist" :key="index">
              <div class="time">
                <div class="imggg">
                  <img src="@/assets/images/tea.png" alt />
                </div>
                <div class="userinfo">
                  <div>{{ item.user }}</div>
                  <span>{{ formatDate(item.time) }}</span>
                </div>
              </div>
              <div class="PJNR">用户评价:{{ item.Pj }}</div>
            </li>
          </ul>
        </div>

        <div>
          <img style="width: 100%; height: 500px" :src="goods.imgUrl" alt />
        </div>
      </div>
    </section>
    <footer>
      <div class="add-cart" @click="addCart">加入购物车</div>
      <div @click="goCart">立即购买</div>
    </footer>
  </div>
</template>

<script>
import 'swiper/dist/css/swiper.css'
import { swiper, swiperSlide } from 'vue-awesome-swiper'
import BetterScroll from 'better-scroll'
import { Toast } from 'mint-ui'
import http from '@/common/api/request.js'
import { mapGetters, mapState } from 'vuex'
export default {
  data() {
    return {
      id: 0,
      goods: {},
      styleOption: {},
      BetterScroll: '',
      isShow: true,
      swiperOption: {
        //swiper3
        autoplay: 3000,
        speed: 1000,
        pagination: {
          el: '.swiper-pagination',
          type: 'fraction',
        },
      },
      pjlist: [],
    }
  },
  computed: {
    ...mapState({
      list: (state) => state.cart.list,
    }),
    ...mapGetters(['total']),
  },
  created() {
    this.id = this.$route.query.id
    this.getData()
    this.selectPj()
  },
  methods: {
    formatDate(time) {
      var data = new Date(time)
      var y = data.getFullYear()
      var m = data.getMonth() + 1
      var d = data.getDate()
      var h = data.getHours()
      var mi = data.getMinutes()
      var s = data.getSeconds()
      m = m < 10 ? '0' + m : m
      d = d < 10 ? '0' + d : d
      h = h < 10 ? '0' + h : h
      s = s < 10 ? '0' + s : s
      return y + '-' + m + '-' + d + ' ' + h + ':' + mi + ':' + s
    },
    async getData() {
      let id = this.$route.query.id
      let res = await http.$axios({
        url: '/api/goods/id',
        params: {
          id,
        },
      })
      this.goods = res
      // console.log(this.goods);
    },
    async selectPj() {
      let id = this.$route.query.id
      http
        .$axios({
          url: '/api/byidorderPj',
          method: 'post',
          data: {
            goodsId: id,
          },
          headers: {
            token: true,
          },
        })
        .then((res) => {
          this.pjlist = res
          console.log(this.pjlist)
        })
    },

    goBack() {
      this.$router.back()
    },
    //加入购物车
    addCart() {
      // console.log(localStorage.getItem('teaUserInfo'))
      // if (!JSON.parse(localStorage.getItem('teaUserInfo'))) {
      //   return this.$router.push('/my')
      // }

      let id = this.$route.query.id
      http
        .$axios({
          url: '/api/addCart',
          method: 'post',
          data: {
            goodsId: id,
          },
          headers: {
            token: true,
          },
        })
        .then((res) => {
          if (res.success) {
            Toast('添加购物车成功')
          }
        })
    },
    //立即购买
    goCart() {
      // if (!JSON.parse(localStorage.getItem('teaUserInfo')))
      //   return this.$router.push('/my')
      let id = this.$route.query.id
      http
        .$axios({
          url: '/api/addCart',
          method: 'post',
          data: {
            goodsId: id,
          },
          headers: {
            token: true,
          },
        })
        .then((res) => {
          console.log(res)
          if (res.success) {
            Toast('添加购物车成功')
          }
          this.$router.push('/cart')
        })
    },
  },
  activated() {
    //判断当前url , id和之前id是否一致
    if (this.$route.query.id != this.id) {
      this.getData()
      this.id = this.$route.query.id
    }
  },
  mounted() {
    this.BetterScroll = new BetterScroll(this.$refs.wrapper, {
      probeType: 3,
      bounce: false,
      click: true,
    })
    this.BetterScroll.on('scroll', (pos) => {
      let posY = Math.abs(pos.y)
      let opacity = posY / 180
      opacity = opacity > 1 ? 1 : opacity
      this.styleOption = {
        opacity: opacity,
      }

      //   console.log(posY);
      if (posY >= 50) {
        this.isShow = false
      } else {
        this.isShow = true
      }
    })
  },

  components: {
    swiper,
    swiperSlide,
  },
}
</script>

<style lang="less" scoped>
.detail {
  display: flex;
  flex-direction: column;
  width: 100vw;
  height: 100vh;
  overflow: hidden;
}
header {
  position: fixed;
  left: 0;
  top: 0;
  z-index: 999;
  width: 100%;
  height: 1.173333rem;
  .header-returns {
    display: flex;
    justify-content: space-between;
    align-items: center;
    width: 100%;
    height: 1.173333rem;
    div {
      margin: 0 0.266666rem;
      width: 0.933333rem;
      line-height: 0.906666rem;
      text-align: center;
      background-color: rgba(0, 0, 0, 0.3);
      border-radius: 50%;
    }
    i {
      font-size: 0.693333rem;
      color: #fff;
    }
  }
  .header-bar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    width: 100%;
    height: 1.173333rem;
    font-size: 0.426666rem;
    background-color: #fff;
    span {
      padding: 0 0.266666rem;
    }
    i {
      padding: 0 0.266666rem;
      font-size: 0.586666rem;
    }
  }
}
section {
  flex: 1;
  overflow: hidden;
}
.swiper-main {
  position: relative;
  width: 100%;
  height: 10rem;
  overflow: hidden;
}
.swiper-container {
  width: 100%;
  height: 10rem;
}
.swiper-container img {
  width: 100%;
  height: 10rem;
}
.swiper-pagination {
  bottom: 0.266666rem;
  width: 100%;
  text-align: right;
  color: #ffffff;
  font-size: 0.426666rem;
}
.swiper-pagination-fraction,
.swiper-pagination-custom,
.swiper-container-horizontal > .swiper-pagination-bullets {
  left: -0.533333rem;
}
.goods-name {
  padding: 0.533333rem 0.266666rem;
  border-bottom: 1px solid #cccccc;
  h1 {
    font-size: 0.533333rem;
    font-weight: 500;
  }
  div {
    padding: 0.08rem 0;
    font-size: 0.373333rem;
    color: #999999;
  }
}
.goods-price {
  padding: 0.533333rem 0.266666rem;
  .oprice {
    color: red;
    span {
      font-size: 0.32rem;
    }
  }
  .pprice {
    color: #999999;
    font-size: 0.373333rem;
  }
}
footer {
  display: flex;
  justify-content: center;
  align-items: center;
  position: fixed;
  bottom: 0;
  left: 0;
  width: 100%;
  height: 1.306666rem;
  border-top: 1px solid #cccccc;
  background-color: #fff;
  div {
    width: 50%;
    line-height: 1.306666rem;
    font-size: 0.426666rem;
    text-align: center;
    color: #fff;
    background-color: red;
    &.add-cart {
      background-color: #ff9500;
    }
  }
}
.PJ {
  li {
    margin-bottom: 10px;
    background-color: #ffffff;
    border-radius: 10px;
    h3 {
      background-color: #ccc;
    }
    .time {
      display: flex;
      align-items: center;
      padding-top: 5px;
      .imggg {
        width: 60px;
        height: 60px;
        border-radius: 50%;
        overflow: hidden;
        margin-right: 10px;
        img {
          width: 100%;
          height: 100%;
        }
      }
      .userinfo {
        div {
          font-size: 0.6rem;
        }
        span {
          font-size: 00.32rem;
        }
        line-height: 0.6rem;
      }
    }
    .PJNR {
      font-size: 0.4rem;
      padding: 0.3rem;
    }
  }
}
</style>
