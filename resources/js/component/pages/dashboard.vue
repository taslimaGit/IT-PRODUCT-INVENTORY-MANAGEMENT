<template>
  <div>
    <div class="container-fluid">
      <div class="row">
        <div class="col-sm-4" 
        v-for="(item, i) in items"
            :key="i"
            v-if="items.length"
        >
          <div class="box box1 shadow1">
            <h1>{{item.total}}</h1>
             <h3>{{ item.itemName }}</h3>
          </div>
        </div>
        
      </div>
    </div>
  </div>
</template>
<style scoped>
.box{  
   height: 150px;
    /* float: left; */
    background-color: rgb(57 86 121);
    margin: 10px;
    border-radius: 5px;
    box-shadow: 5px 4px 2px 4px #cccfd2;
}
.box h3, h1{
  font-family: 'Didact Gothic', sans-serif;
    font-weight: normal;
    text-align: center;    
    color: #fff;
}
.box h3{ 
    color: #e4ff00;
}
.box h1{
  padding-top: 15px;
     font-size: 60px;
    color: #04ff00;
}

</style>

<script>
// import { mapGetters } from "vuex";
export default {
  data() {
    return {
      items: [],
    };
  },
  methods: {},
  // computed: {
  //   ...mapGetters(["getUser"]),
  // },
  async created() {
    const res = await this.callApi("get", "/app/item-product");
    this.items = res.data.items;
    for (let i in this.items) {
      this.$set(this.items[i], "total", res.data.total[i]);
    }

    console.log(this.items);
  },
};
</script>