<template>
  <div>
    <b-container fluid class="bv-example-row">
      <b-row>
        <b-col cols="6"
          ><Button type="primary" :value="addModal" @click="add_modal" autofocus
            >Add Role</Button
          ></b-col
        >
      </b-row>

      <!-- Data Table  -->
      <div class="table-wrappar">
        <table class="table table-bordered bg-white">
          <thead class="bg-info">
            <tr>
              <th scope="col">#</th>
              <th scope="col">Role Name</th>              
              <th scope="col">Action</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="(role, i) in roles" v-if="roles.length" :key="i">
              <th scope="row">{{ i }}</th>
              <td>{{ role.roleName }}</td>
              <td>
                <Button size="small" @click="edit_data(role, i)"
                  ><b-icon icon="pencil-square" variant="info"></b-icon
                ></Button>
                <Button size="small" @click="set_delete_data(role, i)"
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
        title="Add Role"
        :footer-hide="true"
        :closable="false"
      >
        <b-container fluid>
          <b-row class="my-1">
            <b-col sm="4">
              <label for="input-small">Role Name:</label>
            </b-col>
            <b-col sm="8">
              <b-form-input
                v-model="data.roleName"
                type="text"
                placeholder="Write Role Name...."
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
        title="Update Role"
        :footer-hide="true"
        :closable="false"
      >
        <b-container fluid>
          <b-row class="my-1">
            <b-col sm="4">
              <label for="input-small">Role Name:</label>
            </b-col>
            <b-col sm="8">
              <b-form-input
                v-model="editData.roleName"
                type="text"
                placeholder="Write Role Name...."
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
import deleteModal from "../common/delete.vue";
import { mapGetters } from "vuex";
export default {
  data() {
    return {
      addModal: false,
      editModal: false,
      data: {
        roleName: "",
      },
      editData: {
        roleName: "",
      },
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
      if (this.data.roleName.trim() == "")
        return this.i("Role name is required");
      this.isAdding = true;
      const res = await this.callApi("post", "/app/store-role", this.data);
      if (res.status === 201) {
        this.roles.unshift(res.data);
        this.data.roleName = "";
        this.s("Data add successfully");
        this.addModal = false;
        this.isAdding = false;
      } else if (res.status == "422") {
        if (res.data.errors.roleName) {
          this.w(res.data.errors.roleName[0]);
        }
      } else {
        this.swf();
      }
      this.isAdding = false;
    },

    // Edit Modal open
    edit_data(role, i) {
      let obj = {
        id: role.id,
        roleName: role.roleName,
      };
      this.editData = obj;
      this.index = i;
      this.editModal = true;
    },

    // Data Update
    async update_Data() {
      if (this.editData.roleName.trim() == "")
        return this.i("Role name is requried");
      const res = await this.callApi("post", "/app/update-role", this.editData);
      if (res.status === 200) {
        this.s("Data Update Successfully");
        this.roles[this.index].roleName = this.editData.roleName;
        this.editModal = false;
      } else if (res.status === 422) {
        if (res.data.errors.roleName) {
          this.w(res.data.errors.roleName[0]);
        }
      } else {
        this.swf();
      }
    },

    // Send delete data Store
    async set_delete_data(role, i) {
      this.deleteIndex = i;
      this.deleteId = role.id;
      const deleteModalData = {
        deleteModal: true,
        url: "/app/delete-role",
        id: role.id,
        name: role.roleName,       
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
    const res = await this.callApi("get", "/app/get-role");
    this.roles = res.data;
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
this.roles.splice(this.deleteIndex, 1);
      }
    },
  },
};
</script>