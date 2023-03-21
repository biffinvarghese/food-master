import { createWebHistory, createRouter } from "vue-router";
import Login from '../pages/Login.vue';
import Register from '../pages/Register.vue';
import Home from '../pages/Home.vue';
import About from '../pages/About.vue';
import Menu from '../pages/Menu.vue';
import Table from '../pages/Table.vue';
import Cart from '../pages/Cart.vue';
import Success from '../pages/Success.vue';
import Admin from '../admin/Admin.vue';
import Dashboard from '../admin/AdminHome.vue';
import BookedTableManagement from '../admin/BookedTableManagement.vue';
import TableManagement from '../admin/TableManagement.vue';
import TableAddOrEdit from '../admin/TableAddOrEdit.vue';
import ProductManagement from '../admin/ProductManagement.vue';
import FoodCategoryManagement from '../admin/FoodCategoryManagement.vue';
import FoodCategoryAddOrEdit from '../admin/FoodCategoryAddOrEdit.vue';
import ProductAddOrEdit from '../admin/ProductAddOrEdit.vue';
import UserManagement from '../admin/UserManagement.vue';
import OrderManagement from '../admin/OrderManagement.vue';
// import OrderDetails from '../admin/OrderDetails.vue';

const routes = [
  {
    path: "/",
    name: "Home",
    component: Home, 
  },
  {
    path: "/about",
    name: "About",
    component: About,
  },
  {
    path: "/table",
    name: "Table",
    component: Table,
  },
  {
    path: "/menu",
    name: "Menu",
    component: Menu,
  },
  {
    path: "/cart",
    name: "Cart",
    component: Cart,
  },
  {
    path: "/success",
    name: "Success",
    component: Success,
  },
  {
    path: "/login",
    name: "Login",
    component: Login,
  },
  {
    path: "/register",
    name: "Register",
    component: Register,
  },
  {
    path: "/admin",
    name: "Admin",
    component: Admin,
  },
  {
    path: "/admin/dashboard",
    name: "Dashboard",
    component: Dashboard,
    children: [
      {
        path: "/admin/dashboard/table-management",
        name: "TableManagement",
        component: TableManagement,
      },
      {
        path: "/admin/dashboard/booked-table-management",
        name: "BookedTableManagement",
        component: BookedTableManagement,
      },
      {
        path: "/admin/dashboard/table-add-or-edit",
        name: "TableAddOrEdit",
        component: TableAddOrEdit,
      },
      {
        path: "/admin/dashboard/food-category-management",
        name: "FoodCategoryManagement",
        component: FoodCategoryManagement,
      },
      {
        path: "/admin/dashboard/category-create",
        name: "FoodCategoryAddOrEdit",
        component: FoodCategoryAddOrEdit,
      },
      {
        path: "/admin/dashboard/product-management",
        name: "ProductManagement",
        component: ProductManagement,
      },
      {
        path: "/admin/dashboard/product-add-or-update",
        name: "ProductAddOrEdit",
        component: ProductAddOrEdit,
      },
      {
        path: "/admin/dashboard/user-management",
        name: "UserManagement",
        component: UserManagement,
      },
      {
        path: "/admin/dashboard/order-management",
        name: "OrderManagement",
        component: OrderManagement,
      },
      // {
      //   path: "/admin/dashboard/order-details",
      //   name: "OrderDetails",
      //   component: OrderDetails,
      // },
    ]
  },
  {
    path: '/:pathMatch(.*)*',
    component: Home,
  },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

export default router;