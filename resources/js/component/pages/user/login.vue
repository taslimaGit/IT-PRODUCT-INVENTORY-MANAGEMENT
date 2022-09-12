<template>
  <div class="container">
    <!--~~~~~~~ TABLE ONE ~~~~~~~~~-->
    <Modal
      v-model="loginModal"
      style="background-color: red"
      :mask-closable="false"
      :closable="false"
      :footer-hide="true"
      fullscreen
    >
      <div class="wrappar">
        <div class="login-wrappar">
          <div class="login-box">
            <h2 class="login-header text-center">Taratex Fashion Ltd</h2>
            <div class="space">
              <Input v-model="data.userName" type="text" placeholder="user name" />
            </div>
          <div class="space">
            <Input
              v-model="data.password"
              type="password"
              placeholder="*****"
            />
          </div>
          <div class="space">
            <div class="login-footer text-right">
              <Button type="success" @click="login" :disabled="isLogin">{{
                isLogin ? "login...." : "Login"
              }}</Button>
            </div>
          </div>
</div>
        </div>
      </div>
    </Modal>

  </div>
</template>

<style scoped>
.wrappar {
  position: absolute;
  background: cadetblue;
  top: 0;
  left: 0;
  bottom: 0;
  width: 100%;
}
.login-header{
margin: 25px 0;
    font-family: math;
    font-weight: bolder;
}

.login-wrappar {
  width: 400px;
  margin: 0 auto;
  position: relative;
  top: 150px;
}
.space{
  margin: 10px;
}
.login-box{
background: rgb(255, 255, 255);
 padding: 25px;
}
</style>
<script>
import { mapGetters } from "vuex";
export default {
  data() {
    return {
      loginModal: true,
      data: {
        userName: "",
        password: "",
      },
      isLogin: false,
    };
  },
  methods: {
    async login() {
      if (this.data.userName.trim() == "") return this.w("User name is required");
      if (this.data.password.trim() == "")
        return this.w("Password is required");
      
      this.isLogin = true;
      const res = await this.callApi("post", "app/login-check", this.data);      
      if (res.status == 200) {
        this.$store.commit('userDetails',this.user)
        this.data.userName = "";
        this.data.password = "";
        this.s("Login Successfully");         
        window.location = "/";        
      } else if (res.status === 422) {
        for (let i in res.data.errors) {
          this.i(res.data.errors[i][0]);
        }
      } else {
        if (res.status == 401) {
          this.w("Incorrect User name or password");
        } else {
          this.swf();
        }
      }
      this.isLogin = false;
    },
        authCheck() {
      if (this.getUser) {
        window.location = "/";
      }
    },
  },
    computed: {
    ...mapGetters(["getUser"]),
  },
   async created() {
    this.authCheck();
    const res = await this.callApi('post','http://192.168.0.66:5000/api/auth/me?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xOTIuMTY4LjAuNjY6NTAwMFwvYXBpXC9hdXRoXC9sb2dpbiIsImlhdCI6MTYxNzc3MDQ4NywiZXhwIjoxNjE3Nzc0MDg3LCJuYmYiOjE2MTc3NzA0ODcsImp0aSI6Imo4YWdOYmxQM0YwMlNiRFYiLCJzdWIiOjEwLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.NDl7-pdcWyHHDAb_NUF0cNlpMTPXCab594hlS-rCHDA')
    console.log(res)
  },
};
</script>