<template>
  <div>
    <b-container fluid class="bv-example-row">
      <b-row>
        <b-col cols="6"
          ><Button type="primary" :value="addModal" @click="add_modal" autofocus
            >Add Item</Button
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
              <th scope="col">Item Name</th>
              <th scope="col">Action</th>
            </tr>
          </thead>
          <tbody>
            <tr
              v-for="(item, i) in filteredResources"
              v-if="filteredResources.length"
              :key="i"
            >
              <th scope="row">{{ i }}</th>
              <td>{{ item.itemName }}</td>
              <td>
                <Button size="small" @click="edit_data(item, i)"
                  ><b-icon icon="pencil-square" variant="info"></b-icon
                ></Button>
                <Button size="small" @click="set_delete_data(item, i)"
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
        title="Add Item"
        :footer-hide="true"
        :closable="false"
      >
        <b-container fluid>
          <b-row class="my-1">
            <b-col sm="4">
              <label for="input-small">Item Name:</label>
            </b-col>
            <b-col sm="8">
              <b-form-input
                v-model="data.itemName"
                type="text"
                placeholder="Write Item Name...."
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
        title="Update Department"
        :footer-hide="true"
        :closable="false"
      >
        <b-container fluid>
          <b-row class="my-1">
            <b-col sm="4">
              <label for="input-small">Item Name:</label>
            </b-col>
            <b-col sm="8">
              <b-form-input
                v-model="editData.itemName"
                type="text"
                placeholder="Write Item Name...."
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
        itemName: "",
      },
      editData: {
        itemName: "",
      },
      items: [],
      searchItems: [],
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
      if (this.data.itemName.trim() == "")
        return this.i("Item name is required");
      this.isAdding = true;
      const res = await this.callApi(
        "post",
        "/app/store-item",
        this.data
      );
      if (res.status === 201) {
        this.items.unshift(res.data);
        this.searchItems.unshift(res.data);
        this.data.itemName = "";
        this.s("Data add successfully");
        this.addModal = false;
        this.isAdding = false;
      } else if (res.status == "422") {
        if (res.data.errors.itemName) {
          this.w(res.data.errors.itemName[0]);
        }
      } else {
        this.swf();
      }
      this.isAdding = false;
    },

    // Edit Modal open
    edit_data(item, i) {
      let obj = {
        id: item.id,
        itemName: item.itemName,
      };
      this.editData = obj;
      this.index = i;
      this.editModal = true;
    },

    // Data Update
    async update_Data() {
      if (this.editData.itemName.trim() == "")
        return this.i("Item name is requried");
      const res = await this.callApi(
        "post",
        "/app/update-item",
        this.editData
      );
      if (res.status === 200) {
        this.s("Data Update Successfully");
        // for search data
        for (var i in this.searchItems) {
          if (this.searchItems[i].id == this.editData.id) {
            this.searchItems[
              i
            ].itemName = this.editData.itemName;
            break; //Stop this loop, we found it!
          }
        }
        // for pagination data
        for (var j in this.items) {
          if (this.items[j].id == this.editData.id) {
            this.items[j].itemName = this.editData.itemName;
            break; //Stop this loop, we found it!
          }
        }

        this.editModal = false;
      } else if (res.status === 422) {
        if (res.data.errors.itemName) {
          this.w(res.data.errors.itemName[0]);
        }
      } else {
        this.swf();
      }
    },

    // Send delete data Store
    async set_delete_data(item, i) {
      this.deleteIndex = i;
      this.deleteId = item.id;
      const deleteModalData = {
        deleteModal: true,
        url: "/app/delete-item",
        id: item.id,
        name: item.itemName,
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
        `/app/get-item?page=${page}&total=${this.total}`
      );
      if (res.status == 200) {
        this.items = res.data.data;
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
    const res = await this.callApi("get", "/app/get-all-item");
    this.searchItems = res.data;
  },
  computed: {
    ...mapGetters(["getdeleteModuleObj","getTotal"]),

    // Table Data
    filteredResources() {
      if (this.searchQuery) {
        return this.searchItems.filter((item) => {
          return this.searchQuery
            .toLowerCase()
            .split(" ")
            .every((v) => item.itemName.toLowerCase().includes(v));
        });
      } else {
        return this.items;
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
          for (var i in this.searchItems) {
            if (this.searchItems[i].id == this.deleteId) {
              this.searchItems.splice(k, 1);
              
              break; //Stop this loop, we found it!
            }
            k++;
          }
          let m = 0;
              for (var j in this.items) {
                if (this.items[j].id == this.deleteId) {
                  this.items.splice(m, 1);
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