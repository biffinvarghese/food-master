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
      role: undefined,
      userId: undefined,
      admin: undefined,
      cart: [],
      table:{}
    };
  },
  getters: {
    isLogined(state) {
      return !!state.user
    }
  },
  mutations: {
    setFoodsData(state, payload) {
      state.allFoods = payload;
    },
    setTable(state, payload){
      state.table=payload
    },
    setUser(state, token) {
      if (token) {
        var base64Url = (token || "").split(".")[1];
        var base64 = (base64Url || "").replace(/-/g, "+").replace(/_/g, "/");
        var jsonPayload = decodeURIComponent(
          window
            .atob(base64)
            .split("")
            .map(function (c) {
              return "%" + ("00" + c.charCodeAt(0).toString(16)).slice(-2);
            })
            .join("")
        );

        let decoded = JSON.parse(jsonPayload);
        console.log("decoded", decoded);
        state.role = decoded.role || "CUSTOMER";
        state.userId = decoded.userId || "";
        state.user = decoded;
      } else {
        state.role = undefined;
        state.userId = undefined;
        state.user = undefined;
      }
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
    updateCartQuantity(state, payload) {
      if (state.cart && state.cart.length > 0) {
        const cartData = JSON.parse(JSON.stringify(state.cart));
        const index = cartData.findIndex((item) => {
          console.log(payload.id, item.id);
          return payload.id === item.id;
        });
        if (index > -1) {
          console.log("index", index, payload);
          cartData[index].quantity = payload.quantity;
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
    resetCart(state) {
      state.cart = [];
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
