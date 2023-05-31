<template>
  <div>
    <header>
      <i class="iconfont icon-xiangzuojiantou" @click="$router.back()"></i>
      <slot>
        <span>我的地址</span>
      </slot>
      <i class="iconfont icon-kefu"></i>
    </header>
  </div>
</template>

<script>
export default {};
</script>

<style lang="less" scoped>
header{
    display: flex;
    justify-content: space-between;
    align-items: center;
    position: fixed;
    z-index: 999;
    width: 100%;
    height: 1.173333rem;
    color:#fff;
    background-color: #b0352f;
        i{
        padding:0 0.4rem;
        font-size:0.586666rem;
    }
    span{
        font-weight:300;
        font-size:0.48rem;
    }
}
</style>