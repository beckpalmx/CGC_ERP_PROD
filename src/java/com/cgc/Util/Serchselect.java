package com.cgc.Util;

//
public class Serchselect {

    private String strTable;
    private String[] strColoum, strColoumShow, strFillName;
    private String strID;
    private SelectSerchData ssd;  // กำหนดชื่อ Table ให้กับตัว Search เฉพาะ Table ที่ใช้ชื่อแทน

    public String SelectTable(String inputdatabase) //function �зӡ�� return ��Ңͧ Table ����ͧ������Ң�����˹��Brown(�Ը��˪�͹ ../JSP/Search_Config.jsp?page=1&table=?)
    {
        ssd = new SelectSerchData();
        strTable = ssd.SelectSerchTable(inputdatabase);
        return strTable;
    }

    public String[] SelectColoum(int inputpage, String inputdatabase) //function จะ Return ค่าของข้อมูลที่จะนำออกไปแสดงข้อมูล
    {
        switch (inputpage) {
            case 289:
                if (inputdatabase.equals("vm_friction_house")) {
                    strColoum = new String[]{"friction_house"};
                } else {
                    strColoum = new String[]{"location_id", "name_t"};
                }
                break;
            case 290:
                strColoum = new String[]{"location_id", "name_t"};
                break;
            case 291:
                strColoum = new String[]{"location_id", "name_t"};
                break;
            case 292:
                strColoum = new String[]{"location_id", "name_t"};
                break;
            case 293:
                strColoum = new String[]{"ticket_text", "date_in", "truck_no", "load_in", "load_out"};
                break;
            case 109:
                strColoum = new String[]{"doc_id", "cust_name"};
                break;
            case 204:
                switch (inputdatabase) {
                    case "mjob_type":
                        strColoum = new String[]{"job_type_id", "name_t", "remark"};
                        break;
                    case "mjob_type_detail":
                        strColoum = new String[]{"job_type_id", "job_type_desc", "remark"};
                        break;
                    default:
                        strColoum = new String[]{"export_id", "name_t", "lookup_name", "param_name", "param_value", "param_from", "param_value_from", "order_by", "complete_flag", "retro_flag", "cancel_flag", "remark"};
                        break;
                }
                break;
            case 205:
                strColoum = new String[]{"iod_code", "iod_range", "iod_ctype", "name_t", "butane", "ctc", "remark"};
                break;
            case 206:
                if (inputdatabase.equals("mjob_type")) {
                    strColoum = new String[]{"job_type_id", "name_t"};
                }
                break;
            case 53:
                if (inputdatabase.equals("mdata_export")) {
                    strColoum = new String[]{"export_id", "name_t", "lookup_name", "complete_flag", "retro_flag", "cancel_flag"};
                } else if (inputdatabase.indexOf("d_") != -1) {
                    strColoum = new String[]{"runno", "doc_id"};
                }
                break;
            case 116:
                strColoum = new String[]{"product_id", "name_t", "pgroup_name", "pcat_name"};
                break;
            case 30:
                if (inputdatabase.equals("m_carbon_size")) {
                    strColoum = new String[]{"name_t"};
                }
                break;
            case 301:
                if (inputdatabase.equals("mwarehouse")) {
                    strColoum = new String[]{"warehouse_id", "name_t"};
                } else {
                    strColoum = new String[]{"product_id", "name_t"};
                }
                break;

            case 302:
                if (inputdatabase.equals("Vproduct")) {
                    strColoum = new String[]{"product_id", "name_t", "iodine"};
                }
                break;

            case 207:
                strColoum = new String[]{"runno", "location_id", "name_t", "price_per_unit", "location_id_ref", "remark"};
                break;
            case 203:
                strColoum = new String[]{"shift_id", "name_t", "remark"};
                break;
            case 202:
                strColoum = new String[]{"m_size_id", "name_t", "remark"};
                break;
            case 201:
                strColoum = new String[]{"prd_place", "name_t", "job_type_id", "job_name_t", "remark"};
                break;
            case 200:
                strColoum = new String[]{"machine_id", "name_t", "remark"};
                break;
            case 13:
                strColoum = new String[]{"dept_id", "name_t", "remark"};
                break;
            case 14:
                if (inputdatabase.equals("vemployee_fullname")) {
                    strColoum = new String[]{"emp_id", "fname", "lname", "dept_id", "depart_name", "status", "remark"};
                } else {
                    strColoum = new String[]{"dept_id", "name_t"};
                }
                break;

            case 147:
                if (inputdatabase.equals("vemployee_fullname")) {
                    strColoum = new String[]{"emp_id", "fname", "lname"};
                }
                break;

            case 15:
                switch (inputdatabase) {
                    case "mcountry":
                        strColoum = new String[]{"country_code", "name_t"};
                        break;
                    case "mtambol":
                        strColoum = new String[]{"tambol_code", "name_t"};
                        break;
                    case "mamphor":
                        strColoum = new String[]{"amp_code", "name_t"};
                        break;
                    case "mprovince":
                        strColoum = new String[]{"prov_code", "name_t"};
                        break;
                    default:
                        strColoum = new String[]{"customer_id", "name_t", "address1_t", "tambol_code", "t_name", "amp_code", "amp_namt", "prov_code", "prov_tname", "country_code", "country_name", "zipcode", "tel", "fax", "contact_name", "remark"};
                        break;
                }
                break;
            case 16:
                switch (inputdatabase) {
                    case "mcountry":
                        strColoum = new String[]{"country_code", "name_t"};
                        break;
                    case "mtambol":
                        strColoum = new String[]{"tambol_code", "name_t"};
                        break;
                    case "mamphor":
                        strColoum = new String[]{"amp_code", "name_t"};
                        break;
                    case "mprovince":
                        strColoum = new String[]{"prov_code", "name_t"};
                        break;
                    case "mbranch":
                        strColoum = new String[]{"branch_id", "name_t"};
                        break;
                    case "mcredit":
                        strColoum = new String[]{"cred_code", "cred_name"};
                        break;
                    default:
                        strColoum = new String[]{"supplier_id", "name_t", "address1_t", "tambol_code", "t_name", "amp_code", "amp_namt", "prov_code", "prov_tname", "zipcode", "tel", "fax", "contact_name", "remark", "price_unit"};
                        break;
                }
                break;
            case 17:
                strColoum = new String[]{"pgroup_id", "name_t", "remark"};
                break;
            case 18:
                strColoum = new String[]{"pcat_id", "name_t", "remark"};
                break;
            case 19:
                strColoum = new String[]{"ptype_id", "name_t", "remark"};
                break;
            case 20:
                strColoum = new String[]{"warehouse_id", "name_t", "remark", "wh_type"};
                break;
            case 21:
                switch (inputdatabase) {
                    case "vproduct":
                        strColoum = new String[]{"product_id", "name_t", "pgroup_id", "pgroup_name", "pcat_id", "pcat_name", "ptype_id", "ptype_name", "price", "min", "max", "safety", "weight", "location_id", "value", "remark", "size_id", "size_name", "butane", "ctc", "iodine", "unit_id", "unit_name", "lot_no", "last_movement"};
                        break;
                    case "vmproduct":
                        strColoum = new String[]{"product_id", "name_t", "iodine"};
                        break;
                    case "mproduct_group":
                        strColoum = new String[]{"pgroup_id", "name_t"};
                        break;
                    case "mproduct_cat":
                        strColoum = new String[]{"pcat_id", "name_t"};
                        break;
                    case "mproduct_type":
                        strColoum = new String[]{"ptype_id", "name_t"};
                        break;
                    case "munit_code":
                        strColoum = new String[]{"unit_id", "name_t"};
                        break;
                    default:
                        strColoum = new String[]{"size_id", "name_t"};
                        break;
                }
                break;
            case 114:
                strColoum = new String[]{"doc_id", "doc_date"};
                break;
            case 103:
                if (inputdatabase.equals("mdepartment")) {
                    strColoum = new String[]{"dept_id", "name_t"};
                } else {
                    strColoum = new String[]{"emp_id", "fullname"};
                }
                break;
            case 105:
                strColoum = new String[]{"emp_id", "fullname"};
                break;
            case 106:
                if (inputdatabase.equals("Vd_job_order_header")) {
                    strColoum = new String[]{"doc_id", "cust_id", "cust_name", "spec_size", "spec_i2"};
                }
                break;
            case 108:
                switch (inputdatabase) {
                    case "Vd_job_order_header":
                        strColoum = new String[]{"doc_id", "cust_name"};
                        break;
                    case "Mproduct_cat":
                        strColoum = new String[]{"pcat_id", "name_t"};
                        break;
                    case "m_carbon_size":
                        strColoum = new String[]{"name_t"};
                        break;
                }
                break;
            case 112:
                switch (inputdatabase) {
                    case "Vd_job_order_header":
                        strColoum = new String[]{"doc_id", "cust_id", "cust_name"};
                        break;
                    case "Vproduct":
                        strColoum = new String[]{"product_id", "name_t"};
                        break;
                }
                break;
            case 51:
                if (inputdatabase.equals("vd_product_receive_header_wh")) {
                    strColoum = new String[]{"doc_id", "doc_date", "inc_bal", "remark", "job_id", "cust_name"};
                }
                break;
            case 31:
                strColoum = new String[]{"product_id", "name_t"};
                break;
            case 50:
                if (inputdatabase.equals("d_carbon_withdraw_header_wh")) {
                    strColoum = new String[]{"doc_id", "doc_date"};
                }
                break;
            case 22:
                switch (inputdatabase) {
                    case "Vsupplier":
                        strColoum = new String[]{"supplier_id", "name_t", "tel", "cust_addr", "price_unit"};
                        break;
                    case "Vproduct":
                        strColoum = new String[]{"product_id", "name_t"};
                        break;
                    case "Vd_rawmatt_receive":
                        strColoum = new String[]{"doc_id", "doc_date", "wh_in", "wh_in_name", "supplier_id", "supplier_name", "supplier_tel", "supplier_addr", "position_no", "scale_no", "car_no", "driver_name", "type_prod", "product_id", "total_weight", "bag_weight", "ashes_percent", "ashes_weight", "dust_percent", "dust_weight", "volatile_percent", "volatile_weight", "moise_percent", "moise_weight", "contamination_percent", "contamination_weight", "net_weight", "remark", "car_date_in", "bag_total", "ashes_percent_ch", "ashes_weight_ch", "dust_percent_ch", "dust_weight_ch", "volatile_percent_ch", "volatile_weight_ch", "moise_percent_ch", "moise_weight_ch", "contamination_percent_ch", "contamination_weight_ch", "net_weight_ch", "car_cbag_weight", "car_weight", "bag_net", "carbon_net", "location_id2", "price_unit", "lab_not_check"};
                        break;
                    case "Vd_fuel_receive":
                        strColoum = new String[]{"doc_id", "doc_date", "wh_in", "wh_name",
                            "supplier_id", "supplier_name", "supplier_tel", "supplier_addr",
                            "position_no", "scale_no",
                            "car_date_in", "car_time_in", "car_date_out", "car_time_out",
                            "car_no", "driver_name", "product_id",
                            "car_weight_in",
                            "car_weight_out", "total_weight", "reporter_id", "reporter_name", "checker1",
                            "checker1_name", "price_unit", "total_price", "remark", "moisture", "moisture_std",
                            "deduct_weight_moisture", "net_weight_receive", "net_weight_payment", "status"};
                        break;
                    case "vmrawmat":
                        strColoum = new String[]{"product_id", "name_t"};
                        break;
                    case "vm_burn_no":
                    case "vm_burn_no2":
                    case "vm_burn_no3":
                    case "vm_burn_no4":
                    case "vm_burn_no5":
                    case "vm_burn_no6":
                    case "vm_burn_no7":
                    case "vm_burn_no8":
                    case "vm_burn_no9":
                    case "vm_burn_no10":
                        strColoum = new String[]{"warehouse_id"};
                        break;
                    default:
                        strColoum = new String[]{"warehouse_id", "name_t"};
                        break;
                }
                break;
            case 221:
                switch (inputdatabase) {
                    case "Vsupplier":
                        strColoum = new String[]{"supplier_id", "name_t", "tel", "cust_addr"};
                        break;
                    case "vd_ticketbuy_fuel":
                        strColoum = new String[]{"ticket_text", "doc_date", "truck_no", "prod_code", "load_in", "load_out", "net_wght", "date_in", "date_out", "time_in", "time_out", "net_weight_receive"};
                        break;
                }
                break;
            case 222:
                switch (inputdatabase) {
                    case "vmbank":
                        strColoum = new String[]{"bank_id", "name_t"};
                        break;
                    case "vd_carbon_friction_burn_detail":
                        //System.out.println("inputdatabase = " + inputdatabase);
                        strColoum = new String[]{"doc_id", "doc_date", "product_id", "weight_carbon_in", "weight_carbon_friction",
                            "weight_carbon_dust", "weight_carbon_iron", "weight_carbon_total", "weight_carbon_bigbag",
                            "weight_carbon_burn_in", "weight_carbon_real_lost", "percent_carbon_real_lost",
                            "weight_carbon_lost", "percent_carbon_lost", "burn_no", "channel", "wh_id", "location_id",
                            "remark", "percent_moisture", "rawmat_emp_id", "product_emp_id", "complete_flag", "wh_name",
                            "rawmat_emp_name", "product_emp_name", "prod_name",
                            "weight_carbon_burn_in_2", "burn_no_2", "channel_2", "weight_carbon_burn_in_3", "burn_no_3", "channel_3",
                            "weight_carbon_burn_in_4", "burn_no_4", "channel_4", "weight_carbon_burn_in_5", "burn_no_5",
                            "channel_5", "weight_carbon_burn_in_total",
                            "burn_date_1", "burn_date_2", "burn_date_3", "burn_date_4", "burn_date_5",
                            "burn_date_6", "burn_date_7", "burn_date_8", "burn_date_9", "burn_date_10",
                            "weight_carbon_burn_in_6", "burn_no_6", "channel_6", "weight_carbon_burn_in_7", "burn_no_7", "channel_7",
                            "weight_carbon_burn_in_8", "burn_no_8", "channel_8", "weight_carbon_burn_in_9", "burn_no_9", "channel_9",
                            "weight_carbon_burn_in_10", "burn_no_10", "channel_10"};
                        //System.out.println("strColoum = " + strColoum);
                        break;
                    default:
                        strColoum = new String[]{"doc_id", "doc_date", "wh_in", "wh_in_name", "supplier_id", "supplier_name", "supplier_tel", "supplier_addr", "position_no", "scale_no", "car_no", "driver_name", "type_prod", "product_id", "total_weight", "bag_weight", "ashes_percent", "ashes_weight", "dust_percent", "dust_weight", "volatile_percent", "volatile_weight", "moise_percent", "moise_weight", "contamination_percent", "contamination_weight", "net_weight", "remark", "total_price", "car_date_in", "bag_total", "ashes_percent_ch", "ashes_weight_ch", "dust_percent_ch", "dust_weight_ch", "volatile_percent_ch", "volatile_weight_ch", "moise_percent_ch", "moise_weight_ch", "contamination_percent_ch", "contamination_weight_ch", "net_weight_ch", "car_cbag_weight", "car_weight", "bag_net", "carbon_net", "price_flag", "location_id2", "price_unit", "payment_no", "payment_method", "bank_id", "bank_name", "cheque_no", "text_price", "total_price", "bank_acc_no", "net_weight_payment", "lab_not_check"};
                        break;
                }
                break;

            case 223:
                strColoum = new String[]{"doc_id", "doc_date", "wh_in", "wh_in_name", "supplier_id", "supplier_name", "supplier_tel", "supplier_addr", "position_no", "scale_no", "car_no", "driver_name", "type_prod", "product_id", "total_weight", "bag_weight", "ashes_percent", "ashes_weight", "dust_percent", "dust_weight", "volatile_percent", "volatile_weight", "moise_percent", "moise_weight", "contamination_percent", "contamination_weight", "net_weight", "remark", "car_date_in", "bag_total", "ashes_percent_ch", "ashes_weight_ch", "dust_percent_ch", "dust_weight_ch", "volatile_percent_ch", "volatile_weight_ch", "moise_percent_ch", "moise_weight_ch", "contamination_percent_ch", "contamination_weight_ch", "net_weight_ch", "car_cbag_weight", "car_weight", "bag_net", "carbon_net", "location_id2", "price_unit", "ashes_percent_acc", "ashes_weight_acc", "dust_percent_acc", "dust_weight_acc", "volatile_percent_acc", "volatile_weight_acc", "moise_percent_acc", "moise_weight_acc", "contamination_percent_acc", "contamination_weight_acc", "net_weight_acc"};
                break;
            case 224:
                //strColoum = new String[]{"doc_id", "doc_date", "wh_in", "wh_in_name", "supplier_id", "supplier_name", "supplier_tel", "supplier_addr", "position_no", "scale_no", "car_no", "driver_name", "type_prod", "product_id", "total_weight", "bag_weight", "ashes_percent", "ashes_weight", "dust_percent", "dust_weight", "volatile_percent", "volatile_weight", "moise_percent", "moise_weight", "contamination_percent", "contamination_weight", "net_weight", "remark", "total_price", "car_date_in", "bag_total", "ashes_percent_ch", "ashes_weight_ch", "dust_percent_ch", "dust_weight_ch", "volatile_percent_ch", "volatile_weight_ch", "moise_percent_ch", "moise_weight_ch", "contamination_percent_ch", "contamination_weight_ch", "net_weight_ch", "car_cbag_weight", "car_weight", "bag_net", "carbon_net", "price_flag", "location_id2", "price_unit", "payment_no", "payment_method", "bank_id", "bank_name", "cheque_no", "text_price", "total_price", "bank_acc_no", "net_weight_payment", "net_weight_acc"};
                strColoum = new String[]{"doc_id", "doc_date", "wh_in", "wh_in_name", "supplier_id", "supplier_name", "supplier_tel", "supplier_addr", "position_no", "scale_no", "car_no", "driver_name", "type_prod", "product_id", "total_weight", "bag_weight", "ashes_percent", "ashes_weight", "dust_percent", "dust_weight", "volatile_percent", "volatile_weight", "moise_percent", "moise_weight", "contamination_percent", "contamination_weight", "net_weight", "total_price", "car_date_in", "bag_total", "ashes_percent_ch", "ashes_weight_ch", "dust_percent_ch", "dust_weight_ch", "volatile_percent_ch", "volatile_weight_ch", "moise_percent_ch", "moise_weight_ch", "contamination_percent_ch", "contamination_weight_ch", "net_weight_ch", "car_cbag_weight", "car_weight", "bag_net", "carbon_net", "price_flag", "location_id2", "price_unit", "payment_no", "payment_method", "bank_id", "bank_name", "cheque_no", "text_price", "total_price", "bank_acc_no", "net_weight_payment", "net_weight_acc"};
                break;

            case 59:
                strColoum = new String[]{"pgroup_id", "iodine", "price_month_1", "price_month_2", "price_month_3", "price_month_4", "price_month_5", "price_month_6", "price_month_7", "price_month_8", "price_month_9", "price_month_10", "price_month_11", "price_month_12", "product_id", "lot_no", "runno", "remark", "prod_name"};
                break;

            case 62:
                strColoum = new String[]{"pgroup_id", "iodine", "price_month_1", "price_month_2", "price_month_3", "price_month_4", "price_month_5", "price_month_6", "price_month_7", "price_month_8", "price_month_9", "price_month_10", "price_month_11", "price_month_12", "product_id", "lot_no", "runno", "remark", "prod_name"};
                break;

            case 591:
                strColoum = new String[]{"product_id", "name_t", "pgroup_id", "lot_no", "iodine"};
                break;

            case 60:
                strColoum = new String[]{"doc_id", "cust_name", "size_name", "psd_1", "psd_2", "psd_3", "psd_4", "psd_5", "psd_6", "psd_7", "psd_8", "psd_9", "psd_10", "psd_11", "psd_12", "psd_13", "psd_14", "psd_15", "h2o", "butane", "iod", "pass", "n_pass", "grade", "remark"};
                break;
            case 600:
                strColoum = new String[]{"doc_id"};
                break;

            case 61:
                if (inputdatabase.equals("vd_header_analyze")) {
                    strColoum = new String[]{"doc_id", "psd_1", "psd_2", "psd_3", "psd_4", "psd_5", "psd_6", "psd_7", "psd_8", "psd_9", "psd_10", "psd_11", "psd_12", "psd_13", "psd_14", "psd_15", "h2o", "butane", "iod", "pass", "n_pass", "grade", "remark"};
                } else {
                    strColoum = new String[]{"doc_id"};
                }
                break;

            case 23:
                switch (inputdatabase) {
                    case "Vemployee":
                    case "Vemployee1":
                        strColoum = new String[]{"emp_id", "fullname"};
                        break;
                    case "Mproduct_type":
                        strColoum = new String[]{"ptype_id", "name_t"};
                        break;
                    default:
                        strColoum = new String[]{"warehouse_id", "name_t"};
                        break;
                }
                break;
            case 24:
                switch (inputdatabase) {
                    case "msupplier":
                        strColoum = new String[]{"supplier_id", "name_t"};
                        break;
                    case "mdepartment":
                        strColoum = new String[]{"dept_id", "name_t"};
                        break;
                    case "v_rawmatt_receive_supplier":
                        strColoum = new String[]{"supplier_id", "supplier_name"};
                        break;
                }
                break;
            case 25:
                if (inputdatabase.equals("Warehouse") || inputdatabase.equals("Warehouse1") || inputdatabase.equals("Warehouse2")) {
                    strColoum = new String[]{"warehouse_id", "name_t"};
                } else {
                    strColoum = new String[]{"emp_id", "fullname"};
                }
                break;
            case 26:
                if (inputdatabase.equals("Warehouse")) {
                    strColoum = new String[]{"warehouse_id", "name_t"};
                }
                break;
            case 27:
                if (inputdatabase.equals("m_iodine")) {
                    strColoum = new String[]{"butane", "iod_range"};
                } else {
                    strColoum = new String[]{"emp_id", "fullname"};
                }
                break;
            case 28:
                switch (inputdatabase) {
                    case "Warehouse":
                        strColoum = new String[]{"warehouse_id", "name_t"};
                        break;
                    case "mproduct":
                        strColoum = new String[]{"product_id", "name_t"};
                        break;
                }
                break;
            case 29:
                if (inputdatabase.equals("Vemployee") || inputdatabase.equals("Vemployee1")) {
                    strColoum = new String[]{"emp_id", "fullname"};
                } else {
                    strColoum = new String[]{"product_id", "name_t"};
                }
                break;
            case 57:
                strColoum = new String[]{"product_id", "name_t"};
                break;
            case 32:
                if (inputdatabase.equals("Vcustomer")) {
                    strColoum = new String[]{"customer_id", "name_t", "country_code", "country_name"};
                } else if (inputdatabase.equals("Vemployee") || inputdatabase.equals("Vemployee1") || inputdatabase.equals("Vemployee2") || inputdatabase.equals("Vemployee3")) {
                    strColoum = new String[]{"emp_id", "fullname"};
                } else if (inputdatabase.equals("vd_saleorderproduct_master")) {
                    strColoum = new String[]{"doc_id", "cust_id", "customer_name", "country_code", "country_name"};
                } else if (inputdatabase.equals("vd_saleorderproduct_detail")) {
                    //strColoum = new String[]{"doc_id", "cust_id", "customer_name", "country_code", "country_name", "product_id", "quantity", "size_name", "butane", "ctc", "iodine"};
                    strColoum = new String[]{"doc_id"};
                } else if (inputdatabase.equalsIgnoreCase("m_carbon_size")) {
                    strColoum = new String[]{"name_t", "remark"};
                } else if (inputdatabase.equalsIgnoreCase("vm_carbon_size")) {
                    strColoum = new String[]{"name_t", "name_t"};
                } else if (inputdatabase.equalsIgnoreCase("mmachine")) {
                    strColoum = new String[]{"machine_id", "name_t"};
                } else {
                    strColoum = new String[]{"country_code", "name_t"};
                }
                break;
            case 34:
                if (inputdatabase.equals("Vemployee") || inputdatabase.equals("Vemployee1") || inputdatabase.equals("Vemployee2")) {
                    strColoum = new String[]{"emp_id", "fullname"};
                } else {
                    strColoum = new String[]{"job_type_id", "name_t"};
                }
                break;
            case 35:
                switch (inputdatabase) {
                    case "Mproduct_cat":
                        strColoum = new String[]{"pcat_id", "name_t"};
                        break;
                    case "Vd_job_order_header":
                        strColoum = new String[]{"doc_id", "cust_name"};
                        break;
                    case "m_carbon_size":
                        strColoum = new String[]{"name_t"};
                        break;
                    case "mproduct":
                        strColoum = new String[]{"product_id", "name_t"};
                        break;
                    default:
                        strColoum = new String[]{"name_t"};
                        break;
                }
                break;
            case 36:
                switch (inputdatabase) {
                    case "Vproduct":
                        strColoum = new String[]{"product_id", "name_t"};
                        break;
                    case "Vd_job_order_header":
                        strColoum = new String[]{"doc_id", "cust_name", "spec_size", "i2"};
                        break;
                }
                break;

            case 361:
                strColoum = new String[]{"doc_id", "cust_name"};
                break;
            case 37:
                switch (inputdatabase) {
                    case "Mwarehouse":
                        strColoum = new String[]{"warehouse_id", "name_t"};
                        break;
                    case "munit_code":
                        strColoum = new String[]{"unit_id", "name_t"};
                        break;
                }
                break;
            case 38:
                if (inputdatabase.equals("Vd_job_order_header")) {
                    strColoum = new String[]{"doc_id", "cust_name"};
                }
                break;
            case 39:
                if (inputdatabase.equals("Vproduct")) {
                    strColoum = new String[]{"product_id", "name_t"};
                }
                break;
            case 40:
                switch (inputdatabase) {
                    case "Vd_job_order_header":
                        strColoum = new String[]{"doc_id", "cust_name"};
                        break;
                    case "Vemployee":
                    case "Vemployee1":
                        strColoum = new String[]{"emp_id", "fullname"};
                        break;
                }
                break;
            case 41:
                if (inputdatabase.equals("mproduction_place")) {
                    strColoum = new String[]{"prd_place", "name_t"};
                } else if (inputdatabase.equals("Mwarehouse")) {
                    strColoum = new String[]{"warehouse_id", "name_t"};
                } else if (inputdatabase.equals("M_doc_type")) {
                    strColoum = new String[]{"doc_type", "name_t"};
                } else {
                    strColoum = new String[]{"size_id", "name_t"};
                }
                break;
            case 42:
                switch (inputdatabase) {
                    case "Vd_job_order_header":
                        strColoum = new String[]{"doc_id", "cust_id", "cust_name", "cust_addr", "country_name", "po_no"};
                        break;
                    case "Vemployee":
                    case "Vemployee1":
                    case "Vemployee2":
                        strColoum = new String[]{"emp_id", "fullname"};
                        break;
                }
                break;
            case 43:
                if (inputdatabase.equals("Vproduct")) {
                    strColoum = new String[]{"product_id", "name_t"};
                } else {
                    strColoum = new String[]{"doc_id", "cust_name"};
                }
                break;
            case 44:
                switch (inputdatabase) {
                    case "m_carbon_size":
                        strColoum = new String[]{"size_id", "name_t"};
                        break;
                    case "Mwarehouse":
                        strColoum = new String[]{"warehouse_id", "name_t"};
                        break;
                }
                break;
            case 45:
                if (inputdatabase.equals("Vemployee")) {
                    strColoum = new String[]{"emp_id", "fullname"};
                } else {
                    strColoum = new String[]{"unit_id", "name_t"};
                }
                break;
            case 46:
                if (inputdatabase.equals("Vd_rawmatt_receive")) {
                    strColoum = new String[]{"doc_id", "car_no", "product_id", "supplier_id", "supplier_name", "car_date_in"};
                } else if (inputdatabase.equals("Vemployee") || inputdatabase.equals("Vemployee1") || inputdatabase.equals("Vemployee2")) {
                    strColoum = new String[]{"emp_id", "fullname"};
                }
                break;
            case 48: // Calculate
                switch (inputdatabase) {
                    case "vmprocess":
                        strColoum = new String[]{"process_id", "name_t", "main_table", "sub_table1", "sub_table2"};
                        break;
                    case "mwarehouse":
                        strColoum = new String[]{"warehouse_id", "name_t"};
                        break;
                    default:
                        strColoum = new String[]{"doc_id", "doc_date"};
                        break;
                }
                break;
            case 482: // Calculate
                switch (inputdatabase) {
                    case "vmprocess":
                        strColoum = new String[]{"process_id", "name_t", "main_table", "sub_table1", "sub_table2", "sub_table3"};
                        break;
                    case "mwarehouse":
                        strColoum = new String[]{"warehouse_id", "name_t"};
                        break;
                    default:
                        strColoum = new String[]{"doc_id", "doc_date"};
                        break;
                }
                break;
            case 49: // Calculate
                if (inputdatabase.equals("vd_carbon_burn_out_header_wh")) {
                    strColoum = new String[]{"doc_id", "doc_date"};
                }
                break;
            case 101: // Report
                if (inputdatabase.equals("Vd_rawmatt_receive")) {
                    strColoum = new String[]{"doc_id"};
                }
                break;
            case 100: // Report
                if (inputdatabase.equals("Vd_rawmatt_receive")) {
                    strColoum = new String[]{"doc_id"};
                }
                break;

            case 312:
                if (inputdatabase.equals("vmessage")) {
                    strColoum = new String[]{"message_id", "message_detail", "status"};
                } else {
                    strColoum = new String[]{"doc_id", "year_text", "product_id", "supplier_id", "rate_text", "quality_id", "assessor_id", "approve_id", "assessor_fullname", "approve_fullname", "supplier_name"};
                }
                break;
            case 313://d_carbon_out_analysis
                if (inputdatabase.equals("Vemployee") || inputdatabase.equals("Vemployee1") || inputdatabase.equals("Vemployee2") || inputdatabase.equals("Vemployee3") || inputdatabase.equals("Vemployee4")) {
                    strColoum = new String[]{"emp_id", "fullname"};
                }
                break;
            case 314://d_carbon_send_product
                if (inputdatabase.equals("Vemployee") || inputdatabase.equals("Vemployee1") || inputdatabase.equals("Vemployee2") || inputdatabase.equals("Vemployee3")) {
                    strColoum = new String[]{"emp_id", "fullname"};
                }
                break;
            case 315://d_carbon_send_product
                if (inputdatabase.equals("Vemployee") || inputdatabase.equals("Vemployee1") || inputdatabase.equals("Vemployee2") || inputdatabase.equals("Vemployee3")) {
                    strColoum = new String[]{"emp_id", "fullname"};
                }
                break;

            case 0:
                switch (inputdatabase) {
                    case "Mproduct":
                        strColoum = new String[]{"product_id", "name_t"};
                        break;
                    case "m_iodine":
                    case "m_iodine_product":
                        strColoum = new String[]{"iod_range", "iod_code"};
                        break;
                    case "vd_job_order_header":
                        strColoum = new String[]{"doc_id", "cust_name", "size_name"};
                        break;
                    case "mproduct_cat":
                        strColoum = new String[]{"pcat_id", "name_t"};
                        break;
                    case "vmrawmat":
                        strColoum = new String[]{"product_id", "name_t"};
                        break;
                    case "m_carbon_size":
                        strColoum = new String[]{"name_t", "name_t"};
                        break;
                    case "mmachine":
                        strColoum = new String[]{"name_t", "machine_id"};
                        break;
                    case "mwarehouse":
                        strColoum = new String[]{"warehouse_id", "name_t"};
                        break;
                    case "vmproduct":
                        strColoum = new String[]{"product_id", "name_t"};
                        break;
                    case "vd_header_analyze":
                        strColoum = new String[]{"doc_id", "h2o", "butane", "iod", "psd_1", "psd_2", "psd_3", "psd_4", "psd_5", "psd_6", "psd_7", "psd_8", "psd_9", "psd_10", "psd_11", "psd_12", "psd_13", "psd_14", "psd_15"};
                        break;
                    case "mjob_type_detail":
                        strColoum = new String[]{"job_type_desc"};
                        break;
                }
                break;
            case 1:
                switch (inputdatabase) {
                    case "Process":
                        strColoum = new String[]{"process_id", "name_t"};
                        break;
                    case "Department":
                        strColoum = new String[]{"dept_id", "name_t"};
                        break;
                    default:
                        strColoum = new String[]{"screen_id", "screen_name", "process_id", "process_name", "iso_no", "effective_date", "dept_id", "dept_name", "qc_check", "remark", "email_from", "email_to", "email_server", "email_port"};
                        break;
                }
                break;
            case 2:
                strColoum = new String[]{"main_menu_id", "name_t", "remark"};
                break;
            case 3:
                if (inputdatabase.equals("Screen")) {
                    strColoum = new String[]{"screen_id", "name_t"};
                } else if (inputdatabase.equals("Mainmenu")) {
                    strColoum = new String[]{"main_menu_id", "name_t"};
                } else if (inputdatabase.equals("Lookup")) {
                    strColoum = new String[]{"lookup_name", "table_name"};
                } else {
                    strColoum = new String[]{"sub_menu_id", "name_t", "main_menu_id", "mmenu_main_name_t", "screen_id", "mscreen_name_t", "remark", "doc_no", "doc_eff_date", "lookup_name", "page_type"};
                }
                break;
            case 4:
                strColoum = new String[]{"priviledge_id", "name_t", "remark", "main_menu_id", "sub_menu_id"};
                break;
            case 5:
                if (inputdatabase.equals("Vuser_account")) {
                    strColoum = new String[]{"username", "fullname", "password", "emp_id", "priviledge_id", "priviledge_name", "remark", "use_status"};
                } else if (inputdatabase.equals("Vemployee")) {
                    strColoum = new String[]{"emp_id", "fullname"};
                } else {
                    strColoum = new String[]{"priviledge_id", "name_t"};
                }
                break;
            case 12:
                if (inputdatabase.equals("Driver")) {
                    strColoum = new String[]{"driver_id", "name_t"};
                } else if (inputdatabase.equals("Vmoverhead")) {
                    strColoum = new String[]{"oh_id", "name_t", "driver_id", "driver_desc"};
                } else if (inputdatabase.equals("CostMain")) {
                    strColoum = new String[]{"std_id", "name_t"};
                } else if (inputdatabase.equals("Vcostsub")) {
                    strColoum = new String[]{"std_sub_id", "name_t", "std_id", "mstd_cost_main_name_t", "oh_id", "moverhead_name_t", "driver_id", "mdriver_name_t", "cost_value", "doc_type", "remark"};
                }
                break;
            case 11:
                if (inputdatabase.equals("Vmprocess")) {
                    strColoum = new String[]{"process_id", "name_t"};
                } else {
                    strColoum = new String[]{"std_id", "name_t", "remark", "process_id"};
                }
                break;
            case 10:
                if (inputdatabase.equals("Driver")) {
                    strColoum = new String[]{"driver_id", "name_t"};
                } else {
                    strColoum = new String[]{"oh_id", "name_t", "driver_id", "driver_desc", "account_code", "remark"};
                }
                break;
            case 9:
                if (inputdatabase.equals("Driver")) {
                    strColoum = new String[]{"driver_id", "name_t", "remark"};
                }
                break;
            case 8:
                if (inputdatabase.equals("Process_group")) {
                    strColoum = new String[]{"procgrp_id", "name_t"};
                } else if (inputdatabase.equals("Warehouse") || inputdatabase.equals("Wh_bg") || inputdatabase.equals("Wh_en")) {
                    strColoum = new String[]{"warehouse_id", "name_t"};
                } else {
                    strColoum = new String[]{"process_id", "name_t", "procgrp_id", "process_grp_name", "warehouse_id", "warehouse_name", "wh_bg", "wh_bg_name", "wh_en", "wh_en_name", "remark"};
                }
                break;
            case 7:
                strColoum = new String[]{"procgrp_id", "name_t", "remark"};
                break;
            default:
                break;
        }
        // JOptionPane.showConfirmDialog(null, strColoum);

        //System.out.println("strColoum = " + strColoum);
        return strColoum;
    }

    public String SelectID(int inputpage, String inputdatabase)//function Return ค่าของ Textfill ของหน้าที่จะนำไปลงข้อมูล
    {

        switch (inputpage) {
            case 289:
                if (inputdatabase.equals("vm_friction_house")) {
                    strID = "friction_house";
                } else {
                    strID = "location_id|location_name";
                }
                break;
            case 290:
                strID = "position_no|location_name";
                break;
            case 291:
                strID = "location_id_2|location_name_2";
                break;
            case 292:
                strID = "position_no";
                break;
            case 293:
                strID = "scale_no|car_date_in|car_no|car_cbag_weight|car_weight";
                break;
            case 109:
                strID = "job_id|job_id_desc";
                break;
            case 204:
                switch (inputdatabase) {
                    case "mjob_type":
                        strID = "job_type_id|name_t|remark";
                        break;
                    case "mjob_type_detail":
                        strID = "job_type_id|job_type_desc|remark";
                        break;
                    default:
                        strID = "export_id|name_t|lookup_name|param_name|param_value|param_from|param_value_from|order_by|complete_flag|retro_flag|cancel_flag|remark";
                        break;
                }
                break;
            case 205:
                strID = "iod_code|iod_range|iod_ctype|name_t|butane|ctc|remark";
                break;
            case 206:
                if (inputdatabase.equals("mjob_type")) {
                    strID = "job_type_id|job_name_t";
                }
                break;
            case 53:
                if (inputdatabase.equals("mdata_export")) {
                    strID = "export_id|export_id_desc|lookup_name|complete_flag|retro_flag|cancel_flag";
                }
                break;
            case 116:
                strID = "product_id|product_id_desc|pgroup_name|pcat_name";
                break;
            case 30:
                if (inputdatabase.equals("m_carbon_size")) {
                    strID = "size";
                }
                break;

            case 301:
                switch (inputdatabase) {
                    case "mwarehouse":
                        strID = "wh_id|wh_id_desc";
                        break;
                    case "Vproduct":
                        strID = "product_id|product_id_desc";
                        break;
                    default:
                        strID = "product_id2|product_id_desc2";
                        break;
                }
                break;

            case 302:
                if (inputdatabase.equals("Vproduct")) {

                    strID = "product_id|product_id_desc|ctc_i2";
                }
                break;

            case 207:
                strID = "runno|location_id|name_t|price_per_unit|location_id_ref|remark";
                break;

            case 203:
                strID = "shift_id|name_t|remark";
                break;
            case 202:
                strID = "size_id|name_t|remark";
                break;
            case 201:
                strID = "prd_place|name_t|job_type_id|job_name_t|remark";
                break;
            case 200:
                strID = "machine_id|name_t|remark";
                break;
            case 13:
                strID = "dept_id|dept_name|remark";
                break;
            case 14:
                if (inputdatabase.equals("vemployee_fullname")) {
                    strID = "emp_id|name|lname|dept_id|dept_name|status|remark";
                } else {
                    strID = "dept_id|dept_name";
                }
                break;
            case 147:
                if (inputdatabase.equals("vemployee_fullname")) {
                    strID = "emp_id|name|lname";
                }
                break;
            case 15:
                switch (inputdatabase) {
                    case "mcountry":
                        strID = "country_id|country_name";
                        break;
                    case "mtambol":
                        strID = "tambol_code|tambol_name";
                        break;
                    case "mamphor":
                        strID = "amp_code|amp_name";
                        break;
                    case "mprovince":
                        strID = "prov_code|prov_name";
                        break;
                    default:
                        strID = "customer_id|name_t|address1_t|tambol_code|tambol_name|amp_code|amp_name|prov_code|prov_name|country_id|country_name|zipcode|tel|fax|contact_name|remark";
                        break;
                }
                break;
            case 16:
                switch (inputdatabase) {
                    case "mtambol":
                        strID = "tambol_code|tambol_name";
                        break;
                    case "mamphor":
                        strID = "amp_code|amp_name";
                        break;
                    case "mprovince":
                        strID = "prov_code|prov_name";
                        break;
                    case "mbranch":
                        strID = "location_id2|branch_name";
                        break;
                    case "mcredit":
                        strID = "cred_code|cred_name";
                        break;
                    default:
                        strID = "supplier_id|name_t|address1_t|tambol_code|tambol_name|amp_code|amp_name|prov_code|prov_name|zipcode|tel|fax|contact_name|remark|price_unit";
                        break;
                }
                break;
            case 17:
                strID = "pgroup_id|name_t_pgroup|remark_pgroup";
                break;
            case 18:
                strID = "pcat_id|name_t_pcat|remark_pcat";
                break;
            case 19:
                strID = "ptype_id|name_t_ptype|remark_ptype";
                break;
            case 20:
                strID = "warehouse_id|name_t_warehouse|remark_wh|wh_type";
                break;
            case 21:
                if (inputdatabase.equals("vproduct")) {
                    strID = "product_id|name_t_product|pgroup_id|name_t_pgroup|pcat_id|name_t_pcat|ptype_id|name_t_ptype|price|min|max|safety|weight|location_id|value|remark_product|size_id|size_name|butane|ctc|iodine|unit_id|unit_name|lot_no|last_movement";
                } else if (inputdatabase.equals("vmproduct")) {
                    strID = "wh_product_id|name_t_product|wh_iodine";
                } else if (inputdatabase.equals("mproduct_group")) {
                    strID = "pgroup_id|name_t_pgroup";
                } else if (inputdatabase.equals("mproduct_cat")) {
                    strID = "pcat_id|name_t_pcat";
                } else if (inputdatabase.equals("mproduct_type")) {
                    strID = "ptype_id|name_t_ptype";
                } else if (inputdatabase.equals("munit_code")) {
                    strID = "unit_id|unit_name";
                } else {
                    strID = "size_id|size_name";
                }
                break;
            case 114:
                strID = "doc_id|doc_date";
                break;
            case 103:
                switch (inputdatabase) {
                    case "mdepartment":
                        strID = "prd_emp_id|prd_emp_id_desc";
                        break;
                    case "Vemployee1":
                        strID = "sending_id|sending_id_desc";
                        break;
                    default:
                        strID = "wh_emp_id|wh_emp_id_desc";
                        break;
                }
                break;
            case 105:
                if (inputdatabase.equals("Vemployee")) {
                    strID = "reporter_id|reporter_id_desc";
                } else {
                    strID = "checker_id|checker_id_desc";
                }
                break;
            case 106:
                if (inputdatabase.equals("Vd_job_order_header")) {
                    strID = "prd_no|cust_id|cust_id_desc|size|quantity";
                }
                break;
            case 108:
                switch (inputdatabase) {
                    case "Vd_job_order_header":
                        strID = "prd_no|prd_no_desc";
                        break;
                    case "Mproduct_cat":
                        strID = "c_type|c_type_desc";
                        break;
                    case "m_carbon_size":
                        strID = "size";
                        break;
                }

                break;
            case 112:
                if (inputdatabase.equals("Vd_job_order_header")) {
                    strID = "job_no|cust_id|cust_id_desc";
                } else if (inputdatabase.equals("Vproduct")) {
                    strID = "product_id|product_id_desc";
                }
                break;
            case 51:
                if (inputdatabase.equals("vd_product_receive_header_wh")) {
                    strID = "doc_id|doc_date|palate_no|remark|job_id|cust_name";
                }
                break;
            case 50:
                if (inputdatabase.equals("d_carbon_withdraw_header_wh")) {
                    strID = "doc_id|doc_date";
                }
                break;
            case 22:
                switch (inputdatabase) {
                    case "Vsupplier":
                        strID = "supplier_id|supplier_id_desc|sup_tel_desc|sup_address_desc|price_unit";
                        break;
                    case "Vproduct":
                        strID = "product_id|product_id_desc";
                        break;
                    case "Vd_rawmatt_receive":
                        strID = "doc_id|doc_date|wh_in|wh_name|supplier_id|supplier_id_desc|sup_tel_desc|sup_address_desc|position_no|scale_no|car_no|driver_name|type_prod|product_id|total_weight|bag_weight|ashes_percent|ashes_weight|dust_percent|dust_weight|volatile_percent|volatile_weight|moise_percent|moise_weight|contamination_percent|contamination_weight|net_weight|remark|car_date_in|bag_total|ashes_percent_ch|ashes_weight_ch|dust_percent_ch|dust_weight_ch|volatile_percent_ch|volatile_weight_ch|moise_percent_ch|moise_weight_ch|contamination_percent_ch|contamination_weight_ch|net_weight_ch|car_cbag_weight|car_weight|bag_net|carbon_net|select_mbranch|price_unit|lab_not_check";
                        //strID = "doc_id|doc_date|wh_in|wh_name|supplier_id|supplier_id_desc|sup_tel_desc|sup_address_desc|position_no|scale_no|car_no|driver_name|type_prod|product_id|total_weight|bag_weight|ashes_percent|ashes_weight|dust_percent|dust_weight|volatile_percent|volatile_weight|moise_percent|moise_weight|contamination_percent|contamination_weight|net_weight|remark|total_price|car_date_in|bag_total|ashes_percent_ch|ashes_weight_ch|dust_percent_ch|dust_weight_ch|volatile_percent_ch|volatile_weight_ch|moise_percent_ch|moise_weight_ch|contamination_percent_ch|contamination_weight_ch|net_weight_ch|car_cbag_weight|car_weight|bag_net|carbon_net|select_mbranch|price_unit";
                        //ashes_percent_ch,ashes_weight_ch,dust_percent_ch,dust_weight_ch,volatile_percent_ch,volatile_weight_ch,moise_percent_ch,moise_weight_ch,contamination_percent_ch,contamination_weight_ch,net_weight_ch
                        break;
                    case "Vd_fuel_receive":
                        strID = "doc_id|doc_date|wh_in|wh_name|supplier_id|supplier_id_desc"
                                + "|sup_tel_desc|sup_address_desc"
                                + "|position_no|scale_no|car_date_in|car_time_in|car_date_out|car_time_out"
                                + "|car_no|driver_name|product_id"
                                + "|car_weight_in|car_weight_out|total_weight"
                                + "|reporter_id|reporter_id_desc|checker1|checker1_desc|price_unit"
                                + "|total_price|remark|moisture|moisture_std|deduct_weight_moisture"
                                + "|net_weight_receive|net_weight_payment|status";
                        break;
                    case "vmrawmat":
                        strID = "product_id|prod_name";
                        break;
                    case "vmwarehouse":
                        strID = "wh_id|wh_name";
                        break;
                    case "vm_burn_no":
                        strID = "burn_no";
                        break;
                    case "vm_burn_no2":
                        strID = "burn_no_2";
                        break;
                    case "vm_burn_no3":
                        strID = "burn_no_3";
                        break;
                    case "vm_burn_no4":
                        strID = "burn_no_4";
                        break;
                    case "vm_burn_no5":
                        strID = "burn_no_5";
                        break;
                    case "vm_burn_no6":
                        strID = "burn_no_6";
                        break;
                    case "vm_burn_no7":
                        strID = "burn_no_7";
                        break;
                    case "vm_burn_no8":
                        strID = "burn_no_8";
                        break;
                    case "vm_burn_no9":
                        strID = "burn_no_9";
                        break;
                    case "vm_burn_no10":
                        strID = "burn_no_10";
                        break;
                    default:
                        strID = "wh_in|wh_name";
                        break;
                }
                break;
            case 221:
                switch (inputdatabase) {
                    case "Vsupplier":
                        strID = "supplier_id|supplier_id_desc|sup_tel_desc|sup_address_desc";
                        break;
                    case "vd_ticketbuy_fuel":
                        strID = "scale_no|doc_date|car_no|product_id|car_weight_in|car_weight_out|net_weight_receive|car_date_in|car_date_out|car_time_in|car_time_out|total_weight";
                        break;
                }
                break;
            case 222:
                switch (inputdatabase) {
                    case "vmbank":
                        strID = "bank_id|bank_name";
                        break;
                    case "vd_carbon_friction_burn_detail":
                        strID = "doc_id|doc_date|product_id|weight_carbon_in|weight_carbon_friction|weight_carbon_dust|weight_carbon_iron"
                                + "|weight_carbon_total|weight_carbon_bigbag|weight_carbon_burn_in|weight_carbon_real_lost"
                                + "|percent_carbon_real_lost|weight_carbon_lost|percent_carbon_lost|burn_no|channel|wh_id|location_id|remark|percent_moisture"
                                + "|rawmat_emp_id|product_emp_id|complete_flag|wh_name|rawmat_emp_name"
                                + "|product_emp_name|prod_name"
                                + "|weight_carbon_burn_in_2|burn_no_2|channel_2|weight_carbon_burn_in_3|burn_no_3|channel_3"
                                + "|weight_carbon_burn_in_4|burn_no_4|channel_4|weight_carbon_burn_in_5|burn_no_5|channel_5"
                                + "|weight_carbon_burn_in_total|burn_date_1|burn_date_2|burn_date_3|burn_date_4|burn_date_5"
                                + "|burn_date_6|burn_date_7|burn_date_8|burn_date_9|burn_date_10|"
                                + "weight_carbon_burn_in_6|burn_no_6|channel_6|weight_carbon_burn_in_7|burn_no_7|channel_7|"
                                + "weight_carbon_burn_in_8|burn_no_8|channel_8|weight_carbon_burn_in_9|burn_no_9|channel_9|"
                                + "weight_carbon_burn_in_10|burn_no_10|channel_10";
                        break;
                    default:
                        strID = "doc_id|doc_date|wh_in|wh_name|supplier_id|supplier_id_desc|sup_tel_desc|sup_address_desc|position_no|scale_no|car_no|driver_name|type_prod|product_id|total_weight|bag_weight|ashes_percent|ashes_weight|dust_percent|dust_weight|volatile_percent|volatile_weight|moise_percent|moise_weight|contamination_percent|contamination_weight|net_weight|remark|total_price|car_date_in|bag_total|ashes_percent_ch|ashes_weight_ch|dust_percent_ch|dust_weight_ch|volatile_percent_ch|volatile_weight_ch|moise_percent_ch|moise_weight_ch|contamination_percent_ch|contamination_weight_ch|net_weight_ch|car_cbag_weight|car_weight|bag_net|carbon_net|price_flag|select_mbranch|price_unit|payment_no|payment_method|bank_id|bank_name|cheque_no|text_price|total_price|bank_acc_no|net_weight_payment";
                        break;
                }
                break;
            case 223:
                strID = "doc_id|doc_date|wh_in|wh_name|supplier_id|supplier_id_desc|sup_tel_desc|sup_address_desc|position_no|scale_no|car_no|driver_name|type_prod|product_id|total_weight|bag_weight|ashes_percent|ashes_weight|dust_percent|dust_weight|volatile_percent|volatile_weight|moise_percent|moise_weight|contamination_percent|contamination_weight|net_weight|remark|car_date_in|bag_total|ashes_percent_ch|ashes_weight_ch|dust_percent_ch|dust_weight_ch|volatile_percent_ch|volatile_weight_ch|moise_percent_ch|moise_weight_ch|contamination_percent_ch|contamination_weight_ch|net_weight_ch|car_cbag_weight|car_weight|bag_net|carbon_net|select_mbranch|price_unit|ashes_percent_acc|ashes_weight_acc|dust_percent_acc|dust_weight_acc|volatile_percent_acc|volatile_weight_acc|moise_percent_acc|moise_weight_acc|contamination_percent_acc|contamination_weight_acc|net_weight_acc";
                break;
            case 224:
                //strID = "doc_id|doc_date|wh_in|wh_name|supplier_id|supplier_id_desc|sup_tel_desc|sup_address_desc|position_no|scale_no|car_no|driver_name|type_prod|product_id|total_weight|bag_weight|ashes_percent|ashes_weight|dust_percent|dust_weight|volatile_percent|volatile_weight|moise_percent|moise_weight|contamination_percent|contamination_weight|net_weight|remark|total_price|car_date_in|bag_total|ashes_percent_ch|ashes_weight_ch|dust_percent_ch|dust_weight_ch|volatile_percent_ch|volatile_weight_ch|moise_percent_ch|moise_weight_ch|contamination_percent_ch|contamination_weight_ch|net_weight_ch|car_cbag_weight|car_weight|bag_net|carbon_net|price_flag|select_mbranch|price_unit|payment_no|payment_method|bank_id|bank_name|cheque_no|text_price|total_price|bank_acc_no|net_weight_payment|net_weight_acc";
                strID = "doc_id|doc_date|wh_in|wh_name|supplier_id|supplier_id_desc|sup_tel_desc|sup_address_desc|position_no|scale_no|car_no|driver_name|type_prod|product_id|total_weight|bag_weight|ashes_percent|ashes_weight|dust_percent|dust_weight|volatile_percent|volatile_weight|moise_percent|moise_weight|contamination_percent|contamination_weight|net_weight|total_price|car_date_in|bag_total|ashes_percent_ch|ashes_weight_ch|dust_percent_ch|dust_weight_ch|volatile_percent_ch|volatile_weight_ch|moise_percent_ch|moise_weight_ch|contamination_percent_ch|contamination_weight_ch|net_weight_ch|car_cbag_weight|car_weight|bag_net|carbon_net|price_flag|select_mbranch|price_unit|payment_no|payment_method|bank_id|bank_name|cheque_no|text_price|total_price|bank_acc_no|net_weight_payment|net_weight_acc";
                break;

            case 59:
                strID = "pgroup_id|iodine|price_month_1|price_month_2|price_month_3|price_month_4|price_month_5|price_month_6|price_month_7|price_month_8|price_month_9|price_month_10|price_month_11|price_month_12|product_id|lot_no|runno|remark|name_t_product";
                break;

            case 62:
                strID = "pgroup_id|iodine|price_month_1|price_month_2|price_month_3|price_month_4|price_month_5|price_month_6|price_month_7|price_month_8|price_month_9|price_month_10|price_month_11|price_month_12|product_id|lot_no|runno|remark|name_t_product";
                break;

            case 591:
                if (inputdatabase.equals("vmproduct")) {
                    strID = "product_id|name_t_product|pgroup_id|lot_no|iodine";
                    break;
                }

            case 60:
                strID = "doc_id|cust_name|size_name|psd_1|psd_2|psd_3|psd_4|psd_5|psd_6|psd_7|psd_8|psd_9|psd_10|psd_11|psd_12|psd_13|psd_14|psd_15|h2o|butane|iod|pass|n_pass|grade|remark";
                break;
            case 600:
                strID = "doc_id_copy_to";
                break;
            case 61:
                if (inputdatabase.equals("vd_header_analyze")) {
                    strID = "doc_id|psd_1|psd_2|psd_3|psd_4|psd_5|psd_6|psd_7|psd_8|psd_9|psd_10|psd_11|psd_12|psd_13|psd_14|psd_15|h2o|butane|iod|pass|n_pass|grade|remark";
                } else {
                    strID = "doc_id_copy_to";
                }
                break;

            case 23:
                switch (inputdatabase) {
                    case "Vemployee":
                        strID = "runner_id|runner_id_desc";
                        break;
                    case "Vemployee1":
                        strID = "rawmat_emp|rawmat_emp_name";
                        break;
                    case "Mproduct_type":
                        strID = "p_type|p_type_desc";
                        break;
                    case "Wh_bg":
                        strID = "wh_in|wh_in_desc";
                        break;
                    case "Wh_en":
                        strID = "wh_out|wh_out_desc";
                        break;
                    case "mwarehouse":
                        strID = "wh_id|wh_id_desc";
                        break;
                }
                break;
            case 24:
                switch (inputdatabase) {
                    case "msupplier":
                        strID = "supplier_id|supplier_id_desc";
                        break;
                    case "mdepartment":
                        strID = "cust_id|cust_id_desc";
                        break;
                    case "v_rawmatt_receive_supplier":
                        strID = "supplier_id|supplier_id_desc";
                        break;
                }
                break;
            case 25:
                switch (inputdatabase) {
                    case "Warehouse":
                        strID = "loc_1_desc|loc_1_name";
                        break;
                    case "Warehouse1":
                        strID = "loc_2_desc|loc_2_name";
                        break;
                    case "Warehouse2":
                        strID = "loc_3_desc|loc_3_name";
                        break;
                    default:
                        strID = "report_id|report_id_desc";
                        break;
                }
                break;
            case 26:
                if (inputdatabase.equals("Warehouse")) {
                    strID = "silo_no|silo_desc";
                }
                break;
            case 27:
                switch (inputdatabase) {
                    case "Vemployee":
                        strID = "runner_id|runner_id_desc";
                        break;
                    case "m_iodine":
                        strID = "bu|iod";
                        break;
                    default:
                        strID = "operate_id|operate_id_desc";
                        break;
                }
                break;
            case 28:
                if (inputdatabase.equals("Warehouse")) {
                    strID = "silo_no|silo_desc";
                }
                break;
            case 29:
                if (inputdatabase.equals("Vemployee1")) {
                    strID = "runner_id|runner_id_desc";
                } else {
                    strID = "report_id|report_id_desc";
                }
                break;
            case 57:
                strID = "product_id|product_name";
                break;
            case 32:
                switch (inputdatabase) {
                    case "Vcustomer":
                        strID = "cust_id|cust_id_desc|country_id|country_id_desc";
                        break;
                    case "Vemployee":
                        strID = "approve|approve_desc";
                        break;
                    case "Vemployee1":
                        strID = "quality_dep|quality_dep_desc";
                        break;
                    case "Vemployee2":
                        strID = "prod_dep|prod_dep_desc";
                        break;
                    case "Vemployee3":
                        strID = "wh_dep|wh_dep_desc";
                        break;
                    case "vd_saleorderproduct_master":
                        strID = "po_no|cust_id|cust_id_desc|country_id|country_id_desc";
                        break;
                    case "vd_saleorderproduct_detail":
                        //strID = "po_no|cust_id|cust_id_desc|country_id|country_id_desc|spec3|spec2|spec1|spec6|spec7|spec8";
                        strID = "po_no";
                        break;
                    case "mmachine":
                        strID = "machine";
                        break;
                    default:
                        strID = "country_id|country_id_desc";
                        break;
                }
                break;
            case 34:
                switch (inputdatabase) {
                    case "Vemployee":
                        strID = "prd_emp_id|prd_emp_id_desc";
                        break;
                    case "Vemployee1":
                        strID = "wh_emp_id|wh_emp_id_desc";
                        break;
                    case "Vemployee2":
                        strID = "wh_sup_id|wh_sup_id_desc";
                        break;
                    default:
                        strID = "work_type_id|work_type";
                        break;
                }
                break;
            case 35:
                switch (inputdatabase) {
                    case "Mproduct_cat":
                        strID = "pcat_id|pcat_id_desc";
                        break;
                    case "Vd_job_order_header":
                        strID = "job_id|job_id_desc";
                        break;
                    case "m_carbon_size":
                        strID = "size_use";
                        break;
                    case "mproduct":
                        strID = "product_id|product_id_desc";
                        break;
                    default:
                        strID = "machine";
                        break;
                }
                break;
            case 36:
                switch (inputdatabase) {
                    case "Vproduct":
                        strID = "product_id|product_id_desc";
                        break;
                    case "Vd_job_order_header":
                        strID = "job_id|job_id_desc|size|ctc_i2";
                        break;
                }
                break;

            case 361:
                strID = "job_id|job_id_desc";
                break;

            case 37:
                switch (inputdatabase) {
                    case "Mwarehouse":
                        strID = "wh_id|wh_id_desc";
                        break;
                    case "munit_code":
                        strID = "unit_id|unit_id_desc";
                        break;
                }
                break;
            case 38:
                if (inputdatabase.equals("Vd_job_order_header")) {
                    strID = "job_id|job_id_desc";
                }
                break;
            case 39:
                if (inputdatabase.equals("Vproduct")) {
                    strID = "product_id|product_id_desc";
                }
                break;
            case 40:
                switch (inputdatabase) {
                    case "Vd_job_order_header":
                        strID = "job_id|job_id_desc";
                        break;
                    case "Vemployee":
                        strID = "emp_id|emp_id_desc";
                        break;
                    case "Vemployee1":
                        strID = "runner_id|runner_id_desc";
                        break;
                }
                break;
            case 41:
                switch (inputdatabase) {
                    case "mproduction_place":
                        strID = "place_prd|place_prd_desc";
                        break;
                    case "Mwarehouse":
                        strID = "wh_id|wh_id_desc";
                        break;
                    case "M_doc_type":
                        strID = "doc_type|doc_type_sign";
                        break;
                    default:
                        strID = "size|size_desc";
                        break;
                }
                break;
            case 42:
                if (inputdatabase.equals("Vd_job_order_header")) {
                    strID = "job_id|cust_id|job_id_desc|cust_address_desc|cust_country_desc|po_no_desc";
                }
                switch (inputdatabase) {
                    case "Vemployee":
                        strID = "approver|approver_desc";
                        break;
                    case "Vemployee1":
                        strID = "payment_prod|payment_prod_desc";
                        break;
                    case "Vemployee2":
                        strID = "receiver|receiver_desc";
                        break;
                }
                break;
            case 43:
                if (inputdatabase.equals("Vproduct")) {
                    strID = "product_id|product_id_desc";
                } else {
                    strID = "job_id|job_id_desc";
                }
                break;
            case 44:
                switch (inputdatabase) {
                    case "m_carbon_size":
                        strID = "size|size_desc";
                        break;
                    case "Mwarehouse":
                        strID = "wh_id|wh_id_desc";
                        break;
                }
                break;
            case 45:
                if (inputdatabase.equals("Vemployee")) {
                    strID = "emp_id|emp_id_desc";
                } else {
                    strID = "unit_id|unit_id_desc";
                }
                break;
            case 46:
                switch (inputdatabase) {
                    case "Vd_rawmatt_receive":
                        strID = "doc_id|car_no|c_type|sender_id|sender_id_desc|car_date_in";
                        break;
                    case "Vemployee":
                        strID = "sender_id|sender_id_desc";
                        break;
                    case "Vemployee1":
                        strID = "report_id|report_id_desc";
                        break;
                    case "Vemployee2":
                        strID = "approve_id|approve_id_desc";
                        break;
                }
                break;

            case 48:
                if (inputdatabase.equals("vmprocess")) {
                    strID = "process_id|name_t|table_h|table_s1|table_s2";
                } else {
                    strID = "doc_id|doc_date";
                }
                break;
            case 482:
                if (inputdatabase.equals("vmprocess")) {
                    strID = "process_id|process_name|table_h|table_s1|table_s2|table_s3";
                } else {
                    strID = "doc_id|doc_date";
                }
                break;
            case 49:
                if (inputdatabase.equals("vd_carbon_burn_out_header_wh")) {
                    strID = "doc_id|doc_date";
                }
                break;
            case 101:
                if (inputdatabase.equals("Vd_rawmatt_receive")) {
                    strID = "doc_id_t";
                }
                break;
            case 100:
                if (inputdatabase.equals("Vd_rawmatt_receive")) {
                    strID = "doc_id_f";
                }
                break;

            case 312:
                if (inputdatabase.equals("vmessage")) {
                    strID = "message_id|message_detail|status";
                } else {
                    strID = "doc_id|year_text|select_product_id|supplier_id|select_rate|quality_id|report_id|runner_id|report_id_desc|runner_id_desc|supplier_id_desc";
                }
                break;
            case 313:
                switch (inputdatabase) {
                    case "Vemployee":
                        strID = "reporter_id|reporter_id_desc";
                        break;
                    case "Vemployee1":
                        strID = "approve_id|approve_id_desc";
                        break;
                    case "Vemployee2":
                        strID = "checker1|checker1_desc";
                        break;
                    case "Vemployee3":
                        strID = "rawmat_emp_id|rawmat_emp_name";
                        break;
                    case "Vemployee4":
                        strID = "product_emp_id|product_emp_name";
                        break;
                }
                break;

            case 314:
                switch (inputdatabase) {
                    case "Vemployee":
                        strID = "A_product_leader_id|A_product_leader_name";
                        break;
                    case "Vemployee1":
                        strID = "A_lab_leader_id|A_lab_leader_name";
                        break;
                    case "Vemployee2":
                        strID = "A_warehouse_emp_id|A_warehouse_emp_name";
                        break;
                    case "Vemployee3":
                        strID = "A_warehouse_leader_id|A_warehouse_leader_name";
                        break;
                }
                break;

            case 315:
                if (inputdatabase.equals("Vemployee")) {
                    strID = "lab_emp_id|lab_emp_name";
                }
                break;

            case 0:
                switch (inputdatabase) {
                    case "Mproduct":
                        strID = "product_id|name_t";
                        break;
                    case "vd_header_analyze":
                        strID = "param_header_id|h2o_header|butane_header|iod_header|psd_1_header|psd_2_header|psd_3_header|psd_4_header|psd_5_header|psd_6_header|psd_7_header|psd_8_header|psd_9_header|psd_10_header|psd_11_header|psd_12_header|psd_13_header|psd_14_header|psd_15_header";
                        break;
                    case "vd_job_order_header":
                        strID = "product_id|name_t";
                        break;
                }

                break;
            case 1:
                switch (inputdatabase) {
                    case "Process":
                        strID = "process_id|name_t_process";
                        break;
                    case "Department":
                        strID = "dept_id|name_t_dept";
                        break;
                    default:
                        strID = "screen_id|name_t_screen|process_id|name_t_process|iso_no|effective_date|dept_id|name_t_dept|qc_check|remark_screen|email_from|email_to|email_server|email_port";
                        break;
                }
                break;
            case 2:
                strID = "main_menu_id|name_t|remark";
                break;
            case 3:
                switch (inputdatabase) {
                    case "Screen":
                        strID = "screen_id|screen_id_desc";
                        break;
                    case "Mainmenu":
                        strID = "main_menu_id|main_menu_id_desc";
                        break;
                    case "Lookup":
                        strID = "lookup|hid";
                        break;
                    default:
                        strID = "sub_menu_id|name_t|main_menu_id|main_menu_id_desc|screen_id|screen_id_desc|remark|doc_no|effective_date|lookup|typesub";
                        break;
                }
                break;
            case 5:
                switch (inputdatabase) {
                    case "Vuser_account":
                        strID = "username|name_emp|password|emp_id|priviledge_id|name_priviledge|remark|status";
                        break;
                    case "Vemployee":
                        strID = "emp_id|name_emp";
                        break;
                    default:
                        strID = "priviledge_id|name_priviledge";
                        break;
                }
                break;
            case 12:
                switch (inputdatabase) {
                    case "Driver":
                        strID = "driver_id|driver_id_desc";
                        break;
                    case "Vmoverhead":
                        strID = "oh_id|oh_id_desc|driver_id|driver_id_desc";
                        break;
                    case "CostMain":
                        strID = "std_id|std_id_desc";
                        break;
                    case "Vcostsub":
                        strID = "std_sub_id|name_t|std_id|std_id_desc|oh_id|oh_id_desc|driver_id|driver_id_desc|cost_value|type_cost|remark";
                        break;
                }
                break;

            case 11:
                if (inputdatabase.equals("Vmprocess")) {
                    strID = "process_id|process_id_desc";
                } else {
                    strID = "std_id|name_t|remark|process_id";
                }
                break;
            case 10:
                if (inputdatabase.equals("Driver")) {
                    strID = "driver_id|driver_id_desc";
                } else {
                    strID = "oh_id|name_t|driver_id|driver_id_desc|account_code|remark";
                }
                break;
            case 9:
                strID = "driver_id|name_t|remark";
                break;
            case 8:
                switch (inputdatabase) {
                    case "Process_group":
                        strID = "procgrp_id|procgrp_id_desc";
                        break;
                    case "Warehouse":
                        strID = "warehouse_id|warehouse_id_desc";
                        break;
                    case "Wh_bg":
                        strID = "wh_bg|wh_bg_desc";
                        break;
                    case "Wh_en":
                        strID = "wh_en|wh_en_desc";
                        break;
                    default:
                        strID = "process_id|name_t|procgrp_id|procgrp_id_desc|warehouse_id|warehouse_id_desc|wh_bg|wh_bg_desc|wh_en|wh_en_desc|remark";
                        break;
                }
                break;
            case 7:
                strID = "procgrp_id|name_t|remark";
                break;
            default:
                break;
        }
        //JOptionPane.showConfirmDialog(null, strID);
        //System.out.println("strID = " + strID);
        return strID;
    }

    public String[] SelectFillName(int inputpage, String inputdatabase)//function แสดงชื่อ Fill ของ Table(HTML)
    {
        switch (inputpage) {
            case 0:
                switch (inputdatabase) {
                    case "m_iodine":
                    case "m_iodine_product":
                        strFillName = new String[]{"ค่าไอโอดีน", "รหัสค่าไอโอดีน"};
                        break;
                    case "vd_job_order_header":
                        strFillName = new String[]{"เลขที่ใบแจ้งผลิต", "ชื่อลูกค้า", "ขนาดถ่าน"};
                        break;
                    case "mproduct_cat":
                        strFillName = new String[]{"รหัสชนิดถ่าน", "ชนิดถ่าน"};
                        break;
                    case "vmrawmat":
                        strFillName = new String[]{"รหัสชนิดถ่าน", "ชนิดถ่าน"};
                        break;
                    case "m_carbon_size":
                        strFillName = new String[]{"รหัสขนาด", "ขนาดถ่าน"};
                        break;
                    case "mmachine":
                        strFillName = new String[]{"เครื่องผลิต", "รหัสเครื่องจักร"};
                        break;
                    case "mwarehouse":
                        strFillName = new String[]{"รหัสคลังสินค้า", "ชื่อคลังสินค้า"};
                        break;
                    case "vmproduct":
                        strFillName = new String[]{"รหัสสินค้า", "ชื่อสินค้า"};
                        break;
                    case "vd_header_analyze":
                        strFillName = new String[]{"เลขที่ Parameter", "psd_1", "psd_2", "psd_3", "psd_4", "psd_5"};
                        break;
                    case "mjob_type_detail":
                        strFillName = new String[]{"รายละเอียด"};
                        break;
                }
                break;
            case 289:
                if (inputdatabase.equals("vm_friction_house")) {
                    strFillName = new String[]{"โรงสี"};
                } else {
                    strFillName = new String[]{"รหัสกอง", "กองที่"};
                }
                break;
            case 290:
                strFillName = new String[]{"รหัสกอง", "กองที่"};
                break;
            case 291:
                strFillName = new String[]{"รหัสกอง", "กองที่"};
                break;
            case 292:
                strFillName = new String[]{"รหัสกอง", "กองที่"};
                break;
            case 293:
                strFillName = new String[]{"เลขที่ใบชั่ง", "ทะเบียนรถ", "ชื่อผู้ขาย", "วันที่เข้า", "เวลาเข้า", "เลขที่ใบรับถ่าน"};
                break;
            case 109:
                strFillName = new String[]{"เลขที่ใบแจ้งผลิต", "ชื่อลูกค้า"};
                break;
            case 204:
                if (inputdatabase.equals("mjob_type") || inputdatabase.equals("mjob_type_detail")) {
                    strFillName = new String[]{"รหัสประเภทงาน", "ชื่อประเภทงาน"};
                } else {
                    strFillName = new String[]{"รหัสExport", "Export Name"};
                }
                break;
            case 205:
                strFillName = new String[]{"รหสัค่า IODINE", "ช่วงค่า IODINE", "ช่วงค่า BUTANE"};
                break;
            case 206:
                if (inputdatabase.equals("mjob_type")) {
                    strFillName = new String[]{"รหัสประเภทงาน", "ชื่อประเภทงาน"};
                }
                break;
            case 53:
                if (inputdatabase.equals("mdata_export")) {
                    strFillName = new String[]{"รหัสExport", "Export Name"};
                } else if (inputdatabase.indexOf("d_") != -1) {
                    strFillName = new String[]{"เลขที่เอกสาร", "ลำดับเอกสาร"};
                }
                break;
            case 116:
                strFillName = new String[]{"รหัสสินค้า", "ชื่อสินค้า", "กลุ่มสินค้า"};
                break;
            case 30:
                if (inputdatabase.equals("m_carbon_size")) {
                    strFillName = new String[]{"ชื่อขนาดถ่าน"};
                }
                break;
            case 301:
                if (inputdatabase.equals("mwarehouse")) {
                    strFillName = new String[]{"รหัสคลัง", "ชื่อคลัง"};
                } else {
                    strFillName = new String[]{"รหัสสินค้า", "ชื่อสินค้า", "ประภทสินค้า"};
                }
                break;
            case 302:
                if (inputdatabase.equals("Vproduct")) {
                    strFillName = new String[]{"รหัสสินค้า", "ชื่อสินค้า", "ประภทสินค้า"};
                }
                break;
            case 13:
                strFillName = new String[]{"รหัสแผนก", "ชื่อแผนก"};
                break;
            case 14:
                if (inputdatabase.equals("vemployee_fullname")) {
                    strFillName = new String[]{"รหัสพนักงาน", "ชื่อ-นามสกุล"};
                } else {
                    strFillName = new String[]{"รหัสแผนก", "ชื่อแผนก"};
                }
                break;

            case 147:
                if (inputdatabase.equals("vemployee_fullname")) {
                    strFillName = new String[]{"รหัสพนักงาน", "ชื่อ-นามสกุล"};
                }
                break;

            case 15:
                switch (inputdatabase) {
                    case "mcountry":
                        strFillName = new String[]{"รหัสประเทศ", "ชื่อประเทศ"};
                        break;
                    case "mtambol":
                        strFillName = new String[]{"รหัสตำบล", "ชื่อตำบล"};
                        break;
                    case "mamphor":
                        strFillName = new String[]{"รหัสอำเภอ", "ชื่ออำเภอ"};
                        break;
                    case "mprovince":
                        strFillName = new String[]{"รหัสจังหวัด", "ชื่อจังหวัด"};
                        break;
                    default:
                        strFillName = new String[]{"รหัสลูกค้า", "ชื่อลูกค้า"};
                        break;
                }
                break;
            case 16:
                switch (inputdatabase) {
                    case "mtambol":
                        strFillName = new String[]{"รหัสตำบล", "ชื่อประเทศ"};
                        break;
                    case "mamphor":
                        strFillName = new String[]{"รหัสอำเภอ", "ชื่ออำเภอ"};
                        break;
                    case "mprovince":
                        strFillName = new String[]{"รหัสจังหวัด", "ชื่อจังหวัด"};
                        break;
                    case "mbranch":
                        strFillName = new String[]{"รหัสสาขา", "ชื่อสาขา"};
                        break;
                    default:
                        strFillName = new String[]{"รหัสsupplier", "รหัสsupplier"};
                        break;
                }
                break;
            case 17:
                strFillName = new String[]{"รหัสกลุ่มสินค้า", "ชื่อกลุ่มสินค้า"};
                break;
            case 18:
                strFillName = new String[]{"รหัสชนิดสินค้า", "ชื่อชนิดสินค้า"};
                break;
            case 19:
                strFillName = new String[]{"รหัสประเภทสินค้า", "ชื่อประเภทสินค้า"};
                break;
            case 20:
                strFillName = new String[]{"รหัสคลังสินค้า", "ชื่อคลังสินค้า"};
                break;
            case 21:
                switch (inputdatabase) {
                    case "vproduct":
                    case "vmproduct":
                        strFillName = new String[]{"รหัสสินค้า", "ชื่อสินค้า", "ประภทสินค้า"};
                        break;
                    case "mproduct_group":
                        strFillName = new String[]{"รหัสกลุ่มสินค้า", "ชื่อกลุ่มสินค้า"};
                        break;
                    case "mproduct_cat":
                        strFillName = new String[]{"รหัสชนิดสินค้า", "ชื่อชนิดสินค้า"};
                        break;
                    case "mproduct_type":
                        strFillName = new String[]{"รหัสประเภทสินค้า", "ชื่อประเภทสินค้า"};
                        break;
                    case "munit_code":
                        strFillName = new String[]{"รหัสหน่วยนับ", "ชื่อหน่วยนับ"};
                        break;
                    default:
                        strFillName = new String[]{"รหัสขนาด", "ชื่อขนาด"};
                        break;
                }
                break;
            case 114:
                strFillName = new String[]{"เลขที่เอกสาร", "วันที่เอกสาร"};
                break;
            case 103:

                if (inputdatabase.equals("mdepartment")) {
                    strFillName = new String[]{"รหัสแผนก", "ชื่อแผนก"};
                } else {
                    strFillName = new String[]{"รหัสพนักงาน", "ชื่อ", "รหัสแผนก", "ชื่อแผนก"};
                }
                break;
            case 105:
                strFillName = new String[]{"รหัสพนักงาน", "ชื่อ", "รหัสแผนก", "ชื่อแผนก"};
                break;
            case 106:
                strFillName = strFillName = new String[]{"รหัสใบแจ้งการผลิต", "บริษัทสั่งผลิต", "วันที่บันทึกเอกสาร"};
                break;
            case 108:
                switch (inputdatabase) {
                    case "Vd_job_order_header":
                        strFillName = new String[]{"รหัสใบแจ้งการผลิต", "บริษัทสั่งผลิต", "วันที่บันทึกเอกสาร"};
                        break;
                    case "Mproduct_cat":
                        strFillName = new String[]{"รหัสชนิดถ่าน", "ชื่อชนิดถ่าน"};
                        break;
                    case "m_carbon_size":
                        strFillName = new String[]{"ขนาดถ่าน"};
                        break;
                }
                break;
            case 112:
                switch (inputdatabase) {
                    case "Vd_job_order_header":
                        strFillName = new String[]{"รหัสใบแจ้งการผลิต", "บริษัทสั่งผลิต", "วันที่บันทึกเอกสาร"};
                        break;
                    case "Vproduct":
                        strFillName = new String[]{"รหัสสินค้า", "ชื่อสินค้า"};
                        break;
                }
                break;
            case 51:
                if (inputdatabase.equals("vd_product_receive_header_wh")) {
                    strFillName = new String[]{"เลขที่เอกสาร", "วันที่บันทึกเอกสาร", "ใบแจ้งการผลิต", "ชื่อลูกค้า"};
                }
                break;
            case 31:
                if (inputdatabase.equals("Vproduct")) {
                    strFillName = new String[]{"รหัสสินค้า", "ชื่อสินค้า"};
                }
                break;
            case 50:
                if (inputdatabase.equals("d_carbon_withdraw_header_wh")) {
                    strFillName = new String[]{"เลขที่เอกสาร", "วันที่บันทึกเอกสาร"};
                }
                break;
            case 22:
                switch (inputdatabase) {
                    case "Vsupplier":
                        strFillName = new String[]{"รหัสSupplier", "ชื่อSupplier"};
                        break;
                    case "Vproduct":
                        strFillName = new String[]{"รหัสสินค้า", "ชื่อสินค้า"};
                        break;
                    case "Vd_rawmatt_receive":
                        strFillName = new String[]{"เลขที่เอกสาร", "วันที่บันทึกเอกสาร", "ชื่อSupplier", "น้ำหนักสุทธิ", "สถานะการจ่ายเงิน", "เลขที่ใบชั่ง"};
                        break;
                    case "Vd_fuel_receive":
                        strFillName = new String[]{"เลขที่เอกสาร", "วันที่บันทึกเอกสาร", "ชื่อSupplier", "เลขที่ใบชั่ง"};
                        break;
                    case "vmrawmat":
                        strFillName = new String[]{"รหัสถ่าน", "ชนิดถ่าน"};
                        break;
                    default:
                        strFillName = new String[]{"รหัสคลังสินค้า", "ชื่อคลังสินค้า"};
                        break;
                }
                break;
            case 221:
                switch (inputdatabase) {
                    case "Vsupplier":
                        strFillName = new String[]{"รหัสSupplier", "ชื่อSupplier"};
                        break;
                    case "vd_ticketbuy_fuel":
                        strFillName = new String[]{"เลขที่ใบชั่ง", "วันที่", "สินค้า"};
                        break;
                }
                break;
            case 222:
                switch (inputdatabase) {
                    case "vmbank":
                        strFillName = new String[]{"รหัสธนาคาร", "ชื่อธนาคาร"};
                        break;
                    case "vd_carbon_friction_burn_detail":
                        strFillName = new String[]{"เลขที่เอกสาร", "วันที่บันทึกเอกสาร", "ชนิดถ่าน", "โรงสี/โกดัง", "กองที่"};
                        break;
                    default:
                        strFillName = new String[]{"เลขที่เอกสาร", "วันที่บันทึกเอกสาร"};
                        break;
                }
                break;
            case 223:
                strFillName = new String[]{"เลขที่เอกสาร", "วันที่บันทึกเอกสาร"};
                break;
            case 224:
                strFillName = new String[]{"เลขที่เอกสาร", "วันที่บันทึกเอกสาร"};
                break;
            case 59:
                strFillName = new String[]{"ปี", "กลุ่มสินค้า", "รหัสสินค้า", "ขนาด", "Iodine", "Lot No."};
                break;

            case 62:
                strFillName = new String[]{"ปี", "กลุ่มวัตถุดิบ", "รหัสวัตถุดิบ", "ชื่อวัตถุดิบ"};
                break;

            case 591:
                if (inputdatabase.equals("vmproduct")) {
                    strFillName = new String[]{"รหัสสินค้า", "ชื่อสินค้า", "ประภทสินค้า", "Lot No."};
                    break;
                }
            case 60:
                strFillName = new String[]{"เลขที่ใบแจ้งการผลิต", "ชื่อลูกค้า", "ขนาดถ่าน"};
                break;
            case 600:
                strFillName = new String[]{"เลขที่ใบแจ้งการผลิต", "ชื่อลูกค้า", "ขนาดถ่าน"};
                break;
            case 61:
                if (inputdatabase.equals("vd_header_analyze")) {
                    strFillName = new String[]{"รหัส Parameter", "psd_1", "psd_2", "psd_3", "psd_4", "psd_5"};
                } else {
                    strFillName = new String[]{"เลขที่ใบแจ้งการผลิต", "ชื่อลูกค้า", "ขนาดถ่าน"};
                }
                break;

            case 23:
                switch (inputdatabase) {
                    case "Vemployee":
                    case "Vemployee1":
                        strFillName = new String[]{"รหัสพนักงาน", "ชื่อ", "รหัสแผนก", "ชื่อแผนก"};
                        break;
                    case "Mproduct_type":
                        strFillName = new String[]{"รหัสประเภท", "ชื่อประเภท"};
                        break;
                    default:
                        strFillName = new String[]{"รหัสคลังสินค้า", "ชื่อคลังสินค้า"};
                        break;
                }
                break;
            case 24:
                switch (inputdatabase) {
                    case "msupplier":
                        strFillName = new String[]{"รหัสsupplier", "ชื่อsupplier"};
                        break;
                    case "mdepartment":
                        strFillName = new String[]{"รหัสแผนก", "ชื่อแผนก"};
                        break;
                    case "v_rawmatt_receive_supplier":
                        strFillName = new String[]{"รหัสsupplier", "ชื่อsupplier"};
                        break;
                }
                break;
            case 25:
                if (inputdatabase.equals("Warehouse") || inputdatabase.equals("Warehouse1") || inputdatabase.equals("Warehouse2")) {
                    strFillName = new String[]{"รหัสคลังสินค้า", "ชื่อคลังสินค้า"};
                } else {
                    strFillName = new String[]{"รหัสพนักงาน", "ชื่อ", "รหัสแผนก", "ชื่อแผนก"};
                }
                break;
            case 26:
                if (inputdatabase.equals("Warehouse")) {
                    strFillName = new String[]{"รหัสคลังสินค้า", "ชื่อคลังสินค้า"};
                }
                break;
            case 27:
                if (inputdatabase.equals("m_iodine")) {
                    strFillName = new String[]{"ค่าไอโอดีน", "ค่าButane", "ประเภทถ่าน"};
                } else {
                    strFillName = new String[]{"รหัสพนักงาน", "ชื่อ", "รหัสแผนก", "ชื่อแผนก"};
                }

                break;
            case 28:
                if (inputdatabase.equals("Warehouse")) {
                    strFillName = new String[]{"รหัสคลังสินค้า", "ชื่อคลังสินค้า"};
                }
                break;
            case 29:
                if (inputdatabase.equals("Vemployee") || inputdatabase.equals("Vemployee1")) {
                    strFillName = new String[]{"รหัสพนักงาน", "ชื่อ", "รหัสแผนก", "ชื่อแผนก"};
                } else {
                    strFillName = new String[]{"รหัสสินค้า", "ชื่อสินค้า"};
                }
                break;
            case 57:
                strFillName = new String[]{"รหัสวัตถุดิบ", "ชื่อวัตถุดิบ"};
                break;
            case 32:
                switch (inputdatabase) {
                    case "Vcustomer":
                        strFillName = new String[]{"รหัสลูกค้า", "ชื่อลูกค้า"};
                        break;
                    case "Vemployee":
                    case "Vemployee1":
                    case "Vemployee2":
                    case "Vemployee3":
                        strFillName = new String[]{"รหัสพนักงาน", "ชื่อ", "รหัสแผนก", "ชื่อแผนก"};
                        break;
                    case "vd_saleorderproduct_master":
                        strFillName = new String[]{"เลขที่ใบสั่งซื้อ", "ชื่อลูกค้า", "ชื่อประเทศ"};
                        break;
                    case "vd_saleorderproduct_detail":
                        strFillName = new String[]{"เลขที่ใบสั่งซื้อ", "ชื่อลูกค้า", "รหัสสินค้า", "ขนาด"};
                        break;
                    case "m_carbon_size":
                        strFillName = new String[]{"ชื่อขนาด", "หมายเหตุ"};
                        break;
                    case "vm_carbon_size":
                        strFillName = new String[]{"รหัสขนาด", "ชื่อขนาด"};
                        break;
                    case "mmachine":
                        strFillName = new String[]{"รหัสเครื่องจักร", "ชื่อเครื่องจักร"};
                        break;
                    default:
                        strFillName = new String[]{"รหัสประเทศ", "ชื่อประเทศ", "ชื่อเมืองหลวง"};
                        break;
                }
                break;
            case 34:
                if (inputdatabase.equals("Vemployee") || inputdatabase.equals("Vemployee1") || inputdatabase.equals("Vemployee2")) {
                    strFillName = new String[]{"รหัสพนักงาน", "ชื่อ", "รหัสแผนก", "ชื่อแผนก"};
                } else {
                    strFillName = new String[]{"รหัสประเภทงาน", "ชื่อประเภทงาน"};
                }
                break;
            case 35:
                switch (inputdatabase) {
                    case "Mproduct_cat":
                    case "mproduct":
                        strFillName = new String[]{"รหัสชนิดถ่าน", "ชื่อชนิดถ่าน"};
                        break;
                    case "Vd_job_order_header":
                        strFillName = new String[]{"รหัสใบแจ้งการผลิต", "บริษัทสั่งผลิต"};
                        break;
                    case "m_carbon_size":
                        strFillName = new String[]{"ชื่อขนาด"};
                        break;
                    default:
                        strFillName = new String[]{"ชื่อเครื่องผลิต/แหล่งผลิต"};
                        break;
                }
                break;
            case 36:
                if (inputdatabase.equals("Vproduct")) {
                    strFillName = new String[]{"รหัสสินค้า", "ชื่อสินค้า"};
                } else if (inputdatabase.equals("Vd_job_order_header")) {
                    strFillName = new String[]{"รหัสใบแจ้งการผลิต", "บริษัทสั่งผลิต"};
                }
                break;
            case 207:
                strFillName = new String[]{"รหัสกองวัตถุดิบ", "ชื่อกองวัตถุดิบ"};
                break;
            case 361:
                strFillName = new String[]{"รหัสใบแจ้งการผลิต", "ลูกค้า"};
                break;
            case 37:
                switch (inputdatabase) {
                    case "Mwarehouse":
                        strFillName = new String[]{"รหัสคลังสินค้า", "ชื่อคลังสินค้า"};
                        break;
                    case "munit_code":
                        strFillName = new String[]{"รหัสหน่วยนับ", "ชื่อหน่วยนับ"};
                        break;
                }
                break;
            case 38:
                if (inputdatabase.equals("Vd_job_order_header")) {
                    strFillName = new String[]{"รหัสใบแจ้งการผลิต", "บริษัทสั่งผลิต", "วันที่บันทึกเอกสาร"};
                }
                break;
            case 39:
                if (inputdatabase.equals("Vproduct")) {
                    strFillName = new String[]{"รหัสสินค้า", "ชื่อสินค้า"};
                }
                break;
            case 40:
                switch (inputdatabase) {
                    case "Vd_job_order_header":
                        strFillName = new String[]{"รหัสใบแจ้งการผลิต", "บริษัทสั่งผลิต", "วันที่บันทึกเอกสาร"};
                        break;
                    case "Vemployee":
                    case "Vemployee1":
                        strFillName = new String[]{"รหัสพนักงาน", "ชื่อ", "รหัสแผนก", "ชื่อแผนก"};
                        break;
                }
                break;
            case 41:
                switch (inputdatabase) {
                    case "mproduction_place":
                        strFillName = new String[]{"ชื่อแหล่งผลิต"};
                        break;
                    case "Mwarehouse":
                        strFillName = new String[]{"รหัสคลังสินค้า", "ชื่อคลังสินค้า"};
                        break;
                    case "M_doc_type":
                        strFillName = new String[]{"ประเภทรายการ", "รายละเอียด"};
                        break;
                    default:
                        strFillName = new String[]{"รหัสขนาดถ่าน", "ชื่อขนาดถ่าน"};
                        break;
                }
                break;
            case 42:
                switch (inputdatabase) {
                    case "Vd_job_order_header":
                        strFillName = new String[]{"รหัสใบแจ้งการผลิต", "บริษัทสั่งผลิต", "วันที่บันทึกเอกสาร"};
                        break;
                    case "Vemployee":
                    case "Vemployee1":
                    case "Vemployee2":
                        strFillName = new String[]{"รหัสพนักงาน", "ชื่อ", "รหัสแผนก", "ชื่อแผนก"};
                        break;
                }
                break;
            case 43:
                if (inputdatabase.equals("Vproduct")) {
                    strFillName = new String[]{"รหัสสินค้า", "ชื่อสินค้า"};
                } else {
                    strFillName = new String[]{"รหัสใบแจ้งการผลิต", "บริษัทสั่งผลิต"};
                }
                break;
            case 44:
                switch (inputdatabase) {
                    case "m_carbon_size":
                        strFillName = new String[]{"ชื่อขนาดถ่าน"};
                        break;
                    case "Mwarehouse":
                        strFillName = new String[]{"รหัสคลังสินค้า", "ชื่อคลังสินค้า"};
                        break;
                }
                break;
            case 45:
                if (inputdatabase.equals("Vemployee")) {
                    strFillName = new String[]{"รหัสพนักงาน", "ชื่อ", "รหัสแผนก", "ชื่อแผนก"};
                } else {
                    strFillName = new String[]{"รหัสหน่วยนับ", "ชื่อหน่วยนับ"};
                }
                break;
            case 46:
                switch (inputdatabase) {
                    case "Vd_rawmatt_receive":
                        strFillName = new String[]{"เลขที่เอกสาร", "เลขที่ใบชั้งถ่าน", "เลขทะเบียรถ"};
                        break;
                    case "Vemployee":
                    case "Vemployee1":
                    case "Vemployee2":
                        strFillName = new String[]{"รหัสพนักงาน", "ชื่อ", "รหัสแผนก", "ชื่อแผนก"};
                        break;
                }
                break;
            case 48:
                switch (inputdatabase) {
                    case "vmprocess":
                        strFillName = new String[]{"รหัส Process", "ชื่อ Process", "คลังรับ", "คลังจ่าย"};
                        break;
                    case "mwarehouse":
                        strFillName = new String[]{"รหัสคลัง", "ชื่อคลัง"};
                        break;
                    default:
                        strFillName = new String[]{"เลขที่เอกสาร", "วันที่บันทึกเอกสาร"};
                        break;
                }
                break;
            case 482:
                switch (inputdatabase) {
                    case "vmprocess":
                        strFillName = new String[]{"รหัส Process", "ชื่อ Process", "คลังรับ", "คลังจ่าย"};
                        break;
                    case "mwarehouse":
                        strFillName = new String[]{"รหัสคลัง", "ชื่อคลัง"};
                        break;
                    default:
                        strFillName = new String[]{"เลขที่เอกสาร", "วันที่บันทึกเอกสาร", "ยืนยันเอกสาร"};
                        break;
                }
                break;
            case 49:
                if (inputdatabase.equals("vd_carbon_burn_out_header_wh")) {
                    strFillName = new String[]{"เลขที่เอกสาร", "วันที่"};
                }
                break;
            case 101:
                if (inputdatabase.equals("Vd_rawmatt_receive")) {
                    strFillName = new String[]{"เลขที่เอกสาร", "วันที่"};
                }
                break;
            case 100:
                if (inputdatabase.equals("Vd_rawmatt_receive")) {
                    strFillName = new String[]{"เลขที่เอกสาร", "วันที่"};
                }
                break;
            case 312:
                if (inputdatabase.equals("vmessage")) {
                    strFillName = new String[]{"รหัสข้อความ", "ข้อความ"};
                } else {
                    strFillName = new String[]{"รหัสวิเคราะห์", "ชื่อผู้ขาย", "ประเมินรอบที่", "ปี"};
                }
                break;
            case 313:
                if (inputdatabase.equals("Vemployee") || inputdatabase.equals("Vemployee1") || inputdatabase.equals("Vemployee2") || inputdatabase.equals("Vemployee3") || inputdatabase.equals("Vemployee4")) {
                    strFillName = new String[]{"รหัสพนักงาน", "ชื่อ", "รหัสแผนก", "ชื่อแผนก"};
                }
                break;
            case 314:
                if (inputdatabase.equals("Vemployee") || inputdatabase.equals("Vemployee1") || inputdatabase.equals("Vemployee2") || inputdatabase.equals("Vemployee3")) {
                    strFillName = new String[]{"รหัสพนักงาน", "ชื่อ", "รหัสแผนก", "ชื่อแผนก"};
                }
                break;

            case 315:
                if (inputdatabase.equals("Vemployee") || inputdatabase.equals("Vemployee1") || inputdatabase.equals("Vemployee2") || inputdatabase.equals("Vemployee3")) {
                    strFillName = new String[]{"รหัสพนักงาน", "ชื่อ", "รหัสแผนก", "ชื่อแผนก"};
                }
                break;

            case 3:
                if (inputdatabase.equals("Lookup")) {
                    strFillName = new String[]{"Lookup name", "Remark"};
                }
                break;
            default:
                break;
        }
        // JOptionPane.showConfirmDialog(null, strFillName);
        //System.out.println("strFillName = " + strFillName);
        return strFillName;

    }

    public String[] SelectColoumShow(int inputpage, String inputdatabase)//function แสดงข้อมูลใน Table(HTML)
    {

        switch (inputpage) {
            case 0:
                switch (inputdatabase) {
                    case "m_iodine":
                    case "m_iodine_product":
                        strColoumShow = new String[]{"iod_range", "iod_code"};
                        break;
                    case "vd_job_order_header":
                        strColoumShow = new String[]{"doc_id", "cust_name", "size_name"};
                        break;
                    case "mproduct_cat":
                        strColoumShow = new String[]{"pcat_id", "name_t"};
                        break;
                    case "vmrawmat":
                        strColoumShow = new String[]{"product_id", "name_t"};
                        break;
                    case "m_carbon_size":
                        strColoumShow = new String[]{"name_t", "name_t"};
                        break;
                    case "mmachine":
                        strColoumShow = new String[]{"name_t", "machine_id"};
                        break;
                    case "mwarehouse":
                        strColoumShow = new String[]{"warehouse_id", "name_t"};
                        break;
                    case "vmproduct":
                        strColoumShow = new String[]{"product_id", "name_t"};
                        break;
                    case "vd_header_analyze":
                        strColoumShow = new String[]{"doc_id", "psd_1", "psd_2", "psd_3", "psd_4", "psd_5"};
                        break;
                    case "mjob_type_detail":
                        strColoumShow = new String[]{"job_type_desc"};
                        break;
                }
                break;
            case 289:
                if (inputdatabase.equals("vm_friction_house")) {
                    strColoumShow = new String[]{"friction_house"};
                } else {
                    strColoumShow = new String[]{"location_id", "name_t"};
                }
                break;
            case 290:
                strColoumShow = new String[]{"location_id", "name_t"};
                break;
            case 291:
                strColoumShow = new String[]{"location_id", "name_t"};
                break;
            case 292:
                strColoumShow = new String[]{"location_id"};
                break;
            case 293:
                strColoumShow = new String[]{"ticket_text", "truck_no", "cred_name", "date_in", "time_in", "remark"};
                break;
            case 109:
                strColoumShow = new String[]{"doc_id", "cust_name"};
                break;
            case 204:
                switch (inputdatabase) {
                    case "mjob_type":
                        strColoumShow = new String[]{"job_type_id", "name_t"};
                        break;
                    case "mjob_type_detail":
                        strColoumShow = new String[]{"job_type_id", "job_type_desc"};
                        break;
                    default:
                        strColoumShow = new String[]{"export_id", "name_t"};
                        break;
                }
                break;
            case 205:
                strColoumShow = new String[]{"iod_code", "iod_range", "butane"};
                break;
            case 206:
                if (inputdatabase.equals("mjob_type")) {
                    strColoumShow = new String[]{"job_type_id", "name_t"};
                }
                break;
            case 53:
                if (inputdatabase.equals("mdata_export")) {
                    strColoumShow = new String[]{"export_id", "name_t"};
                } else if (inputdatabase.indexOf("d_") != -1) {
                    strColoumShow = new String[]{"doc_id", "runno"};
                }
                break;
            case 116:
                strColoumShow = new String[]{"product_id", "name_t", "pcat_name"};
                break;
            case 30:
                if (inputdatabase.equals("m_carbon_size")) {
                    strColoumShow = new String[]{"name_t"};
                }
                break;
            case 301:
                if (inputdatabase.equals("mwarehouse")) {
                    strColoumShow = new String[]{"warehouse_id", "name_t"};
                } else {
                    strColoumShow = new String[]{"product_id", "name_t", "ptype_name"};
                }
                break;

            case 302:
                if (inputdatabase.equals("Vproduct")) {
                    strColoumShow = new String[]{"product_id", "name_t", "ptype_name"};
                }
                break;

            case 13:
                strColoumShow = new String[]{"dept_id", "name_t"};
                break;
            case 14:
                if (inputdatabase.equals("vemployee_fullname")) {
                    strColoumShow = new String[]{"emp_id", "fullname"};
                } else {
                    strColoumShow = new String[]{"dept_id", "name_t"};
                }
                break;

            case 147:
                if (inputdatabase.equals("vemployee_fullname")) {
                    strColoumShow = new String[]{"emp_id", "fullname"};
                }
                break;

            case 15:
                switch (inputdatabase) {
                    case "mcountry":
                        strColoumShow = new String[]{"country_code", "name_t"};
                        break;
                    case "mtambol":
                        strColoumShow = new String[]{"tambol_code", "name_t"};
                        break;
                    case "mamphor":
                        strColoumShow = new String[]{"amp_code", "name_t"};
                        break;
                    case "mprovince":
                        strColoumShow = new String[]{"prov_code", "name_t"};
                        break;
                    default:
                        strColoumShow = new String[]{"customer_id", "name_t"};
                        break;
                }
                break;

            case 16:
                switch (inputdatabase) {
                    case "mtambol":
                        strColoumShow = new String[]{"tambol_code", "name_t"};
                        break;
                    case "mamphor":
                        strColoumShow = new String[]{"amp_code", "name_t"};
                        break;
                    case "mprovince":
                        strColoumShow = new String[]{"prov_code", "name_t"};
                        break;
                    case "mbranch":
                        strColoumShow = new String[]{"branch_id", "name_t"};
                        break;
                    case "mcredit":
                        strColoumShow = new String[]{"cred_code", "cred_name"};
                        break;
                    default:
                        strColoumShow = new String[]{"supplier_id", "name_t"};
                        break;
                }
                break;
            case 17:
                strColoumShow = new String[]{"pgroup_id", "name_t"};
                break;
            case 18:
                strColoumShow = new String[]{"pcat_id", "name_t"};
                break;
            case 19:
                strColoumShow = new String[]{"ptype_id", "name_t"};
                break;
            case 20:
                strColoumShow = new String[]{"warehouse_id", "name_t"};
                break;
            case 21:
                switch (inputdatabase) {
                    case "vproduct":
                    case "vmproduct":
                        strColoumShow = new String[]{"product_id", "name_t", "ptype_name"};
                        break;
                    case "mproduct_group":
                        strColoumShow = new String[]{"pgroup_id", "name_t"};
                        break;
                    case "mproduct_cat":
                        strColoumShow = new String[]{"pcat_id", "name_t"};
                        break;
                    case "mproduct_type":
                        strColoumShow = new String[]{"ptype_id", "name_t"};
                        break;
                    case "munit_code":
                        strColoumShow = new String[]{"unit_id", "name_t"};
                        break;
                    default:
                        strColoumShow = new String[]{"size_id", "name_t"};
                        break;
                }
                break;
            case 114:
                strColoumShow = new String[]{"doc_id", "doc_date"};
                break;
            case 103:
                if (inputdatabase.equals("mdepartment")) {
                    strColoumShow = new String[]{"dept_id", "name_t"};
                } else {
                    strColoumShow = new String[]{"emp_id", "fullname", "dept_id", "depart_name"};
                }
                break;
            case 105:
                strColoumShow = new String[]{"emp_id", "fullname", "dept_id", "depart_name"};
                break;
            case 106:
                strColoumShow = new String[]{"doc_id", "cust_name", "doc_date"};
                break;
            case 108:
                switch (inputdatabase) {
                    case "Vd_job_order_header":
                        strColoumShow = new String[]{"doc_id", "cust_name", "doc_date"};
                        break;
                    case "Mproduct_cat":
                        strColoumShow = new String[]{"pcat_id", "name_t"};
                        break;
                    case "m_carbon_size":
                        strColoumShow = new String[]{"name_t"};
                        break;
                }
                break;
            case 112:
                switch (inputdatabase) {
                    case "Vd_job_order_header":
                        strColoumShow = new String[]{"doc_id", "cust_name", "doc_date"};
                        break;
                    case "Vproduct":
                        strColoumShow = new String[]{"product_id", "name_t"};
                        break;
                }
                break;
            case 51:
                if (inputdatabase.equals("vd_product_receive_header_wh")) {
                    strColoumShow = new String[]{"doc_id", "doc_date", "job_id", "cust_name"};
                }
                break;
            case 31:
                strColoumShow = new String[]{"product_id", "name_t"};
                break;
            case 50:
                if (inputdatabase.equals("d_carbon_withdraw_header_wh")) {
                    strColoumShow = new String[]{"doc_id", "doc_date"};
                }
                break;
            case 22:
                switch (inputdatabase) {
                    case "Vsupplier":
                        strColoumShow = new String[]{"supplier_id", "name_t", "price_unit", "scale_no"};
                        break;
                    case "Vproduct":
                        strColoumShow = new String[]{"product_id", "name_t"};
                        break;
                    case "Vd_rawmatt_receive":
                        strColoumShow = new String[]{"doc_id", "doc_date", "supplier_name", "net_weight_ch", "price_flag", "scale_no"};
                        break;
                    case "Vd_fuel_receive":
                        strColoumShow = new String[]{"doc_id", "doc_date", "supplier_name", "scale_no"};
                        break;
                    case "vmrawmat":
                        strColoumShow = new String[]{"product_id", "name_t"};
                        break;
                    default:
                        strColoumShow = new String[]{"warehouse_id", "name_t"};
                        break;
                }
                break;
            case 221:
                if (inputdatabase.equals("Vsupplier")) {
                    strColoumShow = new String[]{"supplier_id", "name_t"};
                } else if (inputdatabase.equals("vd_ticketbuy_fuel")) {
                    strColoumShow = new String[]{"ticket_text", "doc_date", "prod_name"};
                }
                break;
            case 222:
                if (inputdatabase.equals("vmbank")) {
                    strColoumShow = new String[]{"bank_id", "name_t"};
                } else if (inputdatabase.equals("vd_carbon_friction_burn_detail")) {
                    strColoumShow = new String[]{"doc_id", "doc_date", "product_id", "wh_id", "location_id"};
                } else {
                    strColoumShow = new String[]{"doc_id", "doc_date"};
                }
                break;
            case 223:
                strColoumShow = new String[]{"doc_id", "doc_date"};
                break;
            case 224:
                strColoumShow = new String[]{"doc_id", "doc_date"};
                break;
            case 59:
                strColoumShow = new String[]{"price_year", "pgroup_id", "product_id", "size_name", "iodine", "lot_no"};
                break;
            case 62:
                strColoumShow = new String[]{"price_year", "pgroup_id", "product_id", "name_t"};
                break;

            case 591:
                strColoumShow = new String[]{"product_id", "name_t", "pgroup_id", "lot_no"};
                break;
            case 60:
                strColoumShow = new String[]{"doc_id", "cust_name", "size_name"};
                break;
            case 600:
                strColoumShow = new String[]{"doc_id", "cust_name", "size_name"};
                break;
            case 61:
                if (inputdatabase.equals("vd_header_analyze")) {
                    strColoumShow = new String[]{"doc_id", "psd_1", "psd_2", "psd_3", "psd_4", "psd_5"};
                } else {
                    strColoumShow = new String[]{"doc_id", "cust_name", "size_name"};
                }
                break;
            case 23:
                switch (inputdatabase) {
                    case "Vemployee":
                    case "Vemployee1":
                        strColoumShow = new String[]{"emp_id", "fullname", "dept_id", "depart_name"};
                        break;
                    case "Mproduct_type":
                        strColoumShow = new String[]{"ptype_id", "name_t"};
                        break;
                    default:
                        strColoumShow = new String[]{"warehouse_id", "name_t"};
                        break;
                }
                break;
            case 24:
                switch (inputdatabase) {
                    case "msupplier":
                        strColoumShow = new String[]{"supplier_id", "name_t"};
                        break;
                    case "mdepartment":
                        strColoumShow = new String[]{"dept_id", "name_t"};
                        break;
                    case "v_rawmatt_receive_supplier":
                        strColoumShow = new String[]{"supplier_id", "supplier_name"};
                        break;
                }
                break;
            case 25:
                if (inputdatabase.equals("Warehouse") || inputdatabase.equals("Warehouse1") || inputdatabase.equals("Warehouse2")) {
                    strColoumShow = new String[]{"warehouse_id", "name_t"};
                } else {
                    strColoumShow = new String[]{"emp_id", "fullname", "dept_id", "depart_name"};
                }
                break;
            case 26:
                if (inputdatabase.equals("Warehouse")) {
                    strColoumShow = new String[]{"warehouse_id", "name_t"};
                }
                break;
            case 27:
                if (inputdatabase.equals("m_iodine")) {
                    strColoumShow = new String[]{"iod_range", "butane", "iod_ctype"};
                } else {
                    strColoumShow = new String[]{"emp_id", "fullname", "dept_id", "depart_name"};
                }
                break;
            case 28:
                if (inputdatabase.equals("Warehouse")) {
                    strColoumShow = new String[]{"warehouse_id", "name_t"};
                }
                break;
            case 29:
                if (inputdatabase.equals("Vemployee") || inputdatabase.equals("Vemployee1")) {
                    strColoumShow = new String[]{"emp_id", "fullname", "dept_id", "depart_name"};
                } else {
                    strColoumShow = new String[]{"product_id", "name_t"};
                }
                break;
            case 57:
                strColoumShow = new String[]{"product_id", "name_t"};
                break;
            case 32:
                switch (inputdatabase) {
                    case "Vcustomer":
                        strColoumShow = new String[]{"customer_id", "name_t"};
                        break;
                    case "Vemployee":
                    case "Vemployee1":
                    case "Vemployee2":
                    case "Vemployee3":
                        strColoumShow = new String[]{"emp_id", "fullname", "dept_id", "depart_name"};
                        break;
                    case "vd_saleorderproduct_master":
                        strColoumShow = new String[]{"doc_id", "customer_name", "country_name"};
                        break;
                    case "vd_saleorderproduct_detail":
                        //strColoumShow = new String[]{"doc_id", "customer_name", "product_id", "size_name"};
                        strColoumShow = new String[]{"doc_id"};
                        break;
                    case "m_carbon_size":
                        strColoumShow = new String[]{"name_t", "remark"};
                        break;
                    case "vm_carbon_size":
                        strColoumShow = new String[]{"m_size_id", "name_t"};
                        break;
                    case "mmachine":
                        strColoumShow = new String[]{"machine_id", "name_t"};
                        break;
                    default:
                        strColoumShow = new String[]{"country_code", "name_t", "capital_t"};
                        break;
                }
                break;
            case 34:
                if (inputdatabase.equals("Vemployee") || inputdatabase.equals("Vemployee1") || inputdatabase.equals("Vemployee2")) {
                    strColoumShow = new String[]{"emp_id", "fullname", "dept_id", "depart_name"};
                } else {
                    strColoumShow = new String[]{"job_type_id", "name_t"};
                }
                break;
            case 35:
                switch (inputdatabase) {
                    case "Mproduct_cat":
                        strColoumShow = new String[]{"pcat_id", "name_t"};
                        break;
                    case "Vd_job_order_header":
                        strColoumShow = new String[]{"doc_id", "cust_name"};
                        break;
                    case "m_carbon_size":
                        strColoumShow = new String[]{"name_t"};
                        break;
                    case "mproduct":
                        strColoumShow = new String[]{"product_id", "name_t"};
                        break;
                    default:
                        strColoumShow = new String[]{"name_t"};
                        break;
                }
                break;
            case 36:
                switch (inputdatabase) {
                    case "Vproduct":
                        strColoumShow = new String[]{"product_id", "name_t"};
                        break;
                    case "Vd_job_order_header":
                        strColoumShow = new String[]{"doc_id", "cust_name"};
                        break;
                }
                break;

            case 207:
                strColoumShow = new String[]{"location_id", "name_t"};
                break;

            case 361:
                strColoumShow = new String[]{"doc_id", "cust_name"};
                break;

            case 37:
                switch (inputdatabase) {
                    case "Mwarehouse":
                        strColoumShow = new String[]{"warehouse_id", "name_t"};
                        break;
                    case "munit_code":
                        strColoumShow = new String[]{"unit_id", "name_t"};
                        break;
                }
                break;
            case 38:
                if (inputdatabase.equals("Vd_job_order_header")) {
                    strColoumShow = new String[]{"doc_id", "cust_name", "doc_date"};
                }
                break;
            case 39:
                if (inputdatabase.equals("Vproduct")) {
                    strColoumShow = new String[]{"product_id", "name_t"};
                }
                break;
            case 40:
                switch (inputdatabase) {
                    case "Vd_job_order_header":
                        strColoumShow = new String[]{"doc_id", "cust_name", "doc_date"};
                        break;
                    case "Vemployee":
                    case "Vemployee1":
                        strColoumShow = new String[]{"emp_id", "fullname", "dept_id", "depart_name"};
                        break;
                }
                break;
            case 41:
                switch (inputdatabase) {
                    case "mproduction_place":
                        strColoumShow = new String[]{"name_t"};
                        break;
                    case "Mwarehouse":
                        strColoumShow = new String[]{"warehouse_id", "name_t"};
                        break;
                    case "M_doc_type":
                        strColoumShow = new String[]{"doc_type", "name_t"};
                        break;
                    default:
                        strColoumShow = new String[]{"size_id", "name_t"};
                        break;
                }
                break;
            case 42:
                switch (inputdatabase) {
                    case "Vd_job_order_header":
                        strColoumShow = new String[]{"doc_id", "cust_name", "doc_date"};
                        break;
                    case "Vemployee":
                    case "Vemployee1":
                    case "Vemployee2":
                        strColoumShow = new String[]{"emp_id", "fullname", "dept_id", "depart_name"};
                        break;
                }
                break;
            case 43:
                if (inputdatabase.equals("Vproduct")) {
                    strColoumShow = new String[]{"product_id", "name_t"};
                } else {
                    strColoumShow = new String[]{"doc_id", "cust_name"};
                }
                break;
            case 44:
                switch (inputdatabase) {
                    case "m_carbon_size":
                        strColoumShow = new String[]{"name_t"};
                        break;
                    case "Mwarehouse":
                        strColoumShow = new String[]{"warehouse_id", "name_t"};
                        break;
                }
                break;
            case 45:
                if (inputdatabase.equals("Vemployee")) {
                    strColoumShow = new String[]{"emp_id", "fullname", "dept_id", "depart_name"};
                } else {
                    strColoumShow = new String[]{"unit_id", "name_t"};
                }
                break;
            case 46:
                if (inputdatabase.equals("Vd_rawmatt_receive")) {
                    strColoumShow = new String[]{"doc_id", "scale_no", "car_no"};
                }
                if (inputdatabase.equals("Vemployee") || inputdatabase.equals("Vemployee1") || inputdatabase.equals("Vemployee2")) {
                    strColoumShow = new String[]{"emp_id", "fullname", "dept_id", "depart_name"};
                }
                break;

            case 48:
                switch (inputdatabase) {
                    case "vmprocess":
                        strColoumShow = new String[]{"process_id", "name_t", "wh_bg_name", "wh_en_name"};
                        break;
                    case "mwarehouse":
                        strColoumShow = new String[]{"warehouse_id", "name_t"};
                        break;
                    default:
                        strColoumShow = new String[]{"doc_id", "doc_date"};
                        break;
                }
                break;
            case 482:
                switch (inputdatabase) {
                    case "vmprocess":
                        strColoumShow = new String[]{"process_id", "name_t", "wh_bg_name", "wh_en_name"};
                        break;
                    case "mwarehouse":
                        strColoumShow = new String[]{"warehouse_id", "name_t"};
                        break;
                    default:
                        strColoumShow = new String[]{"doc_id", "doc_date", "complete_flag"};
                        break;
                }
                break;
            case 49:
                if (inputdatabase.equals("vd_carbon_burn_out_header_wh")) {
                    strColoumShow = new String[]{"doc_id", "doc_date"};
                }
                break;
            case 101:
                if (inputdatabase.equals("Vd_rawmatt_receive")) {
                    strColoumShow = new String[]{"doc_id", "doc_date"};
                }
                break;
            case 100:
                if (inputdatabase.equals("Vd_rawmatt_receive")) {
                    strColoumShow = new String[]{"doc_id", "doc_date"};
                }
                break;

            case 312:
                if (inputdatabase.equals("vmessage")) {
                    strColoumShow = new String[]{"message_id", "message_detail", "status"};
                } else {
                    strColoumShow = new String[]{"doc_id", "supplier_name", "rate_text", "year_text"};
                }
                break;
            case 313:
                if (inputdatabase.equals("Vemployee") || inputdatabase.equals("Vemployee1") || inputdatabase.equals("Vemployee2") || inputdatabase.equals("Vemployee3") || inputdatabase.equals("Vemployee4")) {
                    strColoumShow = new String[]{"emp_id", "fullname", "dept_id", "depart_name"};
                }
                break;
            case 314:
                if (inputdatabase.equals("Vemployee") || inputdatabase.equals("Vemployee1") || inputdatabase.equals("Vemployee2") || inputdatabase.equals("Vemployee3")) {
                    strColoumShow = new String[]{"emp_id", "fullname", "dept_id", "depart_name"};
                }
                break;
            case 315:
                if (inputdatabase.equals("Vemployee") || inputdatabase.equals("Vemployee1") || inputdatabase.equals("Vemployee2") || inputdatabase.equals("Vemployee3")) {
                    strColoumShow = new String[]{"emp_id", "fullname", "dept_id", "depart_name"};
                }
                break;
            case 3:
                if (inputdatabase.equals("Lookup")) {
                    strColoumShow = new String[]{"lookup_name", "table_name"};
                }
                break;
            default:
                break;
        }
        //JOptionPane.showConfirmDialog(null, strColoumShow);
        //System.out.println("strColoumShow = " + strColoumShow);
        return strColoumShow;
    }
}
