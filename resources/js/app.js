require('./bootstrap');
// window.Vue = require('vue')
import Vue from 'vue'
import router from './router'
import store from './store'
import common from './common'
Vue.mixin(common)

import { BootstrapVue, IconsPlugin  } from 'bootstrap-vue'
import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'

import ViewUI from 'view-design';
import 'view-design/dist/styles/iview.css';
import locale from 'view-design/dist/locale/en-US'
Vue.use(ViewUI, { locale });

Vue.use(BootstrapVue)
Vue.use(IconsPlugin)

import VueHtmlToPaper from 'vue-html-to-paper';
const options = {
    name: '_blank',
    specs: [
      'fullscreen=yes',
      'titlebar=yes',
      'scrollbars=yes'
    ],
    styles: [
      'https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css'
    ]
  }
Vue.use(VueHtmlToPaper, options);

// router.beforeEnter( (to, from, next)=>{    
//   console.log('beforeeach working')                            
  
// });

import mainapp from './component/mainapp.vue'
import login from './component/pages/user/login.vue'
const app = new Vue({
    el:'#app',
    components : {
        mainapp,
        login
    },
    router,
    store
})



   
    
