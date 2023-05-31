<template>
  <div class="my container">
    <header>
      <div class="user-info" v-if="loginStatus">
        <img :src="userimgd" @click="imgcheck" alt />
        <span>{{ userInfo.nickName }}</span>
      </div>
      <div v-else class="login" @click="goLogin">登录/注册</div>
    </header>
    <section>
      <div class="tabaicon">
        <ul>
          <li @click="godaifk">
            <van-badge :content="this.ddcdu" class="inconn">
              <div>
                <i class="iconfont icon-31daifukuan"></i>
                <span>待付款</span>
              </div>
            </van-badge>
          </li>

          <li @click="dsh">
            <van-badge :content="this.dshle" class="inconn">
              <i class="iconfont icon-daifahuo"></i>
              <span>待收货</span>
            </van-badge>
          </li>
          <li @click="pingjia">
            <van-badge :content="this.pj" class="inconn">
              <i class="iconfont icon-daipingjia"></i>
              <span>待评价</span>
            </van-badge>
          </li>
        </ul>
      </div>
      <ul>
        <li @click="goPath">
          <span>地址管理</span>
        </li>
        <li @click="godingdan">我的订单</li>
        <li v-if="loginStatus">
          <span @click="loginOut">安全退出</span>
        </li>
      </ul>
    </section>
    <Tabbar></Tabbar>

    <mt-popup v-model="popupVisible" popup-transition="popup-fade">
      <van-uploader>
				<van-button icon="plus" type="primary">上传文件</van-button>
      </van-uploader>
      <el-upload
        action="http://localhost:8082/api/hold/imgload"
        :on-remove="handleRemove"
        :before-remove="beforeRemove"
        multiple
        :limit="5"
        :on-exceed="handleExceed"
        :file-list="fileList"
        :on-success="uploadSuccess"
        :data="paramsData"
      >
        <el-button size="small" type="primary">点击上传</el-button>
      </el-upload>
    </mt-popup>

    <div style="padding-top: 250px"></div>
  </div>
</template>

<script>
// import { MessageBox } from 'mint-ui';
import Tabbar from '@/components/common/Tabbar.vue'
import { mapMutations, mapState } from 'vuex'
import http from '@/common/api/request.js'
export default {
  name: 'My',
  components: {
    Tabbar,
  },
  data() {
    return {
      ddcdu: '',
      dshle: '',
      pj: '',
      popupVisible: false,
      userimgd: null,
      paramsData: JSON.parse(localStorage.getItem('teaUserInfo')),

      fileList: [], //图片列表
      form: {
        num: 0,
        title: '',
        city: '',
        exhibitionType: '',
        extension: '',
        businessHours: '',
        location: '',
        name: '',
        number: '',
        imgBanner: '',
        img: [],
        content: '',
      },
    }
  },
  created() {
    this.ddcdu = window.localStorage.getItem('DFDCD')
    this.dshle = window.localStorage.getItem('DSH')
    this.pj = window.localStorage.getItem('PJ')
    if (localStorage.getItem('teaUserInfo')) {
      this.userimg()
    }
  },
  computed: {
    ...mapState({
      loginStatus: (state) => state.user.loginStatus,
      userInfo: (state) => state.user.userInfo,
      DFKDD: (state) => state.cart.DFKDD,
    }),
  },
  methods: {
    ...mapMutations(['loginOut']),
    goLogin() {
      this.$router.push('/login')
    },
    imgcheck() {
      this.popupVisible = true
    },
    userimg() {
      http
        .$axios({
          url: '/api/getuserimg',
          params: {
            id: this.paramsData,
          },
        })
        .then((res) => {
          console.log(res)
          this.userimgd = res.data[0].url
        })
        .catch((res) => {
          console.log(res)
        })
    },
    goPath() {
      this.$router.push('/path')
    },
    godingdan() {
      this.$router.push('/dingdan')
    },
    godaifk() {
      this.$router.push('/dfkdd')
    },
    dsh() {
      this.$router.push('/dsh')
    },
    pingjia() {
      this.$router.push('/pj')
    },
    uploadimg() {
      let userinfo = JSON.parse(localStorage.getItem('teaUserInfo'))
      console.log(userinfo)
    },
    //图片上传成功
    uploadSuccess(res, file) {
      //当上传的图片名为"banner.jpg"，则将图片路径赋给form.imgBanner，否则给form.img数组
      if (res.data.name === 'banner.jpg') {
        //我的banner图名字都叫banner.jpg
        this.form.imgBanner = res.data.path
        console.log(file)
      } else {
        this.form.img.push(res.data.path)
        this.popupVisible = false
        this.userimg()
      }
    },
    //删除图片时
    handleRemove(file, fileList) {
      console.log(file, fileList, '1111111')
      //删除图片时也要把form.imgBanner和form.img里的数据删除
      if (file.name === 'banner.jpg') {
        this.form.imgBanner = ''
      } else {
        //给数组封装一个方法，用来删除数组中指定的数据
        Array.prototype.contains = function (obj) {
          var i = this.length
          while (i--) {
            if (this[i] === obj) {
              return i // 返回的这个 i 就是元素的索引下标，
            }
          }
          return false
        }
        const path = file.response.data.path
        this.form.img.splice(this.form.img.contains(path), 1)
        // console.log(this.form.img,'删除后的form.img')
      }
    },
    handleExceed(files, fileList) {
      this.$message.warning(
        `当前限制选择 5 个文件，本次选择了 ${files.length} 个文件，共选择了 ${
          files.length + fileList.length
        } 个文件`
      )
    },
    beforeRemove(file, fileList) {
      this.$confirm(`确定移除 ${file.name}？`)
      console.log(fileList)
    },
  },
}
</script>

<style lang="less" scoped>
header {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 100%;
  height: 4.266666rem;
  background-color: #b64f4a;

  .login {
    color: #fff;
    background-color: #f6ab32;
    border-radius: 6px;
    padding: 0.16rem 0.4rem;
    font-size: 0.426666rem;
  }

  .user-info {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;

    img {
      width: 1.76rem;
      height: 1.76rem;
      border-radius: 50%;
    }

    span {
      padding: 0.533333rem 0;
      font-size: 0.48rem;
      color: #fff;
    }
  }
}

section {
  flex: 1;
  overflow: hidden;

  ul li {
    padding: 0.4rem;
    font-size: 0.426666rem;
  }

  .tabaicon {
    background-color: #f5f5f5;

    ul {
      display: flex;
      justify-content: space-around;

      li {
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;

        span {
          font-size: 0.3rem;
        }

        div {
          display: flex;
          flex-direction: column;
          justify-content: center;
          align-items: center;
        }

        i {
          font-size: 0.8rem;
        }
      }
    }
  }
}
</style>
