<template>
  <div>
    <Modal
      :value="getdeleteModuleObj.deleteModal"
      :closable="false"
      width="360"
      :mask-closable="false"
    >
      <p slot="header" style="color: #f60; text-align: center">
        <Icon type="ios-information-circle"></Icon>
        <span>Delete confirmation</span>
      </p>
      <div style="text-align: center">
        <p>
          Will you delete <b>{{ getdeleteModuleObj.name }}</b
          >?
        </p>

        <p v-if="getdeleteModuleObj.msg" class="war" >{{getdeleteModuleObj.msg}}</p>
      </div>
      <div slot="footer">
        <Button type="warning" size="small" @click="cancelModal">Cancel</Button>
        <Button
          type="error"
          size="small"
          :loading="isDeleteing"
          @click="delete_data"
          :disabled="isDeleteing"
          >{{ isDeleteing ? "Deleting..." : "Delete" }}</Button
        >
      </div>
    </Modal>
  </div>
</template>

<style scoped>
.war{
  color: rgb(220 24 24);
    font-size: 14px;
}
</style>

<script>
import { mapGetters } from "vuex";
export default {
  data() {
    return {
      isDeleteing: false,
    };
  },
  methods: {
    async delete_data() {
      this.isDeleteing = true;
      const res = await this.callApi(
        "post",
        this.getdeleteModuleObj.url,
        this.getdeleteModuleObj
      );
      if (res.status === 200) {
        this.s("Data Delete Succesfully");
        this.isDeleteing = false
        // let data = this.deleteModuleObj.deleteIndex
        this.$store.commit("setDeleteModal", true);
      }else if(res.status === 423){
        this.w(res.data.msg)
        this.isDeleteing = false
        this.$store.commit("setDeleteModal", false);
      } else {
        this.swf();
        this.isDeleteing = false
        this.$store.commit("setDeleteModal", false);
      }
    },
    cancelModal() {
      this.$store.commit("setDeleteModal", false);
    },
  },
  computed: {
    ...mapGetters(["getdeleteModuleObj"]),
  },
};
</script>