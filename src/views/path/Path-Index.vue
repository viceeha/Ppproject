<template>
  <div class="path-index container">
    <Header></Header>
    <section>
      <ul v-if="list.length">
        <li @click="goList(item)" v-for="(item, index) in list" :key="index">
          <div>
            <span>{{ item.name }}</span>
            <span>{{ item.tel }}</span>
          </div>
          <div class="city">
            <span class="active" v-if="item.isDefault == 1">[默认]</span>
            <span>{{ item.province }}</span>
            <span>{{ item.city }}</span>
            <span>{{ item.county }}</span>
            <span>{{ item.addressDetail }}</span>
          </div>
        </li>
      </ul>
      <h1 v-else>
       <van-empty description=" 暂无数据，请添加地址" />
      </h1>
      <div class="add-path" @click="goList('add')" v-if="tianjiabut">
        添加地址
      </div>
    </section>
    <Tabbar></Tabbar>
  </div>
</template>

<script>
import Header from "@/components/path/Header.vue";
import Tabbar from "@/components/common/Tabbar.vue";
import { mapState, mapMutations } from "vuex";
import http from "@/common/api/request.js";
import bus from "@/common/bus.js";
export default {
  data() {
    return {
      pathStatus: false,
      tianjiabut: true,
    };
  },
  methods: {
    ...mapMutations(["initData"]),
    getData() {
      http
        .$axios({
          url: "/api/selectAddress",
          method: "post",
          headers: {
            token: true,
          },
        })
        .then((res) => {
          this.initData(res.data);
        });
    },
    goList(option) {
      //this.pathStatus为true代表从订单页面进入的：选择状态
      if (this.pathStatus) {
        bus.$emit("selectPath", JSON.stringify(option));
        this.$router.back();
        return;
      }

      this.$router.push({
        name: "path-list",
        query: {
          key: JSON.stringify(option),
          goodsList: JSON.stringify(this.selectList),
        },
      });
    },
  },
  created() {
    // 从订单页面进来的
    if (this.$route.query.type == "select") {
      this.pathStatus = true;
      this.tianjiabut = false;
    }
    this.getData();
  },
  computed: {
    ...mapState({
      list: (state) => state.path.list,
      selectList: (state) => state.path.selectList,
    }),
  },
  components: {
    Tabbar,
    Header,
  },
};
</script>

<style scoped lang="less">
section {
  display: flex;
  flex-direction: column;
  align-items: center;
  background-color: #f7f7f7;
  margin-top: 50px;
  ul {
    width: 100%;
    li {
      padding: 0.266666rem 0.4rem;
      margin: 0.16rem 0;
      background-color: #ffffff;
      span {
        padding-right: 0.4rem;
        font-size: 0.426666rem;
      }
      .active {
        color: #b0352f;
      }
      .city {
        span {
          padding-right: 0.16rem;
        }
      }
    }
  }
  .add-path {
    margin-top: 0.8rem;
    width: 3.2rem;
    line-height: 1.066666rem;
    font-size: 0.48rem;
    text-align: center;
    color: #ffffff;
    background-color: #b0352f;
    border-radius: 6px;
  }
  ::v-deep .tabbar {
    border-top: 2px solid #ccc;
  }
}
</style>