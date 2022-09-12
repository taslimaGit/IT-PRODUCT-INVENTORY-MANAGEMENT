<template>
  <div>
    <div class="loaded">
      <div class="main-wrapper">
        <div class="app sidebar-fixed">
          <header class="header">
            
            <div class="header-block header-block-collapse d-lg-none d-xl-none">             
              <!-- <button class="collapse-btn" id="">
                <i class="fa fa-bars"></i>
              </button> -->
            </div>
            <div class="header-block header-block-search">
              <h4>.....</h4>
            </div>
             <!-- <div class="container text-center"><h1 class="h1">Taratex Fashion Ltd</h1></div> -->
  <!-- class="header-block header-block-nav" -->
   <div class="toogle-box">
     <Button class="d-lg-none d-xl-none" type="primary" ghost id="sidebar-collapse-btn"> <b-icon icon="menu-button-wide" aria-hidden="true"></b-icon></Button>
     </div>
     
            <div class="header-block header-block-nav">              
              <ul class="nav-profile">
                <li class="profile dropdown">
                  <a
                    class="nav-link dropdown-toggle"
                    data-toggle="dropdown"
                    href="#"
                    role="button"
                    aria-haspopup="true"
                    aria-expanded="false"
                  >
                    <!-- <div
                      class="img"
                      style="
                        background-image: url('https://avatars3.githubusercontent.com/u/3959008?v=3&amp;s=40');
                      "
                    ></div> -->
                    <span class="name"> {{fullName}} </span>
                  </a>
                  <div
                    class="dropdown-menu profile-dropdown-menu"
                    aria-labelledby="dropdownMenu1"
                  >
                    <a class="dropdown-item" href="#">
                      <i class="fa fa-user icon"></i> Profile
                    </a>

                    <div class="dropdown-divider"></div>
                   <!-- <router-link to="/logout">  <i class="fa fa-power-off icon"></i> Logout</router-link> -->
                    <a class="dropdown-item" @click="logout">
                      <i class="fa fa-power-off icon"></i> Logout
                    </a>
                  </div>
                </li>
              </ul>
            </div>
          </header>
          <aside class="sidebar">
            <div class="sidebar-container">
              <div class="sidebar-header">
                <div class="brand">
                  <div class="logo">
                   
                  </div>
                  Taratex
                </div>
              </div>
              <nav class="menu">
                <ul class="sidebar-menu metismenu" id="sidebar-menu">
                  
                  <li>
                    <router-link  to="/"><b-icon icon="chevron-bar-right" ></b-icon> Dashboard</router-link>
                    <!-- <a href="/">
                      
                      <b-icon icon="chevron-bar-right" ></b-icon> Dashboard
                    </a> -->
                  </li>
                  
                  <li>
                    <router-link to="">
                     <b-icon icon="chevron-bar-right"></b-icon> Asset
                      <b-icon icon="caret-down-fill" ></b-icon>
                    </router-link>
                    <ul class="sidebar-nav collapse">
                      <li>
                         <router-link to="/department"> Department</router-link> 
                      </li>
                      <li>
                         <router-link to="/designation">Designation</router-link>  
                      </li>
                      <li>
                         <router-link to="/item">Item</router-link>  
                      </li>
                      <li>
                         <router-link to="/brand">Brand</router-link>  
                      </li>
                      <li>
                         <router-link to="/attribute">Attribute</router-link>  
                      </li>
                      <li>
                         <router-link to="/seller">Seller</router-link>  
                      </li>
                      <li>
                         <router-link to="/warranty">Warranty Period</router-link>  
                      </li>
                    </ul>
                  </li>
                  
                 
                  
                  <li>
                    <a href="">
                      <b-icon icon="chevron-bar-right"></b-icon> Insert
                      <b-icon icon="caret-down-fill"></b-icon>
                    </a>
                    <ul class="sidebar-nav collapse">
                      <li>
                        <router-link to="/client">Insert Client</router-link> 
                      </li>
                      <li>
                        <router-link to="/product">Insert Product</router-link> 
                      </li>
                    </ul>
                  </li>
                  <li>
                    <router-link to="/assign"><b-icon icon="chevron-bar-right" ></b-icon>Assign Product</router-link> 
                  </li>

                  <li v-if="userStatus==5">
                    <a href="">
                      <b-icon icon="chevron-bar-right"></b-icon> User
                      <b-icon icon="caret-down-fill"></b-icon>
                    </a>
                    <ul class="sidebar-nav collapse">
                      <li>
                        <router-link to="/user">User</router-link> 
                      </li>
                      <li>
                        <router-link to="/role">Role</router-link> 
                      </li>
                      <li>
                        <router-link to="/assignRole">Assign Role</router-link> 
                      </li>
                    </ul>
                  </li>

                  <!-- <li>
                    <a href="forms.html">
                       <b-icon icon="chevron-bar-right"></b-icon> Forms
                    </a>
                  </li>

                  <li>
                    <a href="screenful.html">
                        <b-icon icon="chevron-bar-right"></b-icon> Agile Metrics
                      <span class="label label-screenful">by Screenful</span>
                    </a>
                  </li> -->
                </ul>
              </nav>
            </div>
            <footer class="sidebar-footer">
              <ul class="sidebar-menu metismenu" id="customize-menu">
                <li>
                  <a href=""> .... </a>
                </li>
              </ul>
            </footer>
          </aside>

          <article class="content dashboard-page">
            <router-view></router-view>
          </article>
          <footer class="footer">
            <div class="footer-block buttons"></div>
            <div class="footer-block author">
              <ul>
                <li>created by <a href="#">Pintu</a></li>
              </ul>
            </div>
          </footer>
        </div>
      </div>
    </div>
  </div>
</template>
<style scoped>
.toogle-box{
  margin-left: 250px;
}
</style>

<script>
export default {
 props:['user'],
   data(){
    return{
      fullName:"",
      userStatus:null
    }
  },
  methods:{
 async logout(){
   let res = await this.callApi('get','/app/logout')
   window.location = '/login'
 }
  },
  created(){
    this.$store.commit('userDetails',this.user)
    if(!this.user){
      window.location = "/login"
    }
    this.fullName = this.user.fullName
    this.userStatus = this.user.isActive
    console.log(this.userStatus)
    // this.$store.commit('setUserPermission', this.permission)
  }
}
</script>