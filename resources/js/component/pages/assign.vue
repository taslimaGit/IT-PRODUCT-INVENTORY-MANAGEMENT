<template>
  <div class="container">
    <div class="row">
      <div class="col-sm-6">
        <div class="wrappar">
          <h2 class="head-title" color="success">Assign Product</h2>
          <div class="row">
            <div class="col-sm-12">
              <div class="box">
                <Select v-model="data.client_id" filterable>
                  <Option
                    v-for="client in clients"
                    :value="client.id"
                    :key="client.id"
                    >{{ client.clientName }}</Option
                  >
                </Select>
              </div>
            </div>
            <div class="col-sm-12">
              <div class="box">
                <Select v-model="data.product_id" filterable multiple>
                  <Option
                    v-for="item in products"
                    :value="item.id"
                    :key="item.id"
                    >{{ item.productName }}</Option
                  >
                </Select>
              </div>
            </div>
            <div class="col-sm-12">
              <div class="box text-right">
                <Button
                  @click="addData"
                  :loading="isAdding"
                  :disabled="isAdding"
                  type="success"
                  >{{ isAdding ? "Assign...." : "Assign" }}</Button
                >
              </div>
            </div>
          </div>
        </div>
      </div>



    </div>
  </div>
</template>
<style scoped>
.wrappar {
  border: 4px solid rgb(245 245 245);
  background: rgb(255 254 252);
  padding: 20px;
}
.box {
  padding: 15px 0;
}
.head-title {
  text-align: center;
  padding: 20px 0;
  font-size: 25px;
  font-weight: bold;
  color: #007500;
}
</style>
<script>
export default {
  data() {
    return {
      data: {
        client_id: null,
        product_id: [],
      },
      clients: [],
      products: [],
      isAdding: false,
    };
  },

  methods: {
    async addData() {
      if (!this.data.client_id) return this.i("Please Select Client");
      if (this.data.product_id < 1) return this.i("Please Select Product");

      this.isAdding = true;
      const res = await this.callApi(
        "post",
        "/app/store-client-product",
        this.data
      );
      if (res.status === 201) {
        // unshift the product 
       for (let k in this.data.product_id) {
        let i = 0;
        for (i in this.products) {
          if (this.data.product_id[k] == this.products[i].id) {           
            this.products.splice(i, 1);
            break;
          }
          i++;
        }
      }
        // this.searchDepartments.unshift(res.data);
        this.data.client_id = null;
        this.data.product_id = [];
        this.s("Data add successfully");
        this.addModal = false;
        this.isAdding = false;
      } else if (res.status == "422") {
        if (res.data.errors.product_id) {
          this.w(res.data.errors.product_id[0]);
        }
      } else {
        this.swf();
      }
      this.isAdding = false;
    },
  },

  async created() {
    const [client, pro] = await Promise.all([
      this.callApi("get", "/app/get-client-assign"),
      this.callApi("get", "/app/get-product-assign"),
    ]);
    this.clients = client.data;
    this.products = pro.data;
  },
};
</script>