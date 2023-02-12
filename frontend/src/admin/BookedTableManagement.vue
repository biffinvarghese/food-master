<template>
  <div class="admin-container">
    <table class="table colored-header datatable project-list">
      <thead>
        <tr>
          <th>SI NO</th>
          <th>Table Type</th>
          <th>Table Name</th>
          <th>Time</th>
          <th>Email</th>
          <th>Phone</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="(tableInfo, index) in tablesData" :key="index">
          <td>{{ index + 1 }}</td>
          <td>{{ tableInfo.table_type }}</td>
          <td>{{ tableInfo.table_name }}</td>
          <td>{{ new Date(tableInfo.date).toLocaleTimeString() }}</td>
          <td>{{ tableInfo.user_email }}</td>
          <td>{{ tableInfo.user_phone }}</td>
        </tr>
      </tbody>
    </table>
  </div>
</template>
<script>
import axios from "axios";
export default {
  name: "TableAddOrEdit",
  data() {
    return {
      tablesData: [],
    };
  },
  mounted() {
    this.fetchBookedTables();
  },
  methods: {
    async fetchBookedTables() {
      try {
        const response = await axios.get("bookings");
        this.tablesData = response.data;
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
