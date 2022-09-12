      <template>
  <div>
    <b-container fluid class="bv-example-row">
      <b-row>
        <b-col cols="6"
          ><Button type="primary" :value="addModal" @click="add_modal"
            >Add Client <b-icon icon="people-fill"></b-icon></Button
        ></b-col>

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
              <th scope="col">Client Name</th>
              <th scope="col">Department</th>
              <th scope="col">Designation</th>
              <th scope="col">Phone</th>
              <th scope="col">Action</th>
              <th scope="col">Report</th>
            </tr>
          </thead>
          <tbody>
            <tr
              v-for="(client, i) in filteredResources"
              v-if="filteredResources.length"
              :key="i"
            >
              <th scope="row">{{ i }}</th>
              <td>{{ client.clientName }}</td>
              <td>
                <span v-if="client.department">{{
                  client.department.departmentName
                }}</span>
                <span v-else
                  ><b class="text-danger">Deparment maybe deleted</b></span
                >
              </td>
              <td>
                <span v-if="client.designation">{{
                  client.designation.designationName
                }}</span>
                <span v-else
                  ><b class="text-danger">Designation maybe deleted</b></span
                >
              </td>
              <td>{{ client.phoneNo }}</td>
              <td>
                <Button size="small" @click="edit_data(client, i)"
                  ><b-icon icon="pencil-square" variant="info"></b-icon
                ></Button>
                <Button size="small" @click="change_active_status(client, i)">
                  <!-- {{client.activeStatus == 1 ? 
                  "<b-icon icon='person-check-fill' variant='success'></b-icon" : "<b-icon icon='person-check-fill' variant='danger'></b-icon"
                  }} -->
                  <span v-if="client.activeStatus == 1">
                    <b-icon icon="person-check-fill" variant="success"></b-icon>
                  </span>
                  <span v-else>
                    <b-icon icon="person-dash-fill" variant="danger"></b-icon>
                  </span>
                </Button>
                <Button size="small" @click="set_delete_data(client, i)"
                  ><b-icon icon="dash-circle-fill" variant="danger"></b-icon
                ></Button>
              </td>
              <td>
                <Button
                  size="small"
                  @click="view_product(client, i)"
                  title="Current Product"
                  ><b-icon icon="binoculars-fill" variant="info"></b-icon
                ></Button>

                <Button
                  size="small"
                  @click="report_view(client, i)"
                  title="Report"
                  ><b-icon icon="eye" variant="primary"></b-icon
                ></Button>
              </td>
            </tr>
          </tbody>
        </table>
      </div>

      <!-- Add Modal  -->
      <Modal
        v-model="addModal"
        :mask-closable="false"
        title="Add Client"
        :footer-hide="true"
        :closable="false"
      >
        <b-container fluid>
          <b-row class="my-1">
            <b-col sm="4">
              <label for="input-small">Client Name:</label>
            </b-col>
            <b-col sm="8">
              <b-form-input
                v-model="data.clientName"
                type="text"
                placeholder="Write Client Name...."
                @keyup.enter="addData"
                id="input-small"
                size="sm"
              ></b-form-input>
            </b-col>
          </b-row>
          <b-row class="my-1">
            <b-col sm="4">
              <label for="input-small">Department:</label>
            </b-col>
            <b-col sm="8">
              <Select
                v-model="data.department_id"
                filterable
                placeholder="Select Department"
              >
                <Option
                  v-for="(department, i) in departments"
                  :value="department.id"
                  :key="i"
                  >{{ department.departmentName }}</Option
                >
              </Select>
            </b-col>
          </b-row>
          <b-row class="my-1">
            <b-col sm="4">
              <label for="input-small">Designation:</label>
            </b-col>
            <b-col sm="8">
              <Select
                v-model="data.designation_id"
                filterable
                placeholder="Select Designation"
              >
                <Option
                  v-for="(designation, index) in designations"
                  :value="designation.id"
                  :key="index"
                  >{{ designation.designationName }}</Option
                >
              </Select>
            </b-col>
          </b-row>
          <b-row class="my-1">
            <b-col sm="4">
              <label for="input-small">Mobile</label>
            </b-col>
            <b-col sm="8">
              <b-form-input
                v-model="data.phoneNo"
                type="number"
                placeholder="Phone Number"
                @keyup.enter="addData"
                id="input-small"
                size="sm"
              ></b-form-input>
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
        title="Update Designation"
        :footer-hide="true"
        :closable="false"
      >
        <b-container fluid>
          <b-row class="my-1">
            <b-col sm="4">
              <label for="input-small">Client Name:</label>
            </b-col>
            <b-col sm="8">
              <b-form-input
                v-model="editData.clientName"
                type="text"
                placeholder="Write Client Name...."
                id="input-small"
                size="sm"
              ></b-form-input>
            </b-col>
          </b-row>
          <b-row class="my-1">
            <b-col sm="4">
              <label for="input-small">Department:</label>
            </b-col>
            <b-col sm="8">
              <Select
                v-model="editData.department_id"
                filterable
                placeholder="Select Department"
                @on-change="updata_department()"
              >
                <Option
                  v-for="(department, i) in departments"
                  :value="department.id"
                  :key="i"
                  >{{ department.departmentName }}</Option
                >
              </Select>
            </b-col>
          </b-row>
          <b-row class="my-1">
            <b-col sm="4">
              <label for="input-small">Designation:</label>
            </b-col>
            <b-col sm="8">
              <Select
                v-model="editData.designation_id"
                filterable
                placeholder="Select Designation"
                @on-change="updata_designation()"
              >
                <Option
                  v-for="(designation, index) in designations"
                  :value="designation.id"
                  :key="index"
                  >{{ designation.designationName }}</Option
                >
              </Select>
            </b-col>
          </b-row>
          <b-row class="my-1">
            <b-col sm="4">
              <label for="input-small">Mobile</label>
            </b-col>
            <b-col sm="8">
              <b-form-input
                v-model="editData.phoneNo"
                type="number"
                placeholder="Phone Number"
                @keyup.enter="update_data"
                id="input-small"
                size="sm"
              ></b-form-input>
            </b-col>
          </b-row>
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

      <!-- Active product modal  -->
      <Modal
        v-model="statusModal"
        :mask-closable="false"
        :footer-hide="true"
        :closable="true"
        :width="720"
      >
        <div class="container">
          <div class="header-m">
            <h4>Active Product</h4>
          </div>

          <table class="table table-sm">
            <thead>
              <tr>
                <th scope="col">#</th>
                <th scope="col">Product Id</th>
                <th scope="col">Product Name</th>
                <th scope="col">From</th>
                <th scope="col">Action</th>
              </tr>
            </thead>
            <tbody>
              <tr
                v-for="(current, i) in currentProducts"
                :key="i"
                v-if="currentProducts.length"
              >
                <th scope="row">1</th>
                <td>{{ current.product.product_id }}</td>
                <td>{{ current.product.productName }}</td>
                <td>{{ current.startDate }}</td>
                <td>
                  <div class="text-center">
                    <Button size="small" @click="deactive_product(current, i)"
                      ><b-icon icon="dash-circle-fill" variant="danger"></b-icon
                    ></Button>
                  </div>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </Modal>

      <!-- Report full screen modal  -->
      <Modal
        v-model="reportModal"
        :mask-closable="false"
        :footer-hide="true"
        :width="1080"
        :styles="{top: '20px'}"
      >
<div>
    <div class="container">
      <div class="text-right button-box"  >
       <Button type="success" ghost @click="print"><Icon type="ios-print" size="24" /></Button>
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
            6/1, Noimuddin Uddin, Mollah Bari Road, Tongi Gazipura, Gazipur
          </p>
        </div>
        <div class="item-wrappar" style="margin: 30px 0">
          <div class="row">
            <div class="col-sm-7">
              <p>
                <b>ID: {{clientReport.client_id }}</b>
              </p>
              <p>
                <b>Name: {{clientReport.clientName }}</b>
              </p>
              
              
              <span class="items text-right"><b>Department : </b>{{reportDepartment.departmentName}}</span>
              <span class="items"><b>Designation : </b>{{reportDesignation.designationName}}</span>
            </div>
            
          </div>
        </div>
        
        <div class="report">
          <table class="table table-sm">
            <thead>
              <tr>
                <th scope="col">#</th>
                <th scope="col">Product Id</th>
                <th scope="col">Product Name</th>
                <th scope="col">From</th>
                <th scope="col">To</th>
              </tr>
            </thead>
            <tbody>
              <tr
                v-for="(pc, i) in clientReport.productclient"
                :key="i"
                v-if="clientReport.productclient.length"
              >
                <th scope="row">1</th>
                <td>{{ pc.product_id }}</td>
                <td>{{ pc.productName }}</td>
                <td>{{ pc.pivot.startDate }}</td>
                <td v-if="(pc.pivot.activeStatus == 1)">Active</td>
                <td v-else-if="(pc.pivot.activeStatus == 0)">{{ pc.pivot.endDate }}</td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>

      </Modal>

      <!-- pagination  -->
      <Page
        @on-change="getData"
        :total="pageInfo.total"
        :current="pageInfo.current"
        :page-size="parseInt(pageInfo.per_page)"
        v-if="pageInfo && !this.searchQuery"
      />

      <delete-modal></delete-modal>
    </b-container>
  </div>
</template>
<style scoped>
.header-m h4 {
  color: green;
  font-weight: bold;
  text-align: center;
  padding: 23px 0;
}
.button-box{
  position: relative;
 top:50px;
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
      statusModal: false,
      reportModal: false,
      data: {
        clientName: "",
        department_id: "",
        designation_id: "",
        phoneNo: "",
      },
      editData: {
        clientName: "",
        department_id: "",
        designation_id: "",
        phoneNo: "",
      },
      updateData: {
        departmentName: "",
        designationName: "",
      },
      clients: [],
      departments: [],
      designations: [],
      searchClient: [],
      currentProducts: [],
      clientReport: {},
      reportDepartment:"",
      reportDesignation:"",
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
      if (this.data.clientName.trim() == "")
        return this.i("Client name is required");
      if (!this.data.department_id)
        return this.i("Department name is required");
      if (!this.data.designation_id)
        return this.i("Designation name is required");
      if (!this.data.phoneNo) return this.i("Phone number is required");
      this.isAdding = true;

      const res = await this.callApi("post", "/app/store-client", this.data);
      if (res.status === 201) {
        this.clients.unshift(res.data);
        this.searchClient.unshift(res.data);
        this.data.clientName = "";
        this.data.department_id = "";
        this.data.designation_id = "";
        this.data.phoneNo = "";
        this.s("Client add successfully");
        this.addModal = false;
        this.isAdding = false;
      } else if (res.status == 422) {
        if (res.data.errors) {
          for (let i in res.data.errors) {
            this.w(res.data.errors[i][0]);
          }
        }
      } else {
        this.swf();
      }
      this.isAdding = false;
    },

    // Edit Modal open
    edit_data(client, i) {
      let nameObj = {
        departmentName: client.department.departmentName,
        designationName: client.designation.designationName,
      };

      let obj = {
        id: client.id,
        clientName: client.clientName,
        department_id: client.department_id,
        designation_id: client.designation_id,
        phoneNo: client.phoneNo,
      };
      this.updateData = nameObj;
      this.editData = obj;
      this.index = i;
      this.editModal = true;
    },

    updata_department() {
      let depId = this.editData.department_id;
      this.departments.find((file) => {
        if (file.id === depId) {
          this.updateData.departmentName = file.departmentName;
        }
      });
    },
    updata_designation() {
      let degId = this.editData.designation_id;
      this.designations.find((file) => {
        if (file.id === degId) {
          this.updateData.designationName = file.designationName;
        }
      });
    },

    // Data Update
    async update_Data() {
      if (this.editData.clientName.trim() == "")
        return this.i("Client name is required");
      if (!this.editData.department_id)
        return this.i("Department name is required");
      if (!this.editData.designation_id)
        return this.i("Designation name is required");
      if (!this.editData.phoneNo) return this.i("Phone number is required");
      this.isAdding = true;
      const res = await this.callApi(
        "post",
        "/app/update-client",
        this.editData
      );
      console.log(res.data);
      if (res.status === 200) {
        this.s("Data Update Successfully");
        this.isAdding = false;
        // for search data
        for (var i in this.searchClient) {
          if (this.searchClient[i].id == this.editData.id) {
            // search arrey  update
            this.searchClient[i].clientName = this.editData.clientName;
            this.searchClient[i].department_id = this.editData.department_id;
            this.searchClient[
              i
            ].department.departmentName = this.updateData.departmentName;
            this.searchClient[i].designation_id = this.editData.designation_id;
            this.searchClient[
              i
            ].designation.designationName = this.updateData.designationName;
            this.searchClient[i].phoneNo = this.editData.phoneNo;
            break; //Stop this loop, we found it!
          }
        }
        // for pagination data
        for (var j in this.searchClient) {
          if (this.clients[j].id == this.editData.id) {
            // pagination arrey update
            this.clients[j].clientName = this.editData.clientName;
            this.clients[j].department_id = this.editData.department_id;
            this.clients[
              j
            ].department.departmentName = this.updateData.departmentName;
            this.clients[j].designation_id = this.editData.designation_id;
            this.clients[
              j
            ].designation.designationName = this.updateData.designationName;
            this.clients[j].phoneNo = this.editData.phoneNo;
            break; //Stop this loop, we found it!
          }
        }

        this.updateData.departmentName = "";
        this.updateData.designationName = "";
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

    // Active Status Change
    async change_active_status(client, i) {
      let dataObj = {
        id: client.id,
        activeStatus: client.activeStatus,
      };

      const res = await this.callApi(
        "post",
        "/app/active-status-change-client",
        dataObj
      );
      if (res.status === 200) {
        if (res.data.activeStatus == 0) {
          this.w("Deactive Client");
        } else {
          this.s("Active Client");
        }

        for (var i in this.clients) {
          if (this.clients[i].id == client.id) {
            this.clients[i].activeStatus = res.data.activeStatus;
            break;
          }
        }
        for (var j in this.searchClient) {
          if (this.searchClient[j].id == client.id) {
            this.searchClient[j].activeStatus = res.data.activeStatus;
            break;
          }
        }
      } else {
        this.swf();
      }
    },

    // Send delete data Store
    async set_delete_data(client, i) {
      this.deleteIndex = i;
      this.deleteId = client.id;
      const deleteModalData = {
        deleteModal: true,
        url: "/app/delete-client",
        id: client.id,
        name: client.clientName,
        // deleteIndex: i,
        isDelete: false,
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

    // // All Data Show with pagination
    async getData(page = 1) {
      const res = await this.callApi(
        "get",
        `/app/get-client?page=${page}&total=${this.total}`
      );
      if (res.status == 200) {
        this.clients = res.data.data;

        this.pageInfo = res.data;
      } else this.e("All Data not show succefully");
    },

    // Current product View
    async view_product(client, i) {
      let id = client.id;

      const res = await this.callApi(
        "get",
        `/app/client-current-product/${id}`
      );
      this.currentProducts = res.data;
      // console.log(res.data)

      this.statusModal = true;
    },

    async deactive_product(current, i) {
      let obj = {
        productID: current.product.id,
        clientProductId: current.id,
      };
      const res = await this.callApi(
        "post",
        "/app/client-product-dassign",
        obj
      );
      if (res.status === 201) {
        this.s("product Remove success");
        this.currentProducts.splice(i, 1);
      } else {
        this.swf();
      }
    },

    async report_view(client, i) {
      let id = client.id;

      const res = await this.callApi("get", `/app/client-report/${id}`);
      this.clientReport = res.data;
      this.reportDepartment = res.data.department
       this.reportDesignation = res.data.designation
      this.reportModal = true;
      // console.log(this.clientReport);
      console.log(this.reportDepartment);
    },

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
    const [dep, deg, res] = await Promise.all([
      this.callApi("get", "/app/get-all-department-client"),
      this.callApi("get", "/app/get-all-designation-client"),
      this.callApi("get", "/app/get-all-client"),
    ]);
    this.departments = dep.data;
    this.designations = deg.data;
    this.searchClient = res.data;
  },
  computed: {
    ...mapGetters(["getdeleteModuleObj", "getTotal"]),

    // Table Data
    filteredResources() {
      if (this.searchQuery) {
        return this.searchClient.filter((client) => {
          return this.searchQuery
            .toLowerCase()
            .split(" ")
            .every((v) => client.clientName.toLowerCase().includes(v));
        });
      } else {
        return this.clients;
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
        let k = 0;
        for (var i in this.searchClient) {
          if (this.searchClient[i].id == this.deleteId) {
            this.searchClient.splice(k, 1);
            break; //Stop this loop, we found it!
          }
          k++;
        }
        let m = 0;
        for (var j in this.clients) {
          if (this.clients[j].id == this.deleteId) {
            this.clients.splice(m, 1);
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