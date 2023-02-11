<template>
  <div class="admin-container">
    <div class="row">
      <div class="col-12">
        <button
          class="btn mb-2 float-right"
          @click.prevent="
            $router.push('/admin/dashboard/product-add-or-update')
          "
        >
          Add new product
        </button>
      </div>
    </div>
    <div class="row my-2">
      <div class="col-4"><span>Choose Category:</span></div>
      <div class="col-8">
        <v-select
          v-model="choosenCategory"
          class="style-chooser"
          :clearable="false"
          :options="categoriesNames"
          @input="onProductCategoryChange"
          @option:selected="onProductCategoryChange"
        />
      </div>
    </div>

    <table class="table colored-header datatable project-list mt-2">
      <thead>
        <tr>
          <th>Product name</th>
          <th>Category</th>
          <th>Description</th>
          <th>Image</th>
          <th>Price</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="(productInfo, index) in products" :key="index">
          <td>{{ productInfo.name }}</td>
          <td>{{ productInfo.category_name }}</td>
          <td>{{ productInfo.description }}</td>

          <td>
            <img
              :src="'http://localhost:8081/' + productInfo.image"
              alt=""
              style="width: 10vw"
            />
          </td>
          <td>{{ productInfo.price }}</td>
          <!-- <td>
            <button
              class="btn"
              @click.prevent="
                $router.push({
                  path: '/admin/dashboard/table-add-or-edit',
                  query: {
                    table_id: productInfo.table_id,
                  },
                })
              "
            >
              Edit
            </button>
          </td>
          <td>
            <button
              class="btn"
              @click.prevent="
                deleteTableConfig(productInfo.table_id)
              "
            >
              Delete
            </button>
          </td> -->
        </tr>
      </tbody>
    </table>
  </div>
</template>
<script>
import axios from "axios";
import vSelect from "vue-select";
import "vue-select/dist/vue-select.css";
export default {
  name: "ProductManagement",
  components: {
    "v-select": vSelect,
  },
  data() {
    return {
      productData: [],
      products: [],
      categories: [],
      categoriesNames: [],
      choosenCategory: "",
    };
  },
  async mounted() {
    await this.fetchAllProducts();
    await this.fetchAvailableCategories();
  },
  methods: {
    onProductCategoryChange(event) {
      console.log("evenbt ", event);
      const categoryId = this.categories.find(
        (category) =>
          category.name.toLowerCase() === this.choosenCategory.toLowerCase()
      ).id;
      this.products = this.productData.filter(
        (product) => product.category_id === categoryId
      );
    },
    async fetchAvailableCategories() {
      try {
        const response = await axios.get("food-categories");
        const res = JSON.parse(JSON.stringify(response.data));
        this.categories = res;
        this.categoriesNames = res.map((category) => category.name);
        console.log("error", response);
      } catch (error) {
        console.log("error", error.data);
      }
    },
    async fetchAllProducts() {
      try {
        const response = await axios.get("products");
        this.productData = response.data;
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
