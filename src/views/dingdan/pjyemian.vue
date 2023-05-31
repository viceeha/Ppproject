<template>
  <div>
    <Header><span>发表评价</span></Header>
    <section>
      <div class="header">
        <img :src="list.goods_imgUrl" alt="" />
        <div class="title">
          <h1>{{ list.goods_name }}</h1>
          <div>{{ list.order_id }}</div>
        </div>
      </div>

      <div class="pj">
        <van-field
          v-model.trim="value"
          rows="2"
          autosize
          type="textarea"
          left-icon="edit"
          maxlength="200"
          show-word-limit
          placeholder="从多个角度评价宝贝,可以帮助更多想买的人"
        />
      </div>
      <div class="but">
        <div></div>
        <van-button type="primary" class="vanbutton" @click="sub"
          >提交</van-button
        >
      </div>
    </section>
  </div>
</template>

<script>
import Header from "@/components/path/Header.vue";
import http from "@/common/api/request.js";
import { Toast } from "mint-ui";
export default {
  data() {
    return {
      value: "",
      list: [],
    };
  },
  components: {
    Header,
  },
  created() {
    this.list = this.$route.query;
  },
  methods: {
    sub() {
      if(!this.value){
      return  Toast("请填写评价");
      } 
      const subinfo = { 
        id:this.$route.query.id,
        neir:this.value       
        };
       http
        .$axios({
          url: "/api/PJgoods",
          method: "post",
          headers: {
            token: true,
          },
          data: {
            userinfo: subinfo,
          },
        })
        .then((res) => {
        if(res.code==200){
           Toast("评价成功");
           this.$router.back()
        }

          //   console.log(this.list);
        });
    },
  },
};
</script>

<style lang="less" scoped>
section {
  padding-top: 50px;
  .header {
    width: 100%;
    display: flex;
    align-items: center;
    justify-content: center;
    img {
      height: 100px;
      width: 100px;
    }
    .title {
      width: 290px;
      h1 {
        font-size: 0.4rem;
        color: #8a8a8a;
        white-space: nowrap;
        text-overflow: ellipsis;
        overflow: hidden;
      }
      div {
        font-size: 0.36rem;
        color: #b0b0b0;
        padding-top: 0.1rem;
      }
    }
  }
}
.but {
  width: 100%;
  display: flex;
  justify-content: space-between;
  margin-top: 50px;
}
</style>