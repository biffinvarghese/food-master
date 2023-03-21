/* eslint-disable */
<template>
  <div id="app">
    <div v-if="admin">
      <router-view></router-view>
    </div>
    <div v-else>
      <NavBar v-if="$route.path !== '/success'"/>

      <div class="auth-wrapper">
        <div class="auth-inner">
          <router-view></router-view>
        </div>
      </div>
      <FooterComponent v-if="$route.path !== '/success'"/>
    </div>
  </div>
</template>

<script>
import NavBar from "./components/NavBar.vue";
import FooterComponent from "./components/FooterComponent.vue";
import { mapActions, mapMutations } from "vuex";
import { mapState } from "vuex";
export default {
  name: "App",
  components: {
    NavBar,
    FooterComponent,
  },

  created() {
    this.getFoodsData();
  },

  watch: {
    $route(val) {
      if (!val.path || (val.path && val.path.length > 0 && !val.path.includes("admin"))) {
        this.setAdmin(null);
      }
    },
  },

  computed: {
    ...mapState(["admin"]),
  },

  methods: {
    ...mapActions(["getFoodsData"]),
    ...mapMutations(["setAdmin"]),

  },
};
</script>

<style>
@import "./assets/css/global_style.css";
</style>
