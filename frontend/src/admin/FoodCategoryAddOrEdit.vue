<template>
  <div class="admin-container">
    <form
      id="foodCategoryManagementForm"
      class="foodCategory-management-form"
      @submit.prevent="handleSubmit"
      novalidate
      autocomplete="off"
    >
      <h1 class="mb-5">{{ isEdit ? "Edit" : "Add" }} food categories</h1>

      <div v-if="errors.length" class="error-box">
        <ul>
          <li v-for="error in errors" :key="error">{{ error }}</li>
        </ul>
      </div>

      <div class="row mt-2 form-group">
        <div class="col-4"><span>Category Name:</span></div>
        <div class="col-8">
          <input
            type="text"
            class="form-control"
            v-model="foodCategory.name"
          />
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
            :src="'http://localhost:8081/' + foodCategory.image"
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
export default {
  name: "FoodCategoryAddOrEdit",
  data() {
    return {
      foodCategoryTypes: [
        { label: "2 Seating", value: "two_seating" },
        { label: "4 Seating", value: "four_seating" },
        { label: "8 Seating", value: "eight_seating" },
      ],
      foodCategoryNames: [
        { label: "foodCategory 1", value: "foodCategory_1" },
        { label: "foodCategory 2", value: "foodCategory_2" },
        { label: "foodCategory 3", value: "foodCategory_3" },
        { label: "foodCategory 4", value: "foodCategory_4" },
        { label: "foodCategory 5", value: "foodCategory_5" },
      ],
      foodCategory: {
        name: '',
        image: null
      },
      errors: [],
      uploadPending: false,
    };
  },
  computed: {
    isImageUploaded() {
      return this.foodCategory && !!this.foodCategory.image && !this.uploadPending;
    },
    isEdit() {
      return this.$route.query && !!this.$route.query.food_category_id;
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
    if (this.$route.query && this.$route.query.food_category_id)
      await this.fetchfoodCategoryConfigById(this.$route.query.food_category_id);
  },
  methods: {
    async handleSubmit() {
      this.errors = [];
      console.log("on foodCategory submit", this.foodCategory);
      const payload = this.foodCategory;
      const method = this.isEdit ? "put" : "post";
      const path = this.isEdit
        ? "food-categories/" + this.$route.query.foodCategory_id
        : "food-categories";
      try {
        const response = await axios[method](path, payload);
        this.$router.push("/admin/dashboard/food-category-management");
        console.log("error", response);
      } catch (error) {
        console.log("error", error.data);
      }
    },
    async fetchfoodCategoryConfigById(id) {
      try {
        const response = await axios.get("book-foodCategorys/" + id);
        const res = JSON.parse(JSON.stringify(response.data));
        this.foodCategory = response.data;
        this.foodCategory.foodCategoryType = this.foodCategoryTypes.find(
          (type) => type.value === res.foodCategory_type
        );
        this.foodCategory.foodCategoryName = this.foodCategoryNames.find(
          (name) => name.value === res.foodCategory_name
        );
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
          this.foodCategory.image = response.data.imageUrl;
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

.foodCategory-management-form .form-control {
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
