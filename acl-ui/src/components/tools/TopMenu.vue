<template>
  <div class="top-menu" v-if="routes.length > 2">
    <span
      :class="current === route.name ? 'top-menu-selected' : ''"
      v-for="route in defaultShowRoutes"
      :key="route.name"
      @click="() => handleClick(route)"
    >
      {{ route.meta.title }}
    </span>
  </div>
</template>

<script>
import store from '@/store'
export default {
  name: 'TopMenu',
  data() {
    return {
      defaultShowRouteName: ['acl'],
      routes: store.getters.appRoutes.filter((i) => !(i.meta || {}).hiddenInTopMenu),
      current: store.getters.appRoutes[0].name,
      visible: false,
    }
  },
  computed: {
    defaultShowRoutes() {
      return this.routes.filter((item) => this.defaultShowRouteName.includes(item.name))
    },
  },
  watch: {
    $route: {
      immediate: true,
      deep: true,
      handler(newVal) {
        if (newVal) {
          this.current = newVal.matched[0].name
        }
      },
    },
  },
  mounted() {
    this.current = this.$route.matched[0].name
  },
  methods: {
    handleClick(route) {
      this.visible = false
      if (route.name !== this.current) {
        this.$router.push(route.redirect)
        // this.current = route.name
      }
    },
  },
}
</script>

<style lang="less">
@import '../../style/static.less';
// .top-menu {
//   display: inline-block;
// }
// .ant-menu-horizontal {
//   border-bottom: 0 !important;
// }
// .ant-menu-horizontal > .ant-menu-item {
//   border-bottom: 0;
// }

.top-menu {
  display: inline-flex;
  align-items: center;
  > .top-menu-icon {
    width: 40px;
    height: @layout-header-icon-height;
    line-height: @layout-header-icon-height;
    border-radius: 4px !important;
    display: inline-flex;
    align-items: flex-end;
  }
  > span {
    cursor: pointer;
    padding: 4px 10px;
    margin: 0 5px;
    border-radius: 4px;
    color: @layout-header-font-color;
    height: @layout-header-height;
    line-height: @layout-header-height;
    &:hover {
      background: linear-gradient(0deg, rgba(0, 80, 201, 0.2) 0%, rgba(174, 207, 255, 0.06) 86.76%);
      color: @layout-header-font-selected-color;
      border-radius: 3px 3px 0px 0px;
    }
  }
  .top-menu-selected {
    background: linear-gradient(0deg, rgba(0, 80, 201, 0.2) 0%, rgba(174, 207, 255, 0.06) 86.76%);
    color: @layout-header-font-selected-color;
    border-radius: 3px 3px 0px 0px;
    border-bottom: 3px solid @layout-header-font-selected-color;
    &:hover {
      background: linear-gradient(0deg, rgba(0, 80, 201, 0.2) 0%, rgba(174, 207, 255, 0.06) 86.76%);
      color: @layout-header-font-selected-color;
      border-radius: 3px 3px 0px 0px;
    }
  }
}

.top-menu-dropdown.ant-popover-placement-bottom .ant-popover-content {
  margin-top: -8px;
}

.top-menu-dropdown {
  min-width: 500px;
  .ant-popover-arrow {
    display: none;
  }
  .title {
    font-weight: 700;
  }
  .more {
    display: inline-block;
    padding: 8px 16px;
    margin: 0px 30px 0 10px;
    border-radius: 4px;
    background: linear-gradient(0deg, #eeeeee 55%, white);
    color: @layout-header-font-color;
    text-align: center;
    cursor: pointer;
    transition: all 0.3s;
    .more-icon-block {
      width: 40px;
      height: 40px;
    }
    &:hover {
      background: linear-gradient(0deg, rgba(0, 80, 201, 0.2) 0%, rgba(174, 207, 255, 0.06) 86.76%);
      color: @layout-header-font-selected-color;
    }
  }
  .more-selected {
    background-color: #001428;
    color: @layout-header-font-color;
  }
}
</style>
