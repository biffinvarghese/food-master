import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import "@/axios"
import ToastPlugin from 'vue-toast-notification';
import 'vue-toast-notification/dist/theme-default.css';



createApp(App).use(router).use(ToastPlugin).use(store).mount('#app')