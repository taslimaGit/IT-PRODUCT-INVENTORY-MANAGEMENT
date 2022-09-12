<template>
  <div>
    <b-container fluid class="bv-example-row">
      <b-row>
        <b-col cols="6"
          ><Button type="primary" :value="addModal" @click="add_modal" autofocus
            >Add Warranty Period</Button
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
              <th scope="col">Period Name</th>
              <th scope="col">Action</th>
            </tr>
          </thead>
          <tbody>
            <tr
              v-for="(period, i) in filteredResources"
              v-if="filteredResources.length"
              :key="i"
            >
              <th scope="row">{{ i }}</th>
              <td>{{ period.periodTime }}</td>
              <td>
                <Button size="small" @click="edit_data(period, i)"
                  ><b-icon icon="pencil-square" variant="info"></b-icon
                ></Button>
                <Button size="small" @click="set_delete_data(period, i)"
                  ><b-icon icon="trash-fill" variant="warning"></b-icon
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
        title="Add Warranty"
        :footer-hide="true"
        :closable="false"
      >
        <b-container fluid>
          <b-row class="my-1">
            <b-col sm="4">
              <label for="input-small">Period Time:</label>
            </b-col>
            <b-col sm="8">
              <b-form-input
                v-model="data.periodTime"
                type="text"
                placeholder="Write Period Time...."
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
        title="Update Period Time"
        :footer-hide="true"
        :closable="false"
      >
        <b-container fluid>
          <b-row class="my-1">
            <b-col sm="4">
              <label for="input-small">Period Time</label>
            </b-col>
            <b-col sm="8">
              <b-form-input
                v-model="editData.periodTime"
                type="text"
                placeholder="Write Period Time...."
                @keyup.enter="update_Data"
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

      <delete-modal></delete-modal>
    </b-container>
  </div>
</template>
<script>
import deleteModal from "./common/delete.vue";
import { mapGetters } from "vuex";
export default {
  data() {
    return {
      searchQuery: "",
      addModal: false,
      editModal: false,
      data: {
        periodTime: "",
      },
      editData: {
        periodTime: "",
      },
      periodTimes: [],
      searchPeriodTime: [],
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
      if (this.data.periodTime.trim() == "")
        return this.i("Period Time name is required");
      this.isAdding = true;
      const res = await this.callApi(
        "post",
        "/app/store-period",
        this.data
      );
      if (res.status === 201) {
        this.periodTimes.unshift(res.data);
        this.searchPeriodTime.unshift(res.data);
        this.data.periodTime = "";
        this.s("Data add successfully");
        this.addModal = false;
        this.isAdding = false;
      } else if (res.status == "422") {
        if (res.data.errors.periodTime) {
          this.w(res.data.errors.periodTime[0]);
        }
      } else {
        this.swf();
      }
      this.isAdding = false;
    },

    // Edit Modal open
    edit_data(period, i) {
      let obj = {
        id: period.id,
        periodTime: period.periodTime,
      };
      this.editData = obj;
      this.index = i;
      this.editModal = true;
    },

    // Data Update
    async update_Data() {
      if (this.editData.periodTime.trim() == "")
        return this.i("Period Time is requried");
      const res = await this.callApi(
        "post",
        "/app/update-period",
        this.editData
      );
      if (res.status === 200) {
        this.s("Data Update Successfully");
        // for search data
        for (var i in this.searchPeriodTime) {
          if (this.searchPeriodTime[i].id == this.editData.id) {
            this.searchPeriodTime[
              i
            ].periodTime = this.editData.periodTime;
            break; //Stop this loop, we found it!
          }
        }
        // for pagination data
        for (var j in this.periodTimes) {
          if (this.periodTimes[j].id == this.editData.id) {
            this.periodTimes[j].periodTime = this.editData.periodTime;
            break; //Stop this loop, we found it!
          }
        }

        this.editModal = false;
      } else if (res.status === 422) {
        if (res.data.errors.periodTime) {
          this.w(res.data.errors.periodTime[0]);
        }
      } else {
        this.swf();
      }
    },

    // Send delete data Store
    async set_delete_data(period, i) {
      this.deleteIndex = i;
      this.deleteId = period.id;
      const deleteModalData = {
        deleteModal: true,
        url: "/app/delete-period",
        id: period.id,
        name: period.periodTime,
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

    // All Data Show with pagination
    async getData(page = 1) {
      const res = await this.callApi(
        "get",
        `/app/get-period?page=${page}&total=${this.total}`
      );
      if (res.status == 200) {
        this.periodTimes = res.data.data;
        this.pageInfo = res.data;
      } else this.e("All Data not show succefully");
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
    this.total = this.getTotal
    this.getData();
    const res = await this.callApi("get", "/app/get-all-period");
    this.searchPeriodTime = res.data;
  },
  computed: {
    ...mapGetters(["getdeleteModuleObj","getTotal"]),

    // Table Data
    filteredResources() {
      if (this.searchQuery) {
        return this.searchPeriodTime.filter((period) => {
          return this.searchQuery
            .toLowerCase()
            .split(" ")
            .every((v) => period.periodTime.toLowerCase().includes(v));
        });
      } else {
        return this.periodTimes;
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
        // if (this.searchQuery != "") {
          let k = 0;
          for (var i in this.searchPeriodTime) {
            if (this.searchPeriodTime[i].id == this.deleteId) {
              this.searchPeriodTime.splice(k, 1);
              
              break; //Stop this loop, we found it!
            }
            k++;
          }
          let m = 0;
              for (var j in this.periodTimes) {
                if (this.periodTimes[j].id == this.deleteId) {
                  this.periodTimes.splice(m, 1);
                  // this.searchQuery = ""
                  break;
                }
                m++;
              }
        // } else {
        //   this.items.splice(this.deleteIndex, 1);
        // }
      }
    },
  },
};
</script>