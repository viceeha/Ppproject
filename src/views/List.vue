<template>
  <div class="list">
    <header>
      <div class="returns">
        <i class="iconfont icon-sousuo"></i>
      </div>
      <div class="search">
        <i class="iconfont icon-sousuo"></i>
        <span>搜您喜欢的...</span>
      </div>
      <div class="go-home">
        <img src="@/assets/images/home.png" alt @click="$router.push('/home')" />
      </div>
    </header>
    <section>
      <div class="list-l" ref="left">
        <ul class="l-item" v-for="(item, index) in leftData" :key="index">
          <li :class="{ active: index == currentIndex }" @click="goScroll(index)">{{ item.name }}</li>
        </ul>
      </div>

      <div class="list-r" ref="right">
        <div>
          <ul v-for="(item, index) in rightData" :key="index">
            <li class="shop-list" v-for="(idd, ink) in item" :key="ink">
              <h2>{{ idd.name }}</h2>
              <ul class="r-content">
                <li v-for="(i, innk) in idd.list" :key="innk">
                  <img :src="i.imgUrl" alt />
                  <span>{{ i.name }}</span>
                </li>
              </ul>
            </li>
          </ul>
        </div>
      </div>
    </section>
    <Tabbar></Tabbar>
  </div>
</template>

<script>
import BetterScroll from 'better-scroll'
import Tabbar from '@/components/common/Tabbar.vue'
import http from '@/common/api/request.js'
export default {
  name: 'List',
  data() {
    return {
      leftData: [], //左侧数据
      rightData: [], //右侧数据
      rightBScroll: '', //右侧滑动BScroll
      allHeight: [], //承载右侧每一块的高度值
      scrollY: '', //右侧滚动距离
    }
  },
  computed: {
    currentIndex() {
      return this.allHeight.findIndex((item, index) => {
        return this.scrollY >= item && this.scrollY < this.allHeight[index + 1]
      })
    },
  },
  async created() {
    const res = await http.$axios({
      url: '/api/goods/list',
    })
    let leftArr = []
    let rightArr = []

    res.forEach((x) => {
      leftArr.push({
        id: x.id,
        name: x.name,
      })
      rightArr.push(x.data)
    })
    this.leftData = leftArr
    this.rightData = rightArr
    // console.log(this.rightData );
    this.$nextTick(() => {
      //左侧滑动
      new BetterScroll(this.$refs.left, {
        click: true,
        bounce: false,
      })
      //右侧滑动
      this.rightBScroll = new BetterScroll(this.$refs.right, {
        click: true,
        probeType: 3,
        bounce: false,
      })
      //统计右侧所有板块高度值，并且放入数组中
      let height = 0
      this.allHeight.push(height)
      //获取右侧每一块高度
      let uls = this.$refs.right.getElementsByClassName('shop-list')
      //把dom对象转换成功真正的数组
      Array.from(uls).forEach((v) => {
        height += v.clientHeight
        this.allHeight.push(height)
      })
      //得到右侧滚动的值
      this.rightBScroll.on('scroll', (pos) => {
        this.scrollY = Math.abs(pos.y)
      })
    })
  },
  methods: {
    goScroll(index) {
      this.rightBScroll.scrollTo(0, -this.allHeight[index], 300)
    },
  },
  components: {
    Tabbar,
  },
}
</script>

<style lang="less" scoped>
.list {
  display: flex;
  flex-direction: column;
  width: 100vw;
  height: 100vh;
}
header {
  display: flex;
  justify-content: space-around;
  align-items: center;
  height: 1.173333rem;
  background-color: #b0352f;
  .returns {
    i {
      color: #fff;
      font-size: 0.693333rem;
      padding-right: 0.2rem;
      line-height: 1.173333rem;
    }
  }
  .search {
    display: flex;
    flex: 1;
    align-items: center;
    justify-items: center;
    padding: 0.16rem 0.266666rem;
    background-color: #ffffff;
    border-radius: 0.64rem;

    i {
      padding-right: 0.16rem;
      color: #666;
      font-size: 0.48rem;
    }
    span {
      color: #666;
      font-size: 0.373333rem;
    }
  }
  .go-home {
    margin-right: 0.2rem;
    img {
      width: 1rem;
      height: 1rem;
    }
  }
}
section {
  display: flex;
  flex: 1;
  overflow: hidden;
  .list-l {
    width: 2.48rem;
    background-color: #fff;
    border-right: 1px solid #cccccc;
    overflow: hidden;
    .l-item {
      display: flex;
      justify-content: center;
      align-items: center;
      flex-direction: column;
      li {
        line-height: 1.333333rem;
        width: 100%;
        text-align: center;
        font-size: 0.373333rem;
        &.active {
          color: #b54f4a;
          border-left: 6px solid #b54f4a;
        }
      }
    }
  }
  .list-r {
    flex: 1;
    overflow: hidden;

    ul {
      .shop-list {
        text-align: center;
        h2 {
          padding: 0.533333rem 0;
          font-size: 0.64rem;
          font-weight: 400;
        }
        .r-content {
          display: flex;
          flex-wrap: wrap;
          align-items: center;

          li {
            display: flex;
            flex-direction: column;
            align-items: center;
            width: 33.33%;
            padding: 0.266666rem 0;

            img {
              width: 1.413333rem;
              height: 1.413333rem;
            }
            span {
              font-size: 0.426666rem;
            }
          }
        }
      }
    }
  }
}
::v-deep.tabbar {
  border-top: 1px solid #cccccc;
}
</style>
