import Axios from "axios";

export default {
    data(){
        return {

        }
    },
    methods: {
        i(title = "Hey", desc) {
            this.$Notice.info({
                title: title,
                desc: desc
            });
        },
        s(title = "Great", desc) {
            this.$Notice.success({
                title: title,
                desc: desc
            });
        },
        w(title = "Oops", desc) {
            this.$Notice.warning({
                title: title,
                desc: desc
            });
        },
        e(title = "Hello", desc) {
            this.$Notice.error({
                title: title,
                desc: desc
            });
        },
        swf (desc="something want wrong with you", title="Hey") {
            this.$Notice.error({
                title: title,
                desc: desc
            });
            
        },
       
       

        async callApi(method, url, dataObj){
            try{
            return await axios({
                method: method,
                url: url,
                data: dataObj
            })
            }catch(e){
                return e.response
            }

        }
    }
}