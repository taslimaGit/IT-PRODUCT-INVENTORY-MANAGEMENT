<template>
  <div>
    <b-container fluid class="bv-example-row">
      <b-row>
        <b-col cols="6"
          ><Button type="primary" :value="addModal" @click="add_modal" autofocus
            >Add User</Button
          ></b-col
        >
      </b-row>

      <!-- Data Table  -->
      <div class="table-wrappar">
        <table class="table table-bordered bg-white">
          <thead class="bg-info">
            <tr>
              <th scope="col">#</th>
              <th scope="col">Item Name</th>
              <th scope="col">Role</th>
              <th scope="col">Action</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="(user, i) in users" v-if="users.length" :key="i">
              <th scope="row">{{ i }}</th>
              <td>{{ user.fullName }}</td>
              <td>{{user.role.roleName}}</td>
              <td>
                <Button size="small" @click="edit_data(user, i)"
                  ><b-icon icon="pencil-square" variant="info"></b-icon
                ></Button>
                <Button size="small" @click="set_delete_data(user, i)"
                  ><b-icon icon="trash-fill" variant="warning"></b-icon
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
        title="Add User"
        :footer-hide="true"
        :closable="false"
      >
        <b-container fluid>
          <!-- Full Name  -->
          <b-row class="my-1">
            <b-col sm="4">
              <label for="input-small">Name:</label>
            </b-col>
            <b-col sm="8">
              <b-form-input
                v-model="data.fullName"
                type="text"
                placeholder="Write Name...."
                id="input-small"
                size="sm"
              ></b-form-input>
            </b-col>
          </b-row>

          <!-- user name  -->
          <b-row class="my-1">
            <b-col sm="4">
              <label for="input-small">User Name:</label>
            </b-col>
            <b-col sm="8">
              <b-form-input
                v-model="data.userName"
                type="text"
                placeholder=""
                id="input-small"
                size="sm"
              ></b-form-input>
            </b-col>
          </b-row>

          <!-- password  -->
          <b-row class="my-1">
            <b-col sm="4">
              <label for="input-small">Password:</label>
            </b-col>
            <b-col sm="8">
              <b-form-input
                v-model="data.password"
                type="password"
                placeholder="password"
                id="input-small"
                size="sm"
              ></b-form-input>
            </b-col>
          </b-row>

          <!-- role select  -->
          <b-row class="my-1">
            <b-col sm="4">
              <label for="input-small">Role:</label>
            </b-col>
            <b-col sm="8">
              <Select
                v-model="data.role_id"
                filterable
                placeholder="Select Role"
              >
                <Option v-for="(role, i) in roles" :value="role.id" :key="i">{{
                  role.roleName
                }}</Option>
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
        title="Update Department"
        :footer-hide="true"
        :closable="false"
      >
        <b-container fluid>
          <!-- Full Name  -->
          <b-row class="my-1">
            <b-col sm="4">
              <label for="input-small">Name:</label>
            </b-col>
            <b-col sm="8">
              <b-form-input
                v-model="editData.fullName"
                type="text"
                placeholder="Write Name...."
                id="input-small"
                size="sm"
              ></b-form-input>
            </b-col>
          </b-row>

          <!-- role select  -->
          <b-row class="my-1">
            <b-col sm="4">
              <label for="input-small">Role:</label>
            </b-col>
            <b-col sm="8">
              <Select
                v-model="editData.role_id"
                filterable
                placeholder="Select Role"
                @on-change="update_role()"
              >
                <Option v-for="(role, i) in roles" :value="role.id" :key="i">{{
                  role.roleName
                }}</Option>
              </Select>
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
import deleteModal from "../common/delete.vue";
import { mapGetters } from "vuex";
export default {
  data() {
    return {
      searchQuery: "",
      addModal: false,
      editModal: false,
      data: {
        fullName: "",
        userName: "",
        password: "",
        role_id: null,
      },
      editData: {
        fullName: "",
        role_id: null,
      },
      updateData:{},
      users: [],
      roles: [],
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
      if (this.data.fullName.trim() == "") return this.i("Name is required");
      if (this.data.userName.trim() == "") return this.i("User Name Empty");
      if (this.data.password.trim() == "") return this.i("Password Empty");
      if (!this.data.role_id) return this.i("Please Select Role");
      this.isAdding = true;
      const res = await this.callApi("post", "/app/store-user", this.data);
      if (res.status === 201) {
        this.users.unshift(res.data);
        this.data.fullName = "";
        this.data.userName = "";
        this.data.password = "";
        this.data.role_id = null;
        this.s("User add successfully");
        this.addModal = false;
        this.isAdding = false;
      } else if (res.status == "422") {
        if (res.data.errors.userName) {
          this.w(res.data.errors.userName[0]);
        }
      } else {
        this.swf();
      }
      this.isAdding = false;
    },

    // Edit Modal open
    edit_data(user, i) {
      let obj = {
        id: user.id,
        fullName: user.fullName,
        role_id: user.role_id,
      };
      this.editData = obj;
      this.index = i;
      this.editModal = true;
    },

    update_role(){
 let roleId = this.editData.role_id;
      this.roles.find((file) => {
        if (file.id === roleId) {
          this.updateData.roleName = file.roleName;
        }
      });
    },

    // Data Update
    async update_Data() {
      if (this.editData.fullName.trim() == "") return this.i("Name is required");
      if (!this.editData.role_id) return this.i("Please Select Role");
      const res = await this.callApi("post", "/app/update-user", this.editData);
      if (res.status === 200) {
        this.s("Data Update Successfully");
        this.users[this.index].fullName = this.editData.fullName;
        this.users[this.index].role_id = this.editData.role_id;
        if(this.updateData.roleName){ this.users[this.index].role.roleName = this.updateData.roleName}       
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
    async set_delete_data(user, i) {
      this.deleteIndex = i;
      this.deleteId = user.id;
      const deleteModalData = {
        deleteModal: true,
        url: "/app/delete-user",
        id: user.id,
        name: user.fullName,
        // deleteIndex: i,
        isDelete: false,
      };
      this.$store.commit("setDeleteModalData", deleteModalData);
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
    const res = await this.callApi("get", "/app/get-user");
    this.users = res.data;

    const role = await this.callApi("get", "/app/get-all-role-user");
    this.roles = role.data;
  },
  computed: {
    ...mapGetters(["getdeleteModuleObj"]),
  },
  components: {
    deleteModal,
  },
  watch: {
    // For Delete watch
    getdeleteModuleObj(obj) {
      if (obj.isDelete) {
this.users.splice(this.deleteIndex, 1);
      }
    },
  },
};
</script>