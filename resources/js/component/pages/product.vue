<template>
  <div>
    <b-container fluid class="bv-example-row">
      <b-row>
        <b-col cols="6"
          ><Button type="primary" :value="addModal" @click="add_modal" autofocus
            >Add Product</Button
          ></b-col
        >

        <b-col cols="5"
          ><label for="input-small"
            ><b-form-input
              v-model="searchQuery"
              type="text"
              placeholder="Search"
              id="input-small"
              size="sm"
            ></b-form-input></label
        ></b-col>
      </b-row>

      <!-- Data Table  -->
      <div class="table-wrappar">
        <table class="table table-bordered bg-white">
          <thead class="bg-info">
            <tr>
              <th scope="col">#</th>
              <th scope="col">Title</th>
              <th scope="col">Item</th>
              <th scope="col">Brand</th>
              <th scope="col">Purcess Date</th>
              <th scope="col">Action</th>
              <th scope="col">Report</th>
            </tr>
          </thead>
          <tbody>
            <tr
              v-for="(product, i) in filteredResources"
              v-if="filteredResources.length"
              :key="i"
            >
              <th scope="row">
                <Tag color="green">{{ product.serialNumber }}</Tag>
              </th>
              <td>
                <Tag color="primary">{{ product.productName }}</Tag>
              </td>
              <td>
                <Tag color="cyan">{{ product.item.itemName }}</Tag>
              </td>
              <td>
                <Tag color="blue">{{ product.brand.brandName }}</Tag>
              </td>
              <td>
                <Tag color="default">{{ product.purcessDate }}</Tag>
              </td>
              <td>
                <Button
                  size="small"
                  @click="edit_data(product, i)"
                  title="Update Data"
                  ><b-icon icon="pencil-square" variant="info"></b-icon
                ></Button>
                <Button
                  size="small"
                  @click="set_delete_data(product, i)"
                  title="End of life"
                  ><b-icon icon="minecart-loaded" variant="danger"></b-icon
                ></Button>
              </td>
              <td>
                <Button
                  v-if="product.assignStatus == 1"
                  size="small"
                  title="Client Active"
                  ><b-icon icon="people-fill" variant="warning"></b-icon
                ></Button>
                <Button v-else size="small" title="No client"
                  ><b-icon icon="people-fill" variant="success"></b-icon
                ></Button>
                <!-- <Button size="small" @click="$router.push(`/productreport/${product.id}`)" title="View Report"
                  ><b-icon icon="eye" variant="primary" ></b-icon
                ></Button> -->
                <Button
                  size="small"
                  @click="report_view(product, i)"
                  title="View Report"
                  ><b-icon icon="eye" variant="primary"></b-icon
                ></Button>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
      <Page
        @on-change="getData"
        :total="pageInfo.total"
        :current="pageInfo.current"
        :page-size="parseInt(pageInfo.per_page)"
        v-if="pageInfo && !this.searchQuery"
      />
      <!-- Add Modal  -->
      <Modal
        v-model="addModal"
        :mask-closable="false"
        title="Add Product"
        :footer-hide="true"
        :closable="false"
        :width="720"
      >
        <b-container fluid>
          <!-- Product Name  -->
          <b-row class="my-1">
            <b-col sm="4">
              <label for="input-small">Product Name:</label>
            </b-col>
            <b-col sm="8">
              <b-form-input
                v-model="data.productName"
                type="text"
                placeholder="Write Product Name...."
                @keyup.enter="addData"
                id="input-small"
                size="sm"
              ></b-form-input>
            </b-col>
          </b-row>

          <!-- Seller select option  -->
          <b-row class="my-1">
            <b-col sm="4">
              <label for="input-small">Shop Name:</label>
            </b-col>
            <b-col sm="4">
              <Select
                v-model="data.seller_id"
                filterable
                placeholder="Select seller"
              >
                <Option
                  v-for="(seller, i) in sellers"
                  :value="seller.id"
                  :key="i"
                  >{{ seller.sellerName }}</Option
                >
              </Select>
            </b-col>

            <!-- Adress  -->
            <b-col sm="4">
              <b-form-input
                v-model="data.location"
                type="text"
                placeholder="Location"
                id="input-small"
                size="sm"
              ></b-form-input>
            </b-col>
          </b-row>

          <!-- Item select option  -->
          <b-row class="my-1">
            <b-col sm="4">
              <label for="input-small">Item:</label>
            </b-col>
            <b-col sm="8">
              <Select
                v-model="data.item_id"
                filterable
                placeholder="Select Item"
              >
                <Option v-for="(item, i) in items" :value="item.id" :key="i">{{
                  item.itemName
                }}</Option>
              </Select>
            </b-col>
          </b-row>

          <!-- Brand select Option  -->
          <b-row class="my-1">
            <b-col sm="4">
              <label for="input-small">Brand:</label>
            </b-col>
            <b-col sm="8">
              <Select
                v-model="data.brand_id"
                filterable
                placeholder="Select Item"
              >
                <Option
                  v-for="(brand, i) in brands"
                  :value="brand.id"
                  :key="i"
                  >{{ brand.brandName }}</Option
                >
              </Select>
            </b-col>
          </b-row>

          <!-- Attribute select option  -->
          <b-row class="my-1">
            <b-col sm="4">
              <label for="input-small">Attribute:</label>
            </b-col>
            <b-col sm="8">
              <Select
                v-model="selectAttributes"
                filterable
                placeholder="Select Attribute"
                multiple
              >
                <Option
                  v-for="(attribute, i) in productAttribute"
                  :value="attribute.attributeName"
                  :key="i"
                  >{{ attribute.attributeName }}</Option
                >
              </Select>
            </b-col>
          </b-row>

          <!-- Attributes input fileds  -->
          <b-row class="my-1">
            <b-col sm="4"></b-col>
            <b-col sm="8">
              <b-row class="my-1">
                <b-col sm="4" v-for="(att, j) in selectAttributes" :key="j">
                  {{ att }} :
                  <b-form-input
                    v-model="data.attributes[att]"
                    type="text"
                    @keyup.enter="addData"
                    id="input-small"
                    size="sm"
                  ></b-form-input>
                </b-col>
              </b-row>
            </b-col>
          </b-row>

          <!-- Serial Number  -->
          <b-row class="my-1">
            <b-col sm="4">
              <label for="input-small">Serial Number:</label>
            </b-col>
            <b-col sm="8">
              <b-form-input
                v-model="data.serialNumber"
                type="text"
                placeholder="Serial Number"
                id="input-small"
                size="sm"
              ></b-form-input>
            </b-col>
          </b-row>

          <!-- Date Picker  -->
          <b-row class="my-1">
            <b-col sm="4">
              <label for="input-small">Purcess Date:</label>
            </b-col>
            <b-col sm="8">
              <input
                v-model="data.purcessDate"
                class="form-control"
                type="date"
              />
            </b-col>
          </b-row>

          <!-- Warranty  -->
          <b-row class="my-1">
            <b-col sm="4"> </b-col>
            <b-col sm="8">
              <Checkbox v-model="data.warranty"> Warranty</Checkbox>
            </b-col>
          </b-row>

          <!-- Warranty Details  -->
          <b-row class="my-1" v-if="data.warranty">
            <b-col sm="4">
              <label for="input-small">Warranty Details:</label>
            </b-col>
            <b-col sm="8">
              <Select
                v-model="data.warranty_id"
                filterable
                placeholder="Select Item"
              >
                <Option
                  v-for="(warranty, i) in warrantys"
                  :value="warranty.id"
                  :key="i"
                  >{{ warranty.periodTime }}</Option
                >
              </Select>
            </b-col>
          </b-row>
        </b-container>
        <br /><br />
        <hr />
        <br />
        <div class="text-right">
          <Button type="default" @click="modalCancel('add')">Cancel</Button>
          <Button
            @click="addData"
            :loading="isAdding"
            :disabled="isAdding"
            type="success"
            >{{ isAdding ? "Adding...." : "Add" }}</Button
          >
        </div>
      </Modal>

      <!-- Edit modal  -->
      <Modal
        v-model="editModal"
        :mask-closable="false"
        title="Update Product"
        :footer-hide="true"
        :closable="true"
        :width="720"
      >
        <b-container fluid>
          <!-- Product Name  -->
          <b-row class="my-1">
            <b-col sm="4">
              <label for="input-small">Product Name:</label>
            </b-col>
            <b-col sm="8">
              <b-form-input
                v-model="editData.productName"
                type="text"
                placeholder="Write Product Name...."
                @keyup.enter="addData"
                id="input-small"
                size="sm"
              ></b-form-input>
            </b-col>
          </b-row>

          <!-- Seller select option  -->
          <b-row class="my-1">
            <b-col sm="4">
              <label for="input-small">Shop Name:</label>
            </b-col>
            <b-col sm="4">
              <Select
                v-model="editData.seller_id"
                filterable
                placeholder="Select Item"
                @on-change="update_seller()"
              >
                <Option
                  v-for="(seller, i) in sellers"
                  :value="seller.id"
                  :key="i"
                  >{{ seller.sellerName }}</Option
                >
              </Select>
            </b-col>

            <b-col sm="4">
              <b-form-input
                v-model="editData.location"
                type="text"
                placeholder="Location"
                @keyup.enter="addData"
                id="input-small"
                size="sm"
              ></b-form-input>
            </b-col>
          </b-row>

          <!-- Item select option  -->
          <b-row class="my-1">
            <b-col sm="4">
              <label for="input-small">Item:</label>
            </b-col>
            <b-col sm="8">
              <Select
                v-model="editData.item_id"
                filterable
                placeholder="Select Item"
                @on-change="update_item()"
              >
                <Option v-for="(item, i) in items" :value="item.id" :key="i">{{
                  item.itemName
                }}</Option>
              </Select>
            </b-col>
          </b-row>

          <!-- Brand select Option  -->
          <b-row class="my-1">
            <b-col sm="4">
              <label for="input-small">Brand:</label>
            </b-col>
            <b-col sm="8">
              <Select
                v-model="editData.brand_id"
                filterable
                placeholder="Select Item"
                @on-change="update_brand()"
              >
                <Option
                  v-for="(brand, i) in brands"
                  :value="brand.id"
                  :key="i"
                  >{{ brand.brandName }}</Option
                >
              </Select>
            </b-col>
          </b-row>

          <!-- Attribute select option  -->
          <b-row class="my-1">
            <b-col sm="4">
              <label for="input-small">Attribute:</label>
            </b-col>
            <b-col sm="8">
              <Select
                v-model="selectAttributes"
                filterable
                placeholder="Select Attribute"
                multiple
              >
                <Option
                  v-for="(attribute, i) in productAttribute"
                  :value="attribute.attributeName"
                  :key="i"
                  >{{ attribute.attributeName }}</Option
                >
              </Select>
            </b-col>
          </b-row>

          <!-- Attributes input fileds  -->
          <b-row class="my-1">
            <b-col sm="4"></b-col>
            <b-col sm="8">
              <b-row class="my-1">
                <b-col sm="4" v-for="(att, j) in selectAttributes" :key="j">
                  {{ att }} :
                  <b-form-input
                    v-model="editData.attributes[att]"
                    type="text"
                    @keyup.enter="addData"
                    id="input-small"
                    size="sm"
                  ></b-form-input>
                </b-col>
              </b-row>
            </b-col>
          </b-row>

          <!-- Serial Number  -->
          <b-row class="my-1">
            <b-col sm="4">
              <label for="input-small">Serial Number:</label>
            </b-col>
            <b-col sm="8">
              <b-form-input
                v-model="editData.serialNumber"
                type="text"
                placeholder="Serial Number"
                id="input-small"
                size="sm"
              ></b-form-input>
            </b-col>
          </b-row>

          <!-- Date Picker  -->
          <b-row class="my-1">
            <b-col sm="4">
              <label for="input-small">Purcess Date:</label>
            </b-col>
            <b-col sm="8">
              <input
                v-model="editData.purcessDate"
                class="form-control"
                type="date"
              />
            </b-col>
          </b-row>

          <!-- Warranty  -->
          <b-row class="my-1">
            <b-col sm="4"> </b-col>
            <b-col sm="8">
              <Checkbox v-model="editData.warranty"> Warranty</Checkbox>
            </b-col>
          </b-row>

          <!-- Warranty Details  -->
          <b-row class="my-1" v-if="editData.warranty">
            <b-col sm="4">
              <label for="input-small">Warranty Details:</label>
            </b-col>
            <b-col sm="8">
              <Select
                v-model="editData.warranty_id"
                filterable
                placeholder="Select Item"
              >
                <Option
                  v-for="(warranty, i) in warrantys"
                  :value="warranty.id"
                  :key="i"
                  >{{ warranty.periodTime }}</Option
                >
              </Select>
            </b-col>
          </b-row>

          <!-- <b-row class="my-1" v-if="editData.warranty">
            <b-col sm="4">
              <label for="input-small">Warranty Details:</label>
            </b-col>
            <b-col sm="8">
              <b-form-input
                v-model="editData.warrantyDetails"
                type="text"
                placeholder="Warranty Details"
                id="input-small"
                size="sm"
              ></b-form-input>
            </b-col>
          </b-row> -->
        </b-container>
        <br /><br />
        <hr />
        <br />
        <div class="text-right">
          <Button type="default" @click="modalCancel('edit')">Cancel</Button>
          <Button
            @click="update_Data"
            :loading="isAdding"
            :disabled="isAdding"
            type="success"
            >{{ isAdding ? "Updating...." : "Update" }}</Button
          >
        </div>
      </Modal>

      <!-- Report full screen modal  -->
      <Modal
        v-model="reportModal"
        :mask-closable="false"
        :footer-hide="true"
        :width="1080"
        :styles="{ top: '20px' }"
      >
        <div>
          <div class="container">
            <div class="text-right button-box">
              <Button type="success" ghost @click="print"
                ><Icon type="ios-print" size="24"
              /></Button>
              <!-- <button type="button" class="btn btn-light" @click="print">Print</button> -->
            </div>
            <div
              class="wrappar"
              style="background: white; padding: 35px 20px"
              id="printme"
            >
              <div class="cheader">
                <h3 class="text-center">Taratex Fashion Ltd</h3>
                <p class="text-center">
                  6/1, Noimuddin Uddin, Mollah Bari Road, Tongi Gazipura,
                  Gazipur
                </p>
              </div>
              <div class="item-wrappar" style="margin-top: 30px">
                <div class="row">
                  <div class="col-sm-7">
                    <h4>{{ report.sellerName }}</h4>
                    <p>({{ report.location }})</p>
                    <p>
                      <b>S/N: {{ report.serialNumber }}</b>
                    </p>
                    <span class="items text-right"
                      ><b>Item : </b>{{ report.itemName }}</span
                    >
                    <span class="items"
                      ><b>Brand : </b>{{ report.brandName }}</span
                    >
                  </div>
                  <div class="col-sm-5">
                    <div class="text-right" v-if="report.warranty == 1">
                      <span class="items text-center"
                        ><b>Warranty: </b>{{report.periodTime}}</span
                      >
                    </div>
                  </div>
                </div>
              </div>
              <div class="product-wrappar" style="margin: 30px 0">
                <h5>{{ report.productName }}</h5>
                <span
                  class="items"
                  style="margin: 0 20px 0 0; font-size: 15px"
                  v-for="(att, i) in report.attributes"
                  :key="i"
                  v-if="report.attributes.length"
                  ><b>{{ att.attributeName }} : </b
                  >{{ att.attributeValue }}</span
                >
                <p>
                  <b>Purcess Date: {{ report.purcessDate }}</b>
                </p>
              </div>
              <div class="report">
                <table class="table table-sm">
                  <thead>
                    <tr>
                      <th scope="col">#</th>
                      <th scope="col">Client Name</th>
                      <th scope="col">Department Name</th>
                      <th scope="col">From</th>
                      <th scope="col">To</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr
                      v-for="(cp, i) in report.clientProduct"
                      :key="i"
                      v-if="report.clientProduct.length"
                    >
                      <th scope="row">1</th>
                      <td>{{ cp.clientName }}</td>
                      <td>{{ cp.departmentName }}</td>
                      <td>{{ cp.pivot.startDate }}</td>
                      <td v-if="cp.pivot.activeStatus == 1">Active</td>
                      <td v-else-if="cp.pivot.activeStatus == 0">
                        {{ cp.pivot.endDate }}
                      </td>
                    </tr>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        </div>
      </Modal>

      <delete-modal></delete-modal>
    </b-container>
  </div>
</template>

<style scoped>
.button-box {
  position: relative;
  top: 50px;
  padding-right: 20px;
}
.wrappar {
  background: white;
  padding: 35px 20px;
}
.item-wrappar {
  margin-top: 30px;
}
.items {
  margin: 0 20px 0 0;
  font-size: 15px;
}
.items b {
  font-size: 16px;
}
.product-wrappar {
  margin: 30px 0;
}
.product-wrappar h5 {
  font-weight: bold;
  font-size: 16px;
}
</style>

<script>
import deleteModal from "./common/delete.vue";
import { mapGetters } from "vuex";
export default {
  data() {
    return {
      searchQuery: "",
      addModal: false,
      editModal: false,
      reportModal: false,
      data: {
        productName: "",
        seller_id: "",
        location: "",
        item_id: "",
        brand_id: "",
        attributes: {},
        attribute: "",
        serialNumber: "",
        purcessDate: "",
        warranty: false,
        warranty_id: "",
      },

      editData: {
        productName: "",
        seller_id: "",
        location: "",
        item_id: "",
        brand_id: "",
        attributes: {},
        attribute: "",
        serialNumber: "",
        purcessDate: "",
        warranty: "",
        warranty_id: "",
      },
      report: {
        productId: "",
        productName: "",
        sellerName: "",
        location: "",
        itemName: "",
        brandName: "",
        serialNumber: "",
        purcessDate: "",
        periodTime: "",
        warranty: "",
        attributes: [],
        clientProduct: [],
        department: [],
      },
      updateData: {},
      selectAttributes: [],
      productAttribute: [],
      products: [],
      items: [],
      brands: [],
      sellers: [],
      warrantys: [],
      searchProduct: [],
      isAdding: false,
      total: null,
      pageInfo: null,
      deleteIndex: null,
      index: null,
      deleteId: null,
    };
  },
  methods: {
    add_modal() {
      this.addModal = true;
    },
    // Add data
    async addData() {
      let fa = [];
      let a = [];
      // Make Filed from object
      a = Object.keys(this.data.attributes).map((field) => {
        return {
          attributeName: field,
          attributeValue: this.data.attributes[field],
        };
      });
      for (let i in this.selectAttributes) {
        for (let j in a) {
          if (this.selectAttributes[i] == a[j].attributeName) fa.push(a[j]);
        }
      }
      this.data.attribute = JSON.stringify(fa);

      if (this.data.productName.trim() == "")
        return this.i("Product name is required");

      if (!this.data.seller_id) return this.i("Please Select Shope Name");
      if (this.data.location.trim() == "")
        return this.i("Location is required");
      if (!this.data.item_id) return this.i("Please select Item Type");
      if (!this.data.brand_id) return this.i("Please select Brand Name");
      if (!this.data.serialNumber) return this.i("Serial Number is required");
      if (!this.data.purcessDate) return this.i("Purcess Date is required");

      if (this.data.warranty) {
        if (!this.data.warranty_id)
          return this.i("Please Select Warranty Types");
      }
      // console.log(this.data)

      this.isAdding = true;
      const res = await this.callApi("post", "/app/store-product", this.data);
      if (res.status === 201) {
        this.products.unshift(res.data);
        // this.searchDepartments.unshift(res.data);
        this.data.productName = "";
        this.data.location = "";
        this.data.seller_id = "";
        this.data.item_id = "";
        this.data.brand_id = "";
        this.selectAttributes = [];
        this.data.attributes = {};
        this.data.serialNumber = "";
        this.data.purcessDate = "";
        this.data.warranty = false;
        this.data.warranty_id = "";
        this.s("Data add successfully");
        this.addModal = false;
        this.isAdding = false;
      } else if (res.status == "422") {
        if (res.data.errors.productName) {
          this.w(res.data.errors.productName[0]);
        }
      } else {
        this.swf();
      }
      this.isAdding = false;
    },

    // Edit Modal open
    edit_data(product, i) {
      // Warranty Check
      if (product.warranty == 1) {
        product.warranty = true;
      } else if (product.warranty == true) {
        product.warranty = true;
      } else if (product.warranty == 0) {
        product.warranty = false;
      } else if (product.warranty == false) {
        product.warranty = false;
      }
      this.selectAttributes = [];

      let a = JSON.parse(product.attribute);
      let newObj;
      // array to object convert and set value attributes field
      if (a != null) {
        newObj = a.reduce(function (acc, curr) {
          acc[curr.attributeName] = curr.attributeValue;
          return acc;
        }, {});
      } else {
        newObj = {};
      }
      // Set Select attribute Data
      if (a != null) {
        for (i in a) {
          this.selectAttributes.push(a[i].attributeName);
        }
      }
      let obj = {
        id: product.id,
        productName: product.productName,
        seller_id: product.seller_id,
        location: product.location,
        item_id: product.item.id,
        brand_id: product.brand.id,
        attributes: newObj,
        serialNumber: product.serialNumber,
        purcessDate: product.purcessDate,
        warranty: product.warranty,
        warranty_id: product.warranty_id,
      };
      this.editData = obj;
      this.index = i;
      this.editModal = true;
    },

    // Update Seller Name set
    update_seller() {
      let sellerId = this.editData.seller_id;
      this.sellers.find((file) => {
        if (file.id === sellerId) {
          this.updateData.seller = file;
        }
      });
    },

    // Update Item Name set
    update_item() {
      let itemId = this.editData.item_id;
      this.items.find((file) => {
        if (file.id === itemId) {
          this.updateData.item = file;
        }
      });
    },

    // Update Brand Name set
    update_brand() {
      let brandId = this.editData.brand_id;
      this.brands.find((file) => {
        if (file.id === brandId) {
          this.updateData.brand = file;
        }
      });
    },
    // Data Update
    async update_Data() {
      let fa = [];
      let a = [];
      // Make Filed from object
      a = Object.keys(this.editData.attributes).map((field) => {
        return {
          attributeName: field,
          attributeValue: this.editData.attributes[field],
        };
      });
      for (let i in this.selectAttributes) {
        for (let j in a) {
          if (this.selectAttributes[i] == a[j].attributeName) fa.push(a[j]);
        }
      }
      this.editData.attribute = JSON.stringify(fa);

      if (this.editData.productName.trim() == "")
        return this.i("Product name is required");
      if (!this.editData.seller_id) return this.i("Please select Shop Name");
      if (this.editData.location.trim() == "")
        return this.i("Location is required");
      if (!this.editData.item_id) return this.i("Please select Item Type");
      if (!this.editData.brand_id) return this.i("Please select Brand Name");
      if (!this.editData.purcessDate) return this.i("Purcess Date is required");
      if (this.editData.warranty) {
        if (!this.editData.warranty_id)
          return this.i("Please Select Warranty Types");
      }

      this.isAdding = true;
      const res = await this.callApi(
        "post",
        "/app/update-product",
        this.editData
      );
      this.isAdding = false;
      if (res.status === 200) {
        this.s("Data Update Successfully");
        // for search data
        // for (var i in this.searchDepartments) {
        //   if (this.searchDepartments[i].id == this.editData.id) {
        //     this.searchDepartments[
        //       i
        //     ].departmentName = this.editData.departmentName;
        //     break; //Stop this loop, we found it!
        //   }
        // }
        // for pagination data
        for (var j in this.products) {
          if (this.products[j].id == this.editData.id) {
            this.products[j].productName = this.editData.productName;
            this.products[j].location = this.editData.location;
            this.products[j].seller_id = this.editData.seller_id;
            if (this.updateData.seller) {
              this.products[j].seller = this.updateData.seller;
            }
            this.products[j].item_id = this.editData.item_id;
            if (this.updateData.item) {
              this.products[j].item = this.updateData.item;
            }
            this.products[j].brand_id = this.editData.brand_id;
            if (this.updateData.brand) {
              this.products[j].brand = this.updateData.brand;
            }
            this.products[j].attribute = this.editData.attribute;
            this.products[j].serialNumber = this.editData.serialNumber;
            this.products[j].purcessDate = res.data.purcessDate;
            this.products[j].warranty = this.editData.warranty;
            this.products[j].warranty_id = this.editData.warranty_id;
            break; //Stop this loop, we found it!
          }
        }

        this.editModal = false;
      } else if (res.status === 422) {
        if (res.data.errors) {
          for (let i in res.data.errors) {
            this.w(res.data.errors[i][0]);
            this.isAdding = false;
          }
        }
      } else {
        this.swf();
        this.isAdding = false;
      }
    },

    // Send delete data Store
    async set_delete_data(product, i) {
      this.deleteIndex = i;
      this.deleteId = product.id;
      const deleteModalData = {
        deleteModal: true,
        url: "/app/delete-product",
        id: product.id,
        name: product.productName,
        // deleteIndex: i,
        isDelete: false,
        msg: "( If yes? This product will no longer more that mean product life end )",
      };
      this.$store.commit("setDeleteModalData", deleteModalData);
      // if(!confirm("Are you sure delete "+department.departmentName)) return
      // this.$set(department, 'isDeleting', true)

      // const res = await this.callApi('post', '/app/delete-depertment', department)
      // if(res.status === 200){
      //   this.departments.splice(i,1)
      //   this.s('Data Delete Succesfully')
      // }else{
      //   this.swf()
      // }
    },

    // All Data Show with pagination
    async getData(page = 1) {
      const res = await this.callApi(
        "get",
        `/app/get-product?page=${page}&total=${this.total}`
      );
      if (res.status == 200) {
        this.products = res.data.data;
        this.pageInfo = res.data;
      } else this.e("All Data not show succefully");
    },

    //  report view
    async report_view(product, i) {
      let id = product.id;

      const res = await this.callApi("get", `/app/product-report/${id}`);
      if (res.status == 200) {
        this.report.department = res.data.department;
        res.data = res.data.data;
        (this.report.productId = res.data.product_id),
          (this.report.productName = res.data.productName);
        this.report.sellerName = res.data.seller.sellerName;
        this.report.location = res.data.location;
        this.report.itemName = res.data.item.itemName;
        this.report.brandName = res.data.brand.brandName;
        this.report.serialNumber = res.data.serialNumber;
        this.report.purcessDate = res.data.purcessDate;
        this.report.warranty = res.data.warranty;
        this.report.periodTime = res.data.wd.periodTime;
        this.report.attributes = JSON.parse(res.data.attribute);
        this.report.clientProduct = res.data.clientproduct;

        // bind the department Name with  clientproduct
        for (let i in this.report.clientProduct) {
          this.$set(
            this.report.clientProduct[i],
            "departmentName",
            this.report.department[i].departmentName
          );
        }
        this.reportModal = true;
        console.log(this.report.periodTime);
      }
    },
    // print
    print() {
      this.$htmlToPaper("printme");
    },

    // Cancel Modal
    modalCancel(c) {
      if (c == "add") {
        this.data.departmentName = "";
        this.addModal = false;
      } else {
        this.editModal = false;
      }
    },
  },
  async created() {
    this.total = this.getTotal;
    this.getData();

    const [seller, itm, brand, att, allpro, warranty] = await Promise.all([
      this.callApi("get", "/app/get-all-seller-product"),
      this.callApi("get", "/app/get-all-item-product"),
      this.callApi("get", "/app/get-all-brand-product"),
      this.callApi("get", "/app/get-all-attribute-product"),
      this.callApi("get", "/app/get-all-product"),
      this.callApi("get", "/app/get-all-period-product"),
    ]);
    this.sellers = seller.data;
    this.items = itm.data;
    this.brands = brand.data;
    this.productAttribute = att.data;
    this.searchProduct = allpro.data;
    this.warrantys = warranty.data;
  },
  computed: {
    ...mapGetters(["getdeleteModuleObj", "getTotal"]),

    // Table Data
    filteredResources() {
      if (this.searchQuery) {
        return this.searchProduct.filter((product) => {
          return this.searchQuery
            .toLowerCase()
            .split(" ")
            .every((v) => product.serialNumber.toLowerCase().includes(v));
        });
      } else {
        return this.products;
      }
    },
  },
  components: {
    deleteModal,
  },
  watch: {
    // For Delete watch
    getdeleteModuleObj(obj) {
      if (obj.isDelete) {
        // let k = 0;
        // for (var i in this.searchDepartments) {
        //   if (this.searchDepartments[i].id == this.deleteId) {
        //     this.searchDepartments.splice(k, 1);

        //     break; //Stop this loop, we found it!
        //   }
        //   k++;
        // }
        let m = 0;
        for (var j in this.products) {
          if (this.products[j].id == this.deleteId) {
            this.products.splice(m, 1);
            // this.searchQuery = ""
            break;
          }
          m++;
        }
      }
    },
  },
};
</script>