<template>
  <div class="admin-container">
    <div>
      <button
        class="btn mb-2 float-right"
        @click.prevent="$router.push('/admin/dashboard/category-create')"
      >
        Add Food Category
      </button>
    </div>
    <table class="table colored-header datatable project-list">
      <thead>
        <tr>
          <th>Food Category Name</th>
          <th>Image</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="(categoryInfo, index) in categoryData" :key="index">
          <td>{{ categoryInfo.name }}</td>
          
          <td>
            <img
              :src="'http://localhost:8081/' + categoryInfo.image"
              alt=""
              style="width: 10vw"
            />
          </td>
          <!-- <td>
            <button
              class="btn"
              @click.prevent="
                $router.push({
                  path: '/admin/dashboard/table-add-or-edit',
                  query: {
                    table_id: categoryInfo.table_id,
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
                deleteTableConfig(categoryInfo.table_id)
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
export default {
  name: "FoodCategoryManagement",
  data() {
    return {
      categoryData: [],
    };
  },
  mounted() {
    this.fetchAllCategories();
  },
  methods: {
    async fetchAllCategories() {
      try {
        const response = await axios.get("food-categories");
        this.categoryData = response.data;
        console.log("error", response);
      } catch (error) {
        console.log("error", error.data);
      }
    },
    async deleteTableConfig(id) {
      try {
        const response = await axios.delete("book-tables/"+id);
        await this.fetchBookedTables()
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
