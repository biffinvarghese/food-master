<template>
  <!-- eslint-disable -->
  <link
    type="text/css"
    rel="stylesheet"
    href="./assets/css/bootstrap.min.css"
  />
  <vue-basic-alert :duration="300" :closeIn="2000" ref="alert" />
  <section class="order-section">
    <div class="heading">
      <span>Book A Table</span>
      <h3>Enjoy Your Moment</h3>
    </div>

    <div class="icons-container">
      <div class="icons">
        <img src="../assets/images/icon-1.png" alt="" />
        <h3>8:00am to 9:00pm</h3>
      </div>

      <div class="icons">
        <img src="../assets/images/icon-2.png" alt="" />
        <h3>+91 7025484895</h3>
      </div>

      <div class="icons">
        <img src="../assets/images/icon-3.png" alt="" />
        <h3>Koovappally, Kanjirappally, Kottayam</h3>
      </div>
    </div>

    <!-- booking form -->
    <form
      id="bookTableForm"
      @submit="handleSubmit"
      novalidate
      autocomplete="off"
    >
      <div id="booking" class="section">
        <!-- <div class="section-center"> -->
        <div class="container">
          <div class="row">
            <div class="booking-form">
              <div class="form-header">
                <h1>Make your reservation</h1>
              </div>
              <div class="form-group">
                <select
                  class="form-control"
                  name="oPeople"
                  id="oPeople"
                  v-model="orderObj.table_type"
                  required
                  @change="fetchTableNames"
                >
                  <option value="" selected hidden>Table Type</option>
                  <option
                    v-for="(tableType, index) in tableTypes"
                    :key="'table type' + index"
                    :value="tableType"
                  >
                    {{ tableType.split("_").join(" ") }}
                  </option>
                </select>
                <span class="select-arrow"></span>
                <span class="form-label">Seat Type</span>
                <p v-if="errorObj.peopleErr.length > 0">
                  {{ errorObj.peopleErr[0] }}
                </p>
              </div>
              <!-- <div class="row"> -->
              <!-- <div class="col-md-4"> -->
              <div class="form-group">
                <select
                  class="form-control"
                  name="oTables"
                  id="oTables"
                  v-model="orderObj.table_name"
                  required
                >
                  <option value="" selected hidden>Table Name</option>
                  <option
                    v-for="(tableName, index) in tableNames"
                    :key="'table name' + index"
                  >
                    {{ tableName.split("_").join(" ") }}
                  </option>
                </select>
                <span class="select-arrow"></span>
                <span class="form-label">Table Type</span>
                <p v-if="errorObj.tablesErr.length > 0">
                  {{ errorObj.tablesErr[0] }}
                </p>
              </div>
              <!-- </div> -->
              <!-- <div class="row"> -->
              <!-- <div class="col-md-6"> -->
              <div class="form-group">
                <input
                  class="form-control"
                  type="datetime-local"
                  name="oWhen"
                  id="oWhen"
                  v-model="orderObj.when"
                  required
                />
                <span class="form-label">Time</span>
                <p v-if="errorObj.whenErr.length > 0">
                  {{ errorObj.whenErr[0] }}
                </p>
              </div>
              <!-- </div> -->
              <!-- </div> -->
              <div class="form-btn">
                <input type="submit" class="btn" value="Book Now" />
              </div>
            </div>
          </div>
        </div>
      </div>
      <!-- </div>  -->
    </form>
  </section>
</template>
<!-- // 
// class="btn" -->

<script>
import axios from "axios";
import VueBasicAlert from "vue-basic-alert";
export default {
  name: "Table",

  data() {
    return {
      orderObj: { people: "", tables: "", when: "" },
      errorObj: { peopleErr: [], tablesErr: [], whenErr: [] },
      tableTypes: [],
      tableNames: [],
      tables: [],
    };
  },
  mounted() {
    this.fetchTableConfig();
  },

  methods: {
    fetchTableNames() {
      const tableNames = this.tables.filter(table => {
        console.log('table', table)
        return table.table_type === this.orderObj.table_type
      })
      this.tableNames = [...new Set(tableNames.map((type) => type.table_name))];
      console.log('this.tableNames', this.tableNames, this.tables)
      this.$forceUpdate()
    },
    async fetchTableConfig() {
      try {
        const response = await axios.get("book-tables");
        this.tables = response.data;
        const res = JSON.parse(JSON.stringify(response.data));
        this.tableTypes = [...new Set(res.map((type) => type.table_type))];

        console.log("error", response);
      } catch (error) {
        console.log("error", error.data);
      }
    },
    availableTime: function () {
      var now = new Date();
      var day = ("0" + now.getDate()).slice(-2);
      var currentMonth = ("0" + (now.getMonth() + 1)).slice(-2);
      var maxMonth = ("0" + (now.getMonth() + 3)).slice(-2);
      var hour = ("0" + now.getHours()).slice(-2);
      var min = ("0" + now.getMinutes()).slice(-2);
      var minRange =
        now.getFullYear() +
        "-" +
        currentMonth +
        "-" +
        day +
        "T" +
        hour +
        ":" +
        min;
      var maxRange =
        now.getFullYear() + "-" + maxMonth + "-" + day + "T" + hour + ":" + min;

      document.getElementById("oWhen").setAttribute("min", minRange);
      document.getElementById("oWhen").setAttribute("max", maxRange);
    },

    resetCheckErr: function () {
      this.errorObj.peopleErr = [];
      this.errorObj.tablesErr = [];
      this.errorObj.whenErr = [];
    },

    checkEmptyErr: function () {
      for (var typeErr in this.errorObj) {
        if (this.errorObj[typeErr].length != 0) {
          return false;
        }
      }
      return true;
    },

    checkForm: function () {
      this.resetCheckErr();

      if (!this.orderObj.people) {
        this.errorObj.peopleErr.push("Entering the seating number is required");
      } else {
        if (parseInt(this.orderObj.people) > 100) {
          this.errorObj.peopleErr.push(
            "Each individuals can only reserve the available seats"
          );
        }
      }

      if (!this.orderObj.tables) {
        this.errorObj.tablesErr.push("Entering number of tables is required");
      } else {
        if (parseInt(this.orderObj.tables) > 50) {
          this.errorObj.tablesErr.push(
            "Each individual can only have maximum tables"
          );
        }
      }

      if (!this.orderObj.when) {
        this.errorObj.whenErr.push("Entering when to serve is required");
      } else {
        let minRange = document.getElementById("oWhen").getAttribute("min");
        let maxRange = document.getElementById("oWhen").getAttribute("max");
        let dateMin = new Date(minRange);
        let dateMax = new Date(maxRange);
        let dateInput = new Date(this.orderObj.when);

        if (dateInput === "Invalid Date") {
          this.errorObj.whenErr.push("Invalid date input");
        }

        if (
          dateInput.getTime() < dateMin.getTime() ||
          dateInput.getTime() > dateMax.getTime()
        ) {
          this.errorObj.whenErr.push(
            "Available reservation range is from now to next three hours"
          );
        }

        if (dateInput.getHours() < 7 || dateInput.getHours() > 22) {
          this.errorObj.whenErr.push(
            "Store open from 8:00 AM to 9:00 PM everyday"
          );
        }
      }
    },

    async handleSubmit(e) {
      this.checkForm();

      if (!this.checkEmptyErr()) {
        e.preventDefault();
      } else {
        e.preventDefault();

        let data = {
          book_people: parseInt(this.orderObj.people),
          book_tables: parseInt(this.orderObj.tables),
          book_when: this.orderObj.when,
        };

        await axios.post("/booking", data);

        this.$refs.alert.showAlert(
          "success",
          "Thank you! We will call you soon to confirm your order",
          "Booking Successfully !"
        );
        document.getElementById("bookTableForm").reset();
      }
    },
  },

  components: {
    VueBasicAlert,
  },
};
</script>

<style scoped>
.order-section {
  padding: 2rem 9%;
}

.order-section .icons-container {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(40rem, 1fr));
  gap: 1.5rem;
  margin-bottom: 2rem;
}

.order-section .icons-container .icons {
  border-radius: 0.5rem;
  padding: 2rem;
  text-align: center;
  background: #f7f7f7;
}

.order-section .icons-container .icons img {
  height: 10rem;
}

.order-section .icons-container .icons h3 {
  font-size: 2rem;
  color: #130f40;
  margin-top: 0.5rem;
}

.section {
  position: relative;
}

.section .section-center {
  position: absolute;
  top: 50%;
  left: 0;
  right: 0;
  -webkit-transform: translateY(-50%);
  transform: translateY(-50%);
}

#booking {
  font-family: "Raleway", sans-serif;
}

.booking-form {
  position: relative;
  max-width: 642px;
  width: 100%;
  margin: auto;
  padding: 40px;
  overflow: hidden;
  background-image: src= "../assets/images/a.jpg";
  background-size: cover;
  border-radius: 5px;
  z-index: 20;
}

.booking-form::before {
  content: "";
  position: absolute;
  left: 0;
  right: 0;
  bottom: 0;
  top: 0;
  background: rgba(0, 0, 0, 0.7);
  z-index: -1;
}

.booking-form .form-header {
  text-align: center;
  position: relative;
  margin-bottom: 30px;
}

.booking-form .form-header h1 {
  font-weight: 700;
  text-transform: capitalize;
  font-size: 42px;
  margin: 0px;
  color: rgb(252, 72, 72);
}

.booking-form .form-group {
  position: relative;
  margin-bottom: 30px;
}

.booking-form .form-control {
  background-color: rgba(255, 255, 255, 0.2);
  height: 60px;
  padding: 0px 25px;
  border: none;
  /* border-radius: 40px; */
  color: #fff;
  -webkit-box-shadow: 0px 0px 0px 2px transparent;
  box-shadow: 0px 0px 0px 2px transparent;
  -webkit-transition: 0.2s;
  transition: 0.2s;
}

.booking-form .form-control::-webkit-input-placeholder {
  color: rgba(255, 255, 255, 0.5);
}

.booking-form .form-control:-ms-input-placeholder {
  color: rgba(255, 255, 255, 0.5);
}

.booking-form .form-control::placeholder {
  color: rgba(255, 255, 255, 0.5);
}

.booking-form .form-control:focus {
  -webkit-box-shadow: 0px 0px 0px 2px #ff8846;
  box-shadow: 0px 0px 0px 2px #ff8846;
}

.booking-form input[type="date"].form-control {
  padding-top: 16px;
}

.booking-form input[type="date"].form-control:invalid {
  color: rgba(255, 255, 255, 0.5);
}

.booking-form input[type="date"].form-control + .form-label {
  opacity: 1;
  top: 10px;
}

.booking-form select.form-control {
  -webkit-appearance: none;
  -moz-appearance: none;
  appearance: none;
}

.booking-form select.form-control:invalid {
  color: rgba(255, 255, 255, 0.5);
}

.booking-form select.form-control + .select-arrow {
  position: absolute;
  right: 15px;
  top: 50%;
  -webkit-transform: translateY(-50%);
  transform: translateY(-50%);
  width: 32px;
  line-height: 32px;
  height: 32px;
  text-align: center;
  pointer-events: none;
  color: rgba(255, 255, 255, 0.5);
  font-size: 14px;
}

.booking-form select.form-control + .select-arrow:after {
  content: "\279C";
  display: block;
  -webkit-transform: rotate(90deg);
  transform: rotate(90deg);
}

.booking-form select.form-control option {
  color: #000;
}

.booking-form .form-label {
  position: absolute;
  top: -10px;
  left: 25px;
  opacity: 0;
  color: #ff8846;
  font-size: 11px;
  font-weight: 700;
  text-transform: uppercase;
  letter-spacing: 1.3px;
  height: 15px;
  line-height: 15px;
  -webkit-transition: 0.2s all;
  transition: 0.2s all;
}

.booking-form .form-group.input-not-empty .form-control {
  padding-top: 16px;
}

.booking-form .form-group.input-not-empty .form-label {
  opacity: 1;
  top: 10px;
}

.booking-form .submit-btn {
  color: rgb(12, 2, 2);
  background-color: #e35e0a;
  font-weight: 700;
  height: 60px;
  padding: 10px 30px;
  width: 100%;
  border-radius: 40px;
  border: none;
  text-transform: uppercase;
  font-size: 16px;
  letter-spacing: 1.3px;
  -webkit-transition: 0.2s all;
  transition: 0.2s all;
}

.booking-form .submit-btn:hover,
.booking-form .submit-btn:focus {
  opacity: 0.9;
}

@media (max-width: 576px) {
  .order-section .icons-container {
    grid-template-columns: repeat(auto-fit, minmax(30rem, 1fr));
  }
}
</style>
