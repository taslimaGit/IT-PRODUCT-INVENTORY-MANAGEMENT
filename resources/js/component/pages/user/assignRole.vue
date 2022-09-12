<template>
  <div>
    <b-container fluid class="bv-example-row">
      <b-row class="my-1">
        <b-col sm="2">
          <label for="input-small">Role:</label>
        </b-col>
        <b-col sm="3">
          <Select v-model="data.role_id" filterable placeholder="Select Role">
            <Option v-for="(role, i) in roles" :value="role.id" :key="i">{{
              role.roleName
            }}</Option>
          </Select>
        </b-col>
      </b-row>
 <b-row class="my-1">
<table class="table table-sm">
  <thead>
    <tr>
      <th scope="col">#</th>
       <th scope="col">#</th>
      <th scope="col">Read</th>
      <th scope="col">Write</th>
      <th scope="col">Edit</th>
      <th scope="col">Delete</th>
    </tr>
  </thead>
  <tbody>
    <tr v-for="(res, i) in resources" :key="i" v-if="resources.length">
       
      <th scope="row">1</th>
      <td><Checkbox></Checkbox></td>
      <td><Checkbox></Checkbox></td>
      <td><Checkbox></Checkbox></td>
      <td><Checkbox></Checkbox></td>
       <td><Checkbox></Checkbox></td>
     
    </tr>
    
  </tbody>
</table>
</b-row>
    </b-container>
  </div>
</template>
<script>

export default {
  data() {
    return {
      data: {
        role_id: null,
      },
      roles: [],

      resources : [   
          {cat:'0',
          catsub :{resource: 'Dashoard', read:false, name:"home"}
          },
          
          {cat:'1',
          catName: "asset",
          catsub :[
              {resource: 'Department', read:false, write:true, edit:false, delete:true, name:"department"},
          {resource: 'Designation', read:false, write:true, edit:false, delete:true, name:"designation"},
          {resource: 'Item', read:false, write:true, edit:false, delete:true, name:"item"},
          {resource: 'Brand', read:false, write:true, edit:false, delete:true, name:"brand"},
          {resource: 'Attribute', read:false, write:true, edit:false, delete:true, name:"attribute"},
          ]
          },

          {cat:'1',
          catName: "Insert",
          catsub :[
             {resource: 'Client', read:false, write:true, edit:false, delete:true, name:"client"},
          {resource: 'Product', read:false, write:true, edit:false, delete:true, name:"product"},
          ]
          },
          
          {cat:'0',
          catsub :{resource: 'Assign Product', read:false, write:true, edit:false, delete:true, name:"assign"}
          },
          
          {cat:'1',
          catName: "User",
          catsub :[
            {resource: 'User', read:false, write:true, edit:false, delete:true, name:"user"},
          {resource: 'Role', read:false, write:true, edit:false, delete:true, name:"role"},
          {resource: 'Assign Role', read:false, write:true, edit:false, delete:true, name:"assignRole"},
          ]
          },
          
                    

      ]
    };
  },
  async created() {
    const res = await this.callApi("get", "/app/get-all-role-user");
    this.roles = res.data;
    console.log(this.resources)
  },
};
</script>