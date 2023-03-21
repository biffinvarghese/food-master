<template>
    <div class="admin-container">
      <h1 class="mb-5">Order Details</h1>
      <!-- <div>
        <button
          class="btn mb-2 float-right"
          @click.prevent="$router.push('/admin/dashboard/category-create')"
        >
          Add Food Category
        </button>
      </div> -->
      <div v-for="(conf, index) in config" :key="index">
        <h3 class="mb-5">{{ conf.title }}</h3>
        <table class="table colored-header datatable project-list">
          <thead>
            <tr>
              <th
                v-for="(order, index1) in conf.config"
                :key="'first' + index1 + config.key + index"
              >
                {{ order.key ? order.key : "" }}
              </th>
            </tr>
          </thead>
          <tbody>
            <template
              v-if="
                this.orderData &&
                this.orderData[conf.key] &&
                this.orderData[conf.key].length > 0
              "
            >
              <tr
                v-for="(data, index3) in this.orderData[conf.key]"
                :key="'third' + index3 + config.key + index + '344' + index3"
              >
                <td
                  v-for="(order, index2) in conf.config"
                  :key="'second' + index2 + config.key + index"
                >
                  {{
                    data && data[order.value] && data[order.value]
                      ? data[order.value]
                      : ""
                  }}
                </td>
              </tr>
            </template>
            <template v-else>
              <tr>
                <td
                  v-for="(order, index2) in conf.config"
                  :key="'second' + index2 + config.key + index"
                >
                  {{
                    this.orderData &&
                    this.orderData[conf.key] &&
                    this.orderData[conf.key][order.value] &&
                    this.orderData[conf.key][order.value]
                      ? this.orderData[conf.key][order.value]
                      : ""
                  }}
                </td>
              </tr>
            </template>
          </tbody>
        </table>
      </div>
    </div>
  </template>
  <script>
  import axios from "axios";
  export default {
    name: "FoodCategoryManagement",
    data() {
      return {
        orderData: [],
        config: [
          {
            title: "Cart Details",
            key: "cart_details",
            isArray: true,
            config: [
              {
                key: "Name",
                value: "name",
              },
              {
                key: "Category",
                value: "category_name",
              },
              {
                key: "Quantity",
                value: "quantity",
              },
            ],
          },
          {
            title: "User Details",
            key: "user",
            isArray: false,
            config: [
              {
                key: "Username",
                value: "user_name",
              },
              {
                key: "Phone",
                value: "user_phone",
              },
              {
                key: "Email",
                value: "user_email",
              },
            ],
          },
          {
            title: "Table Details",
            key: "table_details",
            isArray: false,
            config: [
              {
                key: "Table Name",
                value: "table_name",
              },
              {
                key: "Table Type",
                value: "table_type",
              },
              {
                key: "Booking Time",
                value: "date",
              },
            ],
          },
        ],
      };
    },
    mounted() {
      this.fetchOrderDetails();
    },
    methods: {
      async fetchOrderDetails() {
        try {
          const response = await axios.get("orders/" + this.$route.query.id);
          const res = await axios.get("users/id/" + response.data.user_id);
          response.data.user = res.data;
          response.data.cart_details = JSON.parse(response.data.cart_details);
          response.data.table_details = JSON.parse(response.data.table_details);
          this.orderData = response.data;
          console.log("error", response);
        } catch (error) {
          console.log("error", error.data);
        }
      },
      async deleteTableConfig(id) {
        try {
          const response = await axios.delete("book-tables/" + id);
          await this.fetchBookedTables();
          console.log("error", response);
        } catch (error) {
          console.log("error", error.data);
        }
      },
    },
  };
  </script>
  
  <style scoped>
  .admin-container {
    background-color: #fff;
    min-height: calc(100vh - 109px);
    padding: 4em;
    font-size: 16px;
  }
  
  .admin-container {
    background-color: #fff;
    min-height: calc(100vh - 109px);
    padding: 4em;
    font-size: 16px;
  }
  
  .project-list > tbody > tr > td {
    padding: 12px 8px;
  }
  
  .project-list > tbody > tr > td .avatar {
    width: 22px;
    border: 1px solid #ccc;
  }
  </style>