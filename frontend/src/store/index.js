import Vuex from "vuex";
import VuexPersistence from "vuex-persist";
import axios from "axios";

const vuexLocal = new VuexPersistence({
  storage: window.localStorage,
});

//   const store = new Vuex.Store({
//     state: { ... },
//     mutations: { ... },
//     actions: { ... },
//     plugins: [vuexLocal.plugin]
//   })

const store = new Vuex.Store({
  state() {
    return {
      allFoods: [],
      user: undefined,
      admin: undefined,
      cart: [],
    };
  },
  mutations: {
    setFoodsData(state, payload) {
      state.allFoods = payload;
    },
    setUser(state, payload) {
      state.user = payload;
    },
    setAdmin(state, payload) {
      state.admin = payload;
    },
    setCart(state, payload) {
      console.log("log", payload);
      if (state.cart && state.cart.length > 0) {
        const cartData = JSON.parse(JSON.stringify(state.cart));
        const index = cartData.findIndex((item) => {
          console.log(payload.id, item.id);
          return payload.id === item.id;
        });
        if (index > -1) {
          console.log("index", index, payload);
          cartData[index].quantity = cartData[index].quantity + 1;
          state.cart = cartData;
        } else {
          console.log("index", index, payload);
          state.cart.push(payload);
        }
      } else state.cart.push(payload);
    },
    removeFromCart(state, payload) {
      console.log("log", payload);
      if (state.cart && state.cart.length > 0) {
        const cartData = JSON.parse(JSON.stringify(state.cart));
        const index = cartData.findIndex((item) => {
          console.log(payload.id, item.id);
          return payload.id === item.id;
        });
        if (index > -1) {
          
          state.cart.splice(index, 1);
        }
      }
    },
  },
  actions: {
    async getFoodsData(context) {
      await axios
        .get("/foods")
        .then(function (response) {
          context.commit("setFoodsData", response.data);
        })
        .catch(function (error) {
          console.log(error);
        });
    },
  },
  plugins: [vuexLocal.plugin],
});

export default store;
