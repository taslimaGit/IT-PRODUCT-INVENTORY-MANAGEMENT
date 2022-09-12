v-on:blur="onChange"


beforeEnter: (to, from, next)=>{    
                console.log(store.state.user.id)                            
                if(!store.state.user.id)
                {
                    next('/login')                   
                }else(
                    next()
                )
            }

    =================================================================================

  
 import Vue from 'vue'
import Router from 'vue-router'
Vue.use(Router)
import dashboard from './component/pages/dashboard.vue'
import department from './component/pages/department.vue'
import designation from './component/pages/designation.vue'
import client from './component/pages/client.vue'
import item from './component/pages/item.vue'
import attribute from './component/pages/attribute.vue'
import brand from './component/pages/brand.vue'
import product from './component/pages/product.vue'
import assign from './component/pages/assign.vue'

import user from './component/pages/user/user.vue'
import role from './component/pages/user/role.vue'
import assignRole from './component/pages/user/assignrole.vue'
import login from './component/pages/user/login.vue'



const routes = [
    {
        path: '/login',
        component: login,
        name: 'login'
    },
    {
        path: '/',
        component: dashboard,
        name: 'home'
    },
    {
        path: '/department',
        component: department,
        name: 'department'
    },
    {
        path: '/designation',
        component: designation,
        name: 'designation'
    },
    {
        path: '/client',
        component: client,
        name: 'client'
    },
    {
        path: '/item',
        component: item,
        name: 'item'
    },
    {
        path: '/attribute',
        component: attribute,
        name: 'attribute'
    },
    {
        path: '/brand',
        component: brand,
        name: 'brand'
    },
    {
        path: '/product',
        component: product,
        name: 'product'
    },
    {
        path: '/assign',
        component: assign,
        name: 'assign'
    },
    {
        path: '/user',
        component: user,
        name: 'user'
    },
    {
        path: '/role',
        component: role,
        name: 'role'
    },
    {
        path: '/assignRole',
        component: assignRole,
        name: 'assignRole'
    },

]
routes.beforeEach((to, from, next) => {
    let a = 1
    if (a == 0) return  next('/item')
    else return  next('/login')
  })
export default new Router({
    mode: 'history',
    routes,
    
})


