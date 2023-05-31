import { INIT_OREDER,SELECT_ORDER } from './mutations-types.js'
export default {
    state: {
        list: [],
        order_id : localStorage.getItem('tea_orderId') || '',
        uidlist:[]
    },
    mutations: {
        [INIT_OREDER](state, orderId) {
            state.list = orderId;
            //存储订单号
            state.order_id = orderId[0].order_id;

            //设置一个id号
            localStorage.setItem('tea_orderId', orderId[0].order_id);
        },
        [SELECT_ORDER](state,order){
            state.uidlist=order
           console.log(state.uidlist);
        }

    }
}