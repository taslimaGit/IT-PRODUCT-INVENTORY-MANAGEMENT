import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

export default new Vuex.Store({
    state:{
        total:5,
        deleteModuleObj:{
            deleteModal:false,
            url:null,
            id:null,
            name:null,
            isDelete: false,            
        },
        user : false
    },
    getters:{
        getdeleteModuleObj(state){
            return state.deleteModuleObj
        },
        getTotal(state){
            return state.total
        },
        getUser(state){
            return state.user
        }
    },
    mutations:{
        setDeleteModalData(state, data){            
            state.deleteModuleObj = data
        },
        setDeleteModal(state, data){  
            // console.log(data)          
           const deleteModuleObj = {
                deleteModal:false,
                url:null,
                id:null,
                name:null,
                isDelete: data, 
                              
            }            
            // console.log(data)
        state.deleteModuleObj = deleteModuleObj
        },
        userDetails(state, data){
            state.user = data
        }
    }
})
