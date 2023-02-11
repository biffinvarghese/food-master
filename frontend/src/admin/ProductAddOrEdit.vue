<template>
  <div class="admin-container">
    <form
      id="tableManagementForm"
      class="table-management-form"
      @submit.prevent="handleSubmit"
      novalidate
      autocomplete="off"
    >
      <h1 class="mb-5">{{ isEdit ? "Edit" : "Add" }} products</h1>

      <div v-if="errors.length" class="error-box">
        <ul>
          <li v-for="error in errors" :key="error">{{ error }}</li>
        </ul>
      </div>

      <div class="row mt-2">
        <div class="col-4"><span>Product Category:</span></div>
        <div class="col-8">
          <v-select
            v-model="product.category_name"
            class="style-chooser"
            :clearable="false"
            :options="categoriesNames"
            @input="onProductCategoryChange"
            @option:selected="onProductCategoryChange"
          />
        </div>
      </div>

      <div class="row mt-2">
        <div class="col-4"><span>Name:</span></div>
        <div class="col-8">
          <input type="text" class="form-control" v-model="product.name" />
        </div>
      </div>

      <!-- <div class="row mt-2 form-group">
        <div class="col-4"><span>Count:</span></div>
        <div class="col-8">
          <input type="number" class="form-control" v-model="product.count" />
        </div>
      </div> -->

      <div class="row mt-2 form-group">
        <div class="col-4"><span>Description:</span></div>
        <div class="col-8">
          <input
            type="text"
            class="form-control"
            v-model="product.description"
          />
        </div>
      </div>

      <div class="row mt-2 form-group">
        <div class="col-4"><span>Price:</span></div>
        <div class="col-8">
          <input type="number" class="form-control" v-model="product.price" />
        </div>
      </div>

      <div class="row mt-2 form-group">
        <div class="col-4"><span>Image:</span></div>
        <div class="col-8">
          <input
            type="file"
            class="form-control file-input"
            accept="image/*"
            @change="uploadImage"
          />
        </div>
      </div>
      <div class="row mt-2 form-group">
        <div class="col-4"></div>
        <div class="col-8" v-if="isImageUploaded">
          <img
            :src="'http://localhost:8081/' + product.image"
            alt=""
            style="width: 10vw"
          />
        </div>
      </div>

      <div class="form-group">
        <input type="submit" value="Submit" class="btn" />
      </div>
    </form>
  </div>
</template>
<script>
import axios from "axios";
import vSelect from "vue-select";
import "vue-select/dist/vue-select.css";
export default {
  name: "TableAddOrEdit",
  components: {
    "v-select": vSelect,
  },
  data() {
    return {
      category_ids: [
        { label: "2 Seating", value: "two_seating" },
        { label: "4 Seating", value: "four_seating" },
        { label: "8 Seating", value: "eight_seating" },
      ],
      names: [
        { label: "Table 1", value: "table_1" },
        { label: "Table 2", value: "table_2" },
        { label: "Table 3", value: "table_3" },
        { label: "Table 4", value: "table_4" },
        { label: "Table 5", value: "table_5" },
      ],
      product: {
        category_id: "",
        name: "",
        description: "",
        image: "",
        category_name: "",
        price: "",
      },
      categories: [],
      categoriesNames: [],
      errors: [],
      uploadPending: false,
    };
  },
  computed: {
    isImageUploaded() {
      return this.product && !!this.product.image && !this.uploadPending;
    },
    isEdit() {
      return this.$route.query && !!this.$route.query.product_id;
    },
  },
  async mounted() {
    const selector = document.getElementsByClassName("vs__search");
    if (selector && selector.length > 0) {
      for (let index = 0; index < selector.length; index++) {
        const element = selector[index];
        element.classList.add("form-control");
      }
    }
    await this.fetchAvailableCategories();
  },
  methods: {
    onProductCategoryChange(event) {
      console.log("evenbt ", event);
      this.product.category_id = this.categories.find(
        (category) =>
          category.name.toLowerCase() ===
          this.product.category_name.toLowerCase()
      ).id;
    },
    async handleSubmit() {
      this.errors = [];
      console.log("on product submit", this.product);
      const payload = {
        category_name: this.product.category_name || "",
        category_id: this.product.category_id || "",
        name: this.product.name || "",
        description: this.product.description,
        image: this.product.image,
        price: this.product.price,
      };
      const method = this.isEdit ? "put" : "post";
      const path = this.isEdit
        ? "products/" + this.$route.query.table_id
        : "products";
      try {
        const response = await axios[method](path, payload);
        this.$router.push("/admin/dashboard/product-management");
        console.log("error", response);
      } catch (error) {
        console.log("error", error.data);
      }
    },
    async fetchAvailableCategories() {
      try {
        const response = await axios.get("food-categories");
        const res = JSON.parse(JSON.stringify(response.data));
        this.categories = JSON.parse(JSON.stringify(res));
        this.categoriesNames = res.map((category) => category.name);
        console.log("error", response);
      } catch (error) {
        console.log("error", error.data);
      }
    },
    async uploadImage(e) {
      this.uploadPending = true;
      if (e && e.target && e.target.files && e.target.files[0]) {
        console.log("response", e);
        const formData = new FormData();
        formData.append("image", e.target.files[0]);
        const response = await axios.post("/upload", formData);
        this.uploadPending = false;
        console.log(response);
        if (response && response.data && response.data.imageUrl) {
          this.product.image = response.data.imageUrl;
        }
        console.log("response", response);
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

.table-management-form .form-control {
  margin: 0.7rem 0;
  border-radius: 0.5rem;
  background: #f7f7f7;
  padding: 2rem 1.2rem;
  font-size: 1.6rem;
  color: #130f40;
  text-transform: none;
  width: 100%;
  border: none;
}
.vs__search {
  margin: 0.7rem 0;
  border-radius: 0.5rem;
  background: #f7f7f7;
  padding: 2rem 1.2rem;
  font-size: 1.6rem;
  color: #130f40;
  text-transform: none;
  width: 100%;
  border: none;
}

.file-input {
  padding: 2rem 3rem 1rem 3rem !important;
  height: 100%;
}

.vs__dropdown-toggle {
  -webkit-appearance: none;
  -moz-appearance: none;
  appearance: none;
  display: flex;
  padding: 0 0 4px;
  background: lightgray;
  /* border: var(--vs-border-width) var(--vs-border-style) var(--vs-border-color); */
  border-radius: var(--vs-border-radius);
  white-space: normal;
}
</style>
