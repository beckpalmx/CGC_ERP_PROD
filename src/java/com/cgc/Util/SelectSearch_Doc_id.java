/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.Util;

/**
 *
 * @author Beckpalmx No7
 */
public class SelectSearch_Doc_id {

    private String strURLShow;
    private String[] strColoum, strColoumShow, strFillName;
    private String strID;

    public String[] SelectColoum(int inputpage, String inputdatabase) //function จะ Return ค่าของข้อมูลที่จะนำออกไปแสดงข้อมูล
    {
        switch (inputpage) {

            case 14:
                if (inputdatabase.equals("vemployee_fullname")) {
                    strColoum = new String[]{"emp_id", "fname", "lname", "dept_id", "depart_name", "status", "image_url", "remark"};
                }
                break;

            case 23:
                if (inputdatabase.equals(
                        "vd_rawmatt_bigbag_withdraw_header")) {
                    strColoum = new String[]{"doc_id", "doc_date", "doc_date", "doc_time", "wh_in", "wh_out", "runner_id", "runner_name", "p_type", "remark", "wh_in_name", "wh_out_name", "rawmat_emp", "rawmat_emp_name"};
                } else {
                    strColoum = new String[]{"doc_id", "doc_date", "doc_date", "doc_time", "wh_in", "wh_out", "runner_id", "runner_name", "p_type", "remark", "wh_in_name", "wh_out_name"};
                }

                break;
            case 25:
                if (inputdatabase.equals(
                        "vd_carbon_friction_header")) {
                    strColoum = new String[]{"doc_id", "doc_date", "doc_time", "shift", "report_id", "remark", "sum_up_silo", "sum_to_jumbo", "report_name", "complete_flag"};
                } else {
                    strColoum = new String[]{"doc_id", "doc_date", "time_from", "time_to", "runner_id", "runner_name", "shift", "wh_in", "wh_out", "loc_total", "loc_1", "s_bag_loc1", "q_bag_loc1", "w_bag_loc1", "loc_1_desc", "loc_2", "s_bag_loc2", "q_bag_loc2", "w_bag_loc2", "loc_2_desc", "loc_3", "s_bag_loc3", "q_bag_loc3", "w_bag_loc3", "loc_3_desc", "c_weight1", "c_weight2", "c_weight3", "c_weight4", "c_weight5", "p_weight1", "p_weight2", "p_weight3", "p_weight4", "p_weight5", "u_weight1", "u_weight2", "u_weight3", "u_weight4", "u_weight5", "remark", "wh_in_name", "wh_out_name", "c_weight6", "p_weight6", "u_weight6", "loc_c1", "loc_c2", "loc_c3", "loc_c4", "loc_c5", "loc_c6", "loc_p1", "loc_p2", "loc_p3", "loc_p4", "loc_p5", "loc_p6", "loc_u1", "loc_u2", "loc_u3", "loc_u4", "loc_u5", "loc_u6", "c_bag_qty", "c_bag_weight", "p_bag_qty", "p_bag_weight", "u_bag_qty", "u_bag_weight", "c_bag_qty1", "c_bag_weight1", "p_bag_qty1", "p_bag_weight1", "u_bag_qty1", "u_bag_weight1"};
                }

                break;

            case 22:
                switch (inputdatabase) {
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
                    case "vd_carbon_friction_burn_detail":
                        System.out.println("inputdatabase = " + inputdatabase);
                        strColoum = new String[]{"doc_id", "doc_date", "product_id", "weight_carbon_in", "weight_carbon_friction",
                            "weight_carbon_dust", "weight_carbon_iron", "weight_carbon_total", "weight_carbon_bigbag",
                            "weight_carbon_burn_in", "weight_carbon_real_lost", "percent_carbon_real_lost",
                            "weight_carbon_lost", "percent_carbon_lost", "burn_no", "channel", "wh_id", "location_id",
                            "remark", "percent_moisture", "rawmat_emp_id", "product_emp_id", "complete_flag"};
                        System.out.println("strColoum = " + strColoum);
                        break;
                }

                break;

            case 27:
                if (inputdatabase.equals(
                        "vd_carbon_burn_in_header")) {
                    strColoum = new String[]{"doc_id", "doc_date", "doc_date", "time_to", "time_from", "runner_id", "runner_name", "shift", "burn_no", "wh_in", "wh_out", "total_weight", "total_weight", "tank_qty", "operate_id", "wh_in_name", "wh_out_name", "operate_name", "remark", "bu", "iod", "complete_flag"};
                } else {
                    strColoum = new String[]{"doc_id", "doc_date", "doc_date", "time_to", "time_from", "runner_id", "runner_name", "shift", "burn_no", "wh_in", "wh_out", "total_weight", "total_weight", "tank_qty", "operate_id", "wh_in_name", "wh_out_name", "operate_name", "remark", "bu", "iod", "doc_type"};
                }

                break;

            case 28:
                if (inputdatabase.equals(
                        "vd_carbon_send_product_header") || inputdatabase.equals("vd_carbon_send_product_header_analyze")) {
                    strColoum = new String[]{"doc_id", "doc_date", "send_doc_time", "receive_doc_time", "product_leader_id", "product_leader_name", "lab_leader_id", "lab_leader_name", "warehouse_emp_id", "warehouse_emp_name", "warehouse_leader_id", "warehouse_leader_name", "product_confirm", "quality_confirm", "wh_emp_confirm", "wh_leader_confirm", "job_type", "complete_flag"};
                } else if (inputdatabase.equals(
                        "vd_carbon_analysis_all_header")) {
                    strColoum = new String[]{"doc_id", "doc_date", "lab_leader_id", "lab_leader_name", "quality_confirm", "job_type", "send_doc_time", "lab_emp_id", "h_lab_emp_name"};
                }
                break;

            case 29:
                strColoum = new String[]{"doc_id", "doc_date", "work_date", "time_from", "time_to", "runner_id", "full_name", "shift", "wh_in", "wh_out", "burn_no", "product_id", "ch_from", "ch_to", "weight_split", "burn_out_date", "total_weight", "total_weight", "lost_weight", "lost_weight", "wh_in_name", "wh_out_name", "report_id", "report_full_name", "complete_flag"};
                break;
            case 31:
                strColoum = new String[]{"doc_id", "doc_date"};
                break;
            case 32:
                strColoum = new String[]{"doc_id", "doc_date", "cust_id", "cust_name", "po_no", "contain_date", "iso_no", "country", "country_name", "lot_no", "mark_sign", "base_plate", "base_plate_desc", "base_plate_qty", "detail", "approve", "approve_name", "mark_sign_desc", "quality_dep", "quality_dep_name", "prod_dep", "prod_dep_name", "wh_dep", "wh_dep_name", "sale_confirm", "quality_confirm", "prod_confirm", "wh_confirm", "i2", "deadline", "stock_prod", "complete_flag"};
                break;
            case 34:
                strColoum = new String[]{"doc_id", "doc_date", "doc_time", "work_type", "wh_in", "wh_out", "prd_emp_id", "prd_emp_name", "wh_emp_id", "wh_emp_name", "wh_sup_id", "wh_sup_name", "wh_in_name", "wh_out_name", "work_type_id", "complete_flag"};

                break;
            case 36:
                if (inputdatabase.equals(
                        "vd_product_receive_header")) {
                    strColoum = new String[]{"doc_id", "job_id", "doc_date", "product_id", "size", "ctc_i2", "inc_bal", "palate_no", "wh_in", "wh_out", "cust_name", "mashed_machine_chk", "pan_chk", "roast_chk", "mag_chk", "pill_flat_chk", "roast_edit_chk", "wash_chk", "ball_mill_chk", "job_edit_chk", "mashed_machine", "pan", "ball_mill", "pill_flat", "mag", "job_edit", "wash", "roast", "roast_edit", "wh_in_name", "wh_out_name", "remark", "doc_type_job_id", "process_order"};
                } else {
                    strColoum = new String[]{"doc_id", "doc_date", "job_id", "product_id", "size", "ctc_i2", "inc_bal", "palate_no", "wh_in", "wh_out", "cust_name", "mashed_machine_chk", "pan_chk", "roast_chk", "mag_chk", "pill_flat_chk", "roast_edit_chk", "wash_chk", "ball_mill_chk", "job_edit_chk", "mashed_machine", "pan", "ball_mill", "pill_flat", "mag", "job_edit", "wash", "roast", "roast_edit", "wh_in_name", "wh_out_name", "remark", "doc_type_job_id", "doc_type"};
                }
                break;
            case 38:
                strColoum = new String[]{"doc_id", "doc_date", "job_id", "cust_name", "weight", "bag", "carbon_pack", "place_pack", "i2", "wh_in", "wh_out"};
                break;
            case 40:
                strColoum = new String[]{"doc_id", "doc_date", "job_id", "time_from", "time_to", "emp_id", "emp_name", "shift", "wh_in", "wh_out", "lost_weight", "tot_1", "tot_1", "tot_2", "tot_2", "tot_3", "tot_3", "tot_4", "tot_4", "job_cust_name", "runner_id", "runner_name", "wh_in_name", "wh_out_name", "sum_pack_month", "sum_pack_year", "total_withdraw_over", "total_bag_withdraw_over"};
                break;
            case 41:
                strColoum = new String[]{"doc_id", "doc_date", "job_id", "time_from", "time_to", "emp_id", "emp_name", "shift", "wh_in", "wh_out", "lost_weight", "tot_1", "tot_1", "tot_2", "tot_2", "tot_3", "tot_3", "tot_4", "tot_4", "job_cust_name", "runner_id", "runner_name", "wh_in_name", "wh_out_name", "sum_pack_month", "sum_pack_year", "total_withdraw_over", "total_bag_withdraw_over"};
                break;
            case 42:
                strColoum = new String[]{"doc_id", "doc_date", "prd_no", "cust_id", "cust_name", "cust_addr", "country_name", "po_no", "item_id", "wh_in", "wh_out", "contain_no", "contain_type", "seal_no", "palate_type", "approver", "approve_name", "payment_prod", "payment_name", "receiver", "receiver_name", "car_no", "net_weight", "net_weight", "wh_in_name", "wh_out_name"};
                break;
            case 46:
                strColoum = new String[]{"doc_id", "doc_date", "car_no", "sender_id", "c_type", "report_name", "approve_name", "sender_full_name", "report_full_name", "approve_full_name", "car_date_in", "approve_status", "moisture_average", "record_detail"};
                break;
            case 103:
                strColoum = new String[]{"doc_id", "doc_date", "doc_time", "bu_id", "sending_id", "remark", "bu_name", "send_name"};
                break;
            case 105:
                strColoum = new String[]{"doc_id", "doc_date", "shift", "reporter_id", "checker_id", "hc1", "hc2", "hc3", "hc4", "hc5", "hc6", "hc7", "hc8", "hc9", "hc10", "hc11", "hc12", "hc13", "hc14", "hc15", "reporter_full_name", "checker_full_name", "doc_time", "approve_status"};
                break;
            case 106:
                strColoum = new String[]{"doc_id", "doc_date", "doc_time", "shift", "prd_no", "cust_id", "quantity", "size", "hc1", "hc2", "hc3", "hc4", "hc5", "hc6", "hc7", "hc8", "hc9", "hc10", "hc11", "hc12", "hc13", "hc14", "hc15", "cust_name"};
                break;
            case 112:
                strColoum = new String[]{"doc_id", "stuffing_date", "job_no", "cust_id", "product_id", "weight", "hc1", "hc2", "hc3", "hc4", "hc5", "hc6", "hc7", "hc8", "hc9", "hc10", "hc11", "hc12", "hc13", "hc14", "hc15", "cust_name", "product_name"};
                break;
            case 115:
                switch (inputdatabase) {
                    case "vd_ticketbuy_doc_not_cgc":
                        strColoum = new String[]{"doc_id", "doc_date", "doc_time", "complete_flag"};
                        break;
                    case "d_adjust_product_header":
                        strColoum = new String[]{"doc_id", "doc_date", "doc_time", "doc_type", "remark", "total_weight_adjust", "complete_flag"};
                        break;
                    default:
                        strColoum = new String[]{"doc_id", "doc_date", "doc_time", "doc_type", "remark", "total_weight_adjust", "complete_flag"};
                        break;
                }
                break;
            case 300:
                strColoum = new String[]{"doc_id", "doc_date", "work_date", "time_from", "time_to", "runner_id", "full_name", "shift", "wh_in", "wh_out", "burn_no", "product_id", "ch_from", "ch_to", "weight_split", "burn_out_date", "total_weight", "total_weight", "lost_weight", "lost_weight", "wh_in_name", "wh_out_name", "report_id", "report_full_name", "doc_type"};
                break;
            case 302:
                strColoum = new String[]{"doc_id", "doc_date", "doc_time", "work_type", "wh_in", "wh_out", "prd_emp_id", "prd_emp_name", "wh_emp_id", "wh_emp_name", "wh_sup_id", "wh_sup_name", "wh_in_name", "wh_out_name", "doc_type"};
                break;
            case 304:
                strColoum = new String[]{"doc_id", "doc_date", "doc_time", "bu_id", "sending_id", "remark", "bu_name", "send_name", "wh_emp_id", "wh_emp_name", "doc_type"};
                break;
            case 306:
                strColoum = new String[]{"doc_id", "doc_date", "job_id", "time_from", "time_to", "emp_id", "emp_name", "shift", "wh_in", "wh_out", "lost_weight", "tot_1", "tot_1", "tot_2", "tot_2", "tot_3", "tot_3", "tot_4", "tot_4", "job_cust_name", "runner_id", "runner_name", "wh_in_name", "wh_out_name", "total_bag_withdraw_wh", "total_weight_withdraw_wh", "total_bag_wh", "total_weight_wh", "doc_type", "sum_pack_month", "sum_pack_year", "total_withdraw_over", "total_bag_withdraw_over"};
                break;
            case 309:
                strColoum = new String[]{"doc_id", "doc_date", "prd_no", "cust_id", "cust_name", "cust_addr", "country_name", "po_no", "item_id", "wh_in", "wh_out", "contain_no", "contain_type", "seal_no", "palate_type", "approver", "approve_name", "payment_prod", "payment_name", "receiver", "receiver_name", "car_no", "net_weight", "net_weight", "wh_in_name", "wh_out_name", "net_weight_wh", "doc_type"};
                break;
            case 313://d_carbon_out_analysis
                strColoum = new String[]{"doc_id", "doc_date", "reporter_id", "reporter_name", "approve_id", "approve_name", "c_type", "tdate1", "tname1", "ttime1", "tdate2", "tname2", "ttime2", "tdate3", "tname3", "ttime3", "approve_status"};
                break;
            case 314://d_carbon_out_analysis New
                strColoum = new String[]{"doc_id", "doc_date", "reporter_id", "reporter_name", "approve_id", "approve_name", "c_type", "tdate1", "tname1", "ttime1", "tdate2", "tname2", "ttime2", "tdate3", "tname3", "ttime3", "approve_status"};
                break;
            case 322:
                strColoum = new String[]{"doc_id", "doc_date", "cust_id", "cust_name", "po_no", "contain_date", "iso_no", "country", "country_name", "lot_no", "mark_sign", "base_plate", "base_plate_desc", "base_plate_qty", "detail", "approve", "approve_name", "mark_sign_desc", "quality_dep", "quality_dep_name", "prod_dep", "prod_dep_name", "wh_dep", "wh_dep_name", "sale_confirm", "quality_confirm", "prod_confirm", "wh_confirm", "i2", "deadline", "stock_prod", "complete_flag"};
                break;

            default:
                break;
        }
        // JOptionPane.showConfirmDialog(null, strColoum);
        return strColoum;
    }

    public String SelectID(int inputpage, String inputdatabase)//function Return ค่าของ Textfill ของหน้าที่จะนำไปลงข้อมูล
    {
        switch (inputpage) {

            case 14:
                if (inputdatabase.equals("vemployee_fullname")) {
                    strID = "emp_id|name|lname|dept_id|dept_name|status|str_file|remark";
                }
                break;
            case 23:
                if (inputdatabase.equals("vd_rawmatt_bigbag_withdraw_header")) {
                    strID = "doc_id|doc_date|date_ck|doc_time|wh_in|wh_out|runner_id|runner_id_desc|p_type|remark|wh_in_desc|wh_out_desc|rawmat_emp|rawmat_emp_name";
                } else {
                    strID = "doc_id|doc_date|date_ck|doc_time|wh_in|wh_out|runner_id|runner_id_desc|p_type|remark|wh_in_desc|wh_out_desc";
                }
                break;
            case 25:
                if (inputdatabase.equals("vd_carbon_friction_header")) {
                    strID = "doc_id|doc_date|doc_time|shift|report_id|remark|sum_up_silo|sum_to_jumbo|report_id_desc|complete_flag";
                } else {
                    strID = "doc_id|doc_date|time_from|time_to|runner_id|runner_id_desc|shift|wh_in|wh_out|loc_total|loc_1|s_bag_loc1|q_bag_loc1|w_bag_loc1|loc_1_desc|loc_2|s_bag_loc2|q_bag_loc2|w_bag_loc2|loc_2_desc|loc_3|s_bag_loc3|q_bag_loc3|w_bag_loc3|loc_3_desc|c_weight1|c_weight2|c_weight3|c_weight4|c_weight5|p_weight1|p_weight2|p_weight3|p_weight4|p_weight5|u_weight1|u_weight2|u_weight3|u_weight4|u_weight5|remark|wh_in_desc|wh_out_desc|c_weight6|p_weight6|u_weight6|loc_c1|loc_c2|loc_c3|loc_c4|loc_c5|loc_c6|loc_p1|loc_p2|loc_p3|loc_p4|loc_p5|loc_p6|loc_u1|loc_u2|loc_u3|loc_u4|loc_u5|loc_u6|c_bag_qty|c_bag_weight|p_bag_qty|p_bag_weight|u_bag_qty|u_bag_weight|c_bag_qty1|c_bag_weight1|p_bag_qty1|p_bag_weight1|u_bag_qty1|u_bag_weight1";
                }
                break;

            case 22:
                if (inputdatabase.equals("Vd_fuel_receive")) {
                    strID = "doc_id|doc_date|wh_in|wh_name|supplier_id|supplier_id_desc"
                            + "|sup_tel_desc|sup_address_desc"
                            + "|position_no|scale_no|car_date_in|car_time_in|car_date_out|car_time_out"
                            + "|car_no|driver_name|product_id"
                            + "|car_weight_in|car_weight_out|total_weight"
                            + "|reporter_id|reporter_id_desc|checker1|checker1_desc|price_unit"
                            + "|total_price|remark|moisture|moisture_std|deduct_weight_moisture"
                            + "|net_weight_receive|net_weight_payment|status";
                } else if (inputdatabase.equals("vd_carbon_friction_burn_detail")) {
                    strID = "doc_id|doc_date|product_id|weight_carbon_in|weight_carbon_friction|weight_carbon_dust|weight_carbon_iron|weight_carbon_total|weight_carbon_bigbag|weight_carbon_burn_in|weight_carbon_real_lost|percent_carbon_real_lost|weight_carbon_lost|percent_carbon_lost|burn_no|channel|wh_id|location_id|remark|percent_moisture|rawmat_emp_id|product_emp_id|complete_flag";
                }
                break;

            case 27:
                if (inputdatabase.equals("vd_carbon_burn_in_header")) {
                    strID = "doc_id|doc_date|date_ck|time_to|time_from|runner_id|runner_id_desc|shift|burn_no|wh_in|wh_out|total_weight|total_weight_chk|tank_qty|operate_id|wh_in_desc|wh_out_desc|operate_id_desc|remark|bu|iod|complete_flag";
                } else {
                    strID = "doc_id|doc_date|date_ck|time_to|time_from|runner_id|runner_id_desc|shift|burn_no|wh_in|wh_out|total_weight|total_weight_chk|tank_qty|operate_id|wh_in_desc|wh_out_desc|operate_id_desc|remark|bu|iod|document_confirm_flag";
                }
                break;
            case 28:
                switch (inputdatabase) {
                    case "vd_carbon_send_product_header":
                    case "vd_carbon_send_product_header_analyze":
                        strID = "A_doc_id|A_doc_date|A_doc_s_time|A_doc_r_time|A_product_leader_id|A_product_leader_name|A_lab_leader_id|A_lab_leader_name|A_warehouse_emp_id|A_warehouse_emp_name|A_warehouse_leader_id|A_warehouse_leader_name|product_confirm|quality_confirm|wh_emp_confirm|wh_leader_confirm|A_job_type|A_complete_flag";
                        break;
                    case "vd_carbon_analysis_all_header":
                        strID = "A_doc_id|A_doc_date|A_lab_leader_id|A_lab_leader_name|quality_confirm|A_job_type|A_send_doc_time|lab_emp_id|lab_emp_name";
                        break;
                }
                break;

            case 29:
                strID = "doc_id|doc_date|work_date|time_from|time_to|runner_id|runner_id_desc|shift|wh_in|wh_out|burn_no|product_id|ch_from|ch_to|weight_split|burn_out_date|total_weight|total_weight_chk|lost_weight|lost_weight_chk|wh_in_desc|wh_out_desc|report_id|report_id_desc|complete_flag";
                break;
            case 31:
                strID = "doc_id|doc_date";
                break;
            case 32:
                strID = "doc_id|doc_date|cust_id|cust_id_desc|po_no|contain_date|iso_no|country_id|country_id_desc|lot_no|mark_sign|base_plate|base_plate_desc|base_plate_qty|remark|approve|approve_desc|mark_sign_desc|quality_dep|quality_dep_desc|prod_dep|prod_dep_desc|wh_dep|wh_dep_desc|sale_confirm|quality_confirm|prod_confirm|wh_confirm|iod2|deadline|stock_prod|complete_flag";
                break;
            case 34:
                strID = "doc_id|doc_date|doc_time|work_type|wh_in|wh_out|prd_emp_id|prd_emp_id_desc|wh_emp_id|wh_emp_id_desc|wh_sup_id|wh_sup_id_desc|wh_in_desc|wh_out_desc|work_type_id|complete_flag";
                break;
            case 36:
                if (inputdatabase.equals("vd_product_receive_header")) {
                    strID = "doc_id|job_id|doc_date|product_id|size|ctc_i2|inc_bal|palate_no|wh_in|wh_out|job_id_desc|mashed_machine_chk|pan_chk|roast_chk|mag_chk|pill_flat_chk|roast_edit_chk|wash_chk|ball_mill_chk|job_edit_chk|mashed_machine|pan|ball_mill|pill_flat|mag|job_edit|wash|roast|roast_edit|wh_in_desc|wh_out_desc|remark|job_id_end|process_order";
                } else {
                    strID = "doc_id|doc_date|job_id|product_id|size|ctc_i2|inc_bal|palate_no|wh_in|wh_out|job_id_desc|mashed_machine_chk|pan_chk|roast_chk|mag_chk|pill_flat_chk|roast_edit_chk|wash_chk|ball_mill_chk|job_edit_chk|mashed_machine|pan|ball_mill|pill_flat|mag|job_edit|wash|roast|roast_edit|wh_in_desc|wh_out_desc|remark|job_id_end|confirm_document";
                }
                break;
            case 38:
                strID = "doc_id|doc_date|job_id|job_id_desc|weight|bag|carbon_pack|place_pack|i2|wh_in|wh_out";
                break;
            case 42:
                strID = "doc_id|doc_date|job_id|cust_id|job_id_desc|cust_address_desc|cust_country_desc|po_no_desc|item_id|wh_in|wh_out|contain_no|contain_type|seal_no|palate_type|approver|approver_desc|payment_prod|payment_prod_desc|receiver|receiver_desc|car_no|net_weight|net_weight_chk|wh_in_desc|wh_out_desc";
                break;
            case 40:
                strID = "doc_id|doc_date|job_id|time_from|time_to|emp_id|emp_id_desc|shift|wh_in|wh_out|lost_weight|total_bag_withdraw|total_bag_withdraw_edit|total_weight_withdraw|total_weight_withdraw_edit|total_bag|total_bag_edit|total_weight|total_weight_edit|job_id_desc|runner_id|runner_id_desc|wh_in_desc|wh_out_desc|sum_pack_month|sum_pack_year|total_withdraw_over|total_bag_withdraw_over";
                break;
            case 41:
                strID = "doc_id|doc_date|job_id|time_from|time_to|emp_id|emp_id_desc|shift|wh_in|wh_out|lost_weight|total_bag_withdraw|total_bag_withdraw_edit|total_weight_withdraw|total_weight_withdraw_edit|total_bag|total_bag_edit|total_weight|total_weight_edit|job_id_desc|runner_id|runner_id_desc|wh_in_desc|wh_out_desc|sum_pack_month|sum_pack_year|total_withdraw_over|total_bag_withdraw_over";
                break;
            case 46:
                strID = "doc_id|doc_date|car_no|sender_id|c_type|report_id|approve_id|sender_id_desc|report_id_desc|approve_id_desc|car_date_in|approve_status|moisture_average|record_detail";
                break;
            case 103:
                strID = "doc_id|doc_date|doc_time|prd_emp_id|sending_id|remark|prd_emp_id_desc|sending_id_desc";
                break;
            case 105:
                strID = "doc_id|doc_date|shift|reporter_id|checker_id|hc1|hc2|hc3|hc4|hc5|hc6|hc7|hc8|hc9|hc10|hc11|hc12|hc13|hc14|hc15|reporter_id_desc|checker_id_desc|doc_time|approve_status";
                break;
            case 106:
                strID = "doc_id|doc_date|doc_time|shift|prd_no|cust_id|quantity|size|hc1|hc2|hc3|hc4|hc5|hc6|hc7|hc8|hc9|hc10|hc11|hc12|hc13|hc14|hc15|cust_id_desc";
                break;
            case 112:
                strID = "doc_id|doc_date|job_no|cust_id|product_id|weight|hc1|hc2|hc3|hc4|hc5|hc6|hc7|hc8|hc9|hc10|hc11|hc12|hc13|hc14|hc15|cust_id_desc|product_id_desc";
                break;
            case 115:
                if (inputdatabase.equals("vd_ticketbuy_doc_not_cgc")) {
                    strID = "doc_id|doc_date|doc_time|complete_flag";
                } else if (inputdatabase.equals("d_adjust_product_header")) {
                    strID = "doc_id|doc_date|doc_time|doc_type|remark|total_weight_adjust|complete_flag";
                } else {
                    strID = "doc_id|doc_date|doc_time|doc_type|remark|total_weight_adjust|complete_flag";
                }
                break;
            case 300:
                strID = "doc_id|doc_date|work_date|time_from|time_to|runner_id|runner_id_desc|shift|wh_in|wh_out|burn_no|product_id|ch_from|ch_to|weight_split|burn_out_date|total_weight|total_weight_chk|lost_weight|lost_weight_chk|wh_in_desc|wh_out_desc|report_id|report_id_desc|document_confirm_flag";
                break;
            case 302:
                strID = "doc_id|doc_date|doc_time|work_type|wh_in|wh_out|prd_emp_id|prd_emp_id_desc|wh_emp_id|wh_emp_id_desc|wh_sup_id|wh_sup_id_desc|wh_in_desc|wh_out_desc|document_confirm_flag";
                break;
            case 304:
                strID = "doc_id|doc_date|doc_time|prd_emp_id|sending_id|remark|prd_emp_id_desc|sending_id_desc|wh_emp_id|wh_emp_id_desc|document_confirm_flag";
                break;
            case 306:
                strID = "doc_id|doc_date|job_id|time_from|time_to|emp_id|emp_id_desc|shift|wh_in|wh_out|lost_weight|total_bag_withdraw|total_bag_withdraw_edit|total_weight_withdraw|total_weight_withdraw_edit|total_bag|total_bag_edit|total_weight|total_weight_edit|job_id_desc|runner_id|runner_id_desc|wh_in_desc|wh_out_desc|total_bag_withdraw_wh|total_weight_withdraw_wh|total_bag_wh|total_weight_wh|document_confirm_flag|sum_pack_month|sum_pack_year|total_withdraw_over|total_bag_withdraw_over";
                break;
            case 309:
                strID = "doc_id|doc_date|job_id|cust_id|job_id_desc|cust_address_desc|cust_country_desc|po_no_desc|item_id|wh_in|wh_out|contain_no|contain_type|seal_no|palate_type|approver|approver_desc|payment_prod|payment_prod_desc|receiver|receiver_desc|car_no|net_weight|net_weight_chk|wh_in_desc|wh_out_desc|net_weight_wh|document_confirm_flag";
                break;
            case 313:
                strID = "doc_id|doc_date|reporter_id|reporter_id_desc|approve_id|approve_id_desc|c_type|tdate1|tname1|ttime1|tdate2|tname2|ttime2|tdate3|tname3|ttime3|approve_status";
                break;
            case 314:
                strID = "doc_id|doc_date|reporter_id|reporter_id_desc|approve_id|approve_id_desc|c_type|tdate1|tname1|ttime1|tdate2|tname2|ttime2|tdate3|tname3|ttime3|approve_status";
                break;
            case 322:
                strID = "doc_id|doc_date|cust_id|cust_id_desc|po_no|contain_date|iso_no|country_id|country_id_desc|lot_no|mark_sign|base_plate|base_plate_desc|base_plate_qty|remark|approve|approve_desc|mark_sign_desc|quality_dep|quality_dep_desc|prod_dep|prod_dep_desc|wh_dep|wh_dep_desc|sale_confirm|quality_confirm|prod_confirm|wh_confirm|iod2|deadline|stock_prod|complete_flag";
                break;
            default:
                break;
        }
        //total_bag_withdraw_wh|total_weight_withdraw_wh|total_bag_wh|total_weight_wh
        return strID;
    }

    public String[] SelectFillName(int inputpage, String inputdatabase)//function แสดงชื่อ Fill ของ Table(HTML)
    {
        switch (inputpage) {
            case 14:
                if (inputdatabase.equals("vemployee_fullname")) {
                    strFillName = new String[]{"รหัสพนักงาน", "ชื่อ-นามสกุล"};
                }
                break;
            case 23:
                strFillName = new String[]{"เลขที่เอกสาร", "วันที่บันทึกเอกสาร"};
                break;
            case 25:
                strFillName = new String[]{"เลขที่เอกสาร", "วันที่บันทึกเอกสาร"};
                break;
            case 22:
                if (inputdatabase.equals("d_carbon_friction_burn_detail")) {
                    strFillName = new String[]{"เลขที่เอกสาร", "วันที่บันทึกเอกสาร", "ชนิดถ่าน", "กองที่"};
                } else {
                    strFillName = new String[]{"เลขที่เอกสาร", "วันที่บันทึกเอกสาร", "ชื่อผู้ขาย", "เลขที่ใบชั่ง"};
                }
                break;
            case 27:
                strFillName = new String[]{"เลขที่เอกสาร", "วันที่บันทึกเอกสาร"};
                break;
            case 28:
                if (inputdatabase.equals("vd_carbon_send_product_header") || inputdatabase.equals("vd_carbon_send_product_header_analyze")) {
                    strFillName = new String[]{"เลขที่เอกสาร", "วันที่นำส่ง"};
                } else if (inputdatabase.equals("vd_carbon_analysis_all_header")) {
                    strFillName = new String[]{"เลขที่เอกสาร", "วันที่เอกสาร"};
                }
                break;
            case 29:
                strFillName = new String[]{"เลขที่เอกสาร", "วันที่บันทึกเอกสาร", "เตา"};
                break;
            case 31:
                strFillName = new String[]{"เลขที่เอกสาร", "วันที่บันทึกเอกสาร"};
                break;
            case 32:
                strFillName = new String[]{"เลขที่เอกสาร", "วันที่บันทึกเอกสาร"};
                break;
            case 34:
                strFillName = new String[]{"เลขที่เอกสาร", "วันที่บันทึกเอกสาร"};
                break;
            case 36:
                if (inputdatabase.equals("vd_product_receive_header")) {
                    strFillName = new String[]{"เลขที่เอกสาร", "เลขที่ใบแจ้งการผลิต", "วันที่บันทึกเอกสาร"};
                } else {
                    strFillName = new String[]{"เลขที่เอกสาร", "วันที่บันทึกเอกสาร", "เลขที่ใบแจ้งการผลิต"};
                }

                break;
            case 38:
                strFillName = new String[]{"เลขที่เอกสาร", "วันที่บันทึกเอกสาร"};
                break;
            case 40:
                strFillName = new String[]{"เลขที่เอกสาร", "วันที่บันทึกเอกสาร"};
                break;
            case 41:
                strFillName = new String[]{"เลขที่เอกสาร", "วันที่บันทึกเอกสาร"};
                break;
            case 42:
                strFillName = new String[]{"เลขที่เอกสาร", "วันที่บันทึกเอกสาร"};
                break;
            case 46:
                strFillName = new String[]{"เลขที่เอกสาร", "วันที่รถถ่านเข้า", "เลขทะเบียนรถ", "Approve", "อนุมัติเอกสาร"};
                break;
            case 103:
                strFillName = new String[]{"เลขที่เอกสาร", "วันที่บันทึกเอกสาร"};
                break;
            case 105:
                strFillName = new String[]{"เลขที่เอกสาร", "วันที่บันทึกเอกสาร", "เวลา", "สถานะการ Approve"};
                break;
            case 106:
                strFillName = new String[]{"เลขที่เอกสาร", "วันที่บันทึกเอกสาร"};
                break;
            case 112:
                strFillName = new String[]{"เลขที่เอกสาร", "วันที่บันทึกเอกสาร"};
                break;
            case 115:
                strFillName = new String[]{"เลขที่เอกสาร", "วันที่บันทึกเอกสาร"};
                break;
            case 300:
                strFillName = new String[]{"เลขที่เอกสาร", "วันที่บันทึกเอกสาร"};
                break;
            case 302:
                strFillName = new String[]{"เลขที่เอกสาร", "วันที่บันทึกเอกสาร"};
                break;
            case 304:
                strFillName = new String[]{"เลขที่เอกสาร", "วันที่บันทึกเอกสาร"};
                break;
            case 306:
                strFillName = new String[]{"เลขที่เอกสาร", "วันที่บันทึกเอกสาร"};
                break;
            case 309:
                strFillName = new String[]{"เลขที่เอกสาร", "วันที่บันทึกเอกสาร"};
                break;
            case 313:
                strFillName = new String[]{"เลขที่เอกสาร", "วันที่บันทึกเอกสาร", "สถานะการ Approve"};
                break;
            case 314:
                strFillName = new String[]{"เลขที่เอกสาร", "วันที่บันทึกเอกสาร", "สถานะการ Approve"};
                break;
            case 322:
                strFillName = new String[]{"เลขที่เอกสาร", "วันที่บันทึกเอกสาร"};
                break;
            default:
                break;
        }
        // JOptionPane.showConfirmDialog(null, strFillName);
        return strFillName;

    }

    public String[] SelectColoumShow(int inputpage, String inputdatabase)//function แสดงข้อมูลใน Table(HTML)
    {
        switch (inputpage) {

            case 14:
                if (inputdatabase.equals("vemployee_fullname")) {
                    strColoumShow = new String[]{"emp_id", "fullname"};
                }
                break;
            case 23:
                strColoumShow = new String[]{"doc_id", "doc_date"};
                break;
            case 25:
                strColoumShow = new String[]{"doc_id", "doc_date"};
                break;
            case 22:
                if (inputdatabase.equals("Vd_fuel_receive")) {
                    strColoumShow = new String[]{"doc_id", "doc_date", "supplier_name", "scale_no"};
                } else if (inputdatabase.equals("d_carbon_friction_burn_detail")) {
                    strColoumShow = new String[]{"doc_id", "doc_date", "product_id", "location_id"};
                }
                break;

            case 27:
                strColoumShow = new String[]{"doc_id", "doc_date"};
                break;
            case 28:
                switch (inputdatabase) {
                    case "vd_carbon_send_product_header":
                    case "vd_carbon_send_product_header_analyze":
                        strColoumShow = new String[]{"doc_id", "doc_date"};
                        break;
                    case "vd_carbon_analysis_all_header":
                        strColoumShow = new String[]{"doc_id", "doc_date"};
                        break;
                }
                break;
            case 29:
                strColoumShow = new String[]{"doc_id", "doc_date", "burn_no"};
                break;
            case 31:
                strColoumShow = new String[]{"doc_id", "doc_date"};
                break;
            case 32:
                strColoumShow = new String[]{"doc_id", "doc_date"};
                break;
            case 34:
                strColoumShow = new String[]{"doc_id", "doc_date"};
                break;
            case 36:
                if (inputdatabase.equals("vd_product_receive_header")) {
                    strColoumShow = new String[]{"doc_id", "job_id", "doc_date"};
                } else {
                    strColoumShow = new String[]{"doc_id", "doc_date", "job_id"};
                }

                break;
            case 38:
                strColoumShow = new String[]{"doc_id", "doc_date"};
                break;
            case 40:
                strColoumShow = new String[]{"doc_id", "doc_date"};
                break;
            case 41:
                strColoumShow = new String[]{"doc_id", "doc_date"};
                break;
            case 42:
                strColoumShow = new String[]{"doc_id", "doc_date"};
                break;
            case 46:
                strColoumShow = new String[]{"doc_id", "doc_date", "car_no", "approve_status", "complete_flag"};
                break;
            case 103:
                strColoumShow = new String[]{"doc_id", "doc_date"};
                break;
            case 105:
                strColoumShow = new String[]{"doc_id", "doc_date", "doc_time", "approve_status"};
                break;
            case 106:
                strColoumShow = new String[]{"doc_id", "doc_date"};
                break;
            case 112:
                strColoumShow = new String[]{"doc_id", "stuffing_date"};
                break;
            case 115:
                strColoumShow = new String[]{"doc_id", "doc_date"};
                break;
            case 300:
                strColoumShow = new String[]{"doc_id", "doc_date"};
                break;
            case 302:
                strColoumShow = new String[]{"doc_id", "doc_date"};
                break;
            case 304:
                strColoumShow = new String[]{"doc_id", "doc_date"};
                break;
            case 306:
                strColoumShow = new String[]{"doc_id", "doc_date"};
                break;
            case 309:
                strColoumShow = new String[]{"doc_id", "doc_date"};
                break;
            case 313:
                strColoumShow = new String[]{"doc_id", "doc_date", "approve_status"};
                break;
            case 314:
                strColoumShow = new String[]{"doc_id", "doc_date", "approve_status"};
                break;
            case 322:
                strColoumShow = new String[]{"doc_id", "doc_date"};
                break;
            default:
                break;
        }
        //JOptionPane.showConfirmDialog(null, strColoumShow);
        return strColoumShow;
    }

    public String SelectURLShowDetail(int inputpage, String inputdatabase) {
        switch (inputpage) {
            case 14:
                strURLShow = "../SHOWDETAILSCREEN/CS_Show014_IMG.jsp?emp_id=";
                break;
            case 23:
                switch (inputdatabase) {
                    case "vd_rawmatt_bigbag_withdraw_header":
                        strURLShow = "../JSP/CS_Show058.jsp?doc_id=";
                        break;
                    case "vd_rawmatt_withdraw_header":
                        strURLShow = "../JSP/CS_Show024.jsp?doc_id=";
                        break;
                }
                break;
            case 25:
                //strURLShow = "../JSP/CS_Show026.jsp?doc_id=";
                strURLShow = "../JSP/CS_DetailShow_025_1.jsp?doc_id=";
                break;
            case 27:
                if (inputdatabase.equals("vd_carbon_burn_in_header")) {
                    strURLShow = "../JSP/CS_Show028.jsp?doc_id=";
                } else {
                    strURLShow = "../JSP/CS_Show028_2.jsp?doc_id=";
                }
                break;

            case 28:
                switch (inputdatabase) {
                    case "vd_carbon_send_product_header":
                        strURLShow = "../JSP/CS_D_carbon_send_product.jsp?doc_id=";
                        break;
                    case "vd_carbon_send_product_header_analyze":
                        strURLShow = "../JSP/CS_D_carbon_send_product_analyze.jsp?doc_id=";
                        break;
                    case "vd_carbon_analysis_all_header":
                        strURLShow = "../JSP/CS_D_carbon_analysis.jsp?doc_id=";
                        break;
                }
                break;

            case 29:
                strURLShow = "../JSP/CS_Show030.jsp?doc_id=";
                break;
            case 31:
                strURLShow = "../JSP/CS_Show031.jsp?doc_id=";
                break;
            case 32:
                strURLShow = "../JSP/CS_Show032.jsp?doc_id=,../JSP/CS_Show033.jsp?doc_id=";
                break;
            case 34:
                strURLShow = "../JSP/CS_Show035.jsp?doc_id=";
                break;
            case 36:
                if (inputdatabase.equals("vd_product_receive_header")) {
                    strURLShow = "../JSP/CS_Show037.jsp?doc_id=,../JSP/CS_Show045.jsp?doc_id=";
                } else {
                    strURLShow = "../JSP/CS_Show037_2.jsp?doc_id=,../JSP/CS_Show045_2.jsp?doc_id=";
                }

                break;
            case 38:
                strURLShow = "../JSP/CS_Show039.jsp?doc_id=";
                break;
            case 40:
                strURLShow = "../JSP/CS_Show041.jsp?doc_id=,../JSP/CS_Show044.jsp?doc_id=";
                System.out.println("Case 40 = " + strURLShow);
                break;
            case 41:
                strURLShow = "../JSP/CS_Show041_1.jsp?doc_id=,../JSP/CS_Show044_1.jsp?doc_id=";
                System.out.println("Case 41 = " + strURLShow);
                break;
            case 42:
                strURLShow = "../JSP/CS_Show043.jsp?doc_id=";
                break;
            case 46:
                strURLShow = "../JSP/CS_Show047.jsp?doc_id=";
                break;
            case 103:
                strURLShow = "../JSP/CS_Show108.jsp?doc_id=";
                break;
            case 105:
                strURLShow = "../JSP/CS_Show109.jsp?doc_id=";
                break;
            case 106:
                strURLShow = "../JSP/CS_Show110.jsp?doc_id=";
                break;
            case 112:
                strURLShow = "../JSP/CS_Show113.jsp?doc_id=";
                break;
            case 115:
                switch (inputdatabase) {
                    case "d_ticketbuy_doc":
                        strURLShow = "../JSP/CS_Show_D_ticketbuy_doc.jsp?doc_id=";
                        break;
                    case "vd_ticketbuy_doc_not_cgc":
                        strURLShow = "../JSP/CS_Show_D_ticketbuy_doc.jsp?doc_id=";
                        break;
                    case "d_adjust_rawmat_header":
                        strURLShow = "../JSP/CS_Show117.jsp?doc_id=";
                        break;
                    default:
                        strURLShow = "../JSP/CS_Show116.jsp?doc_id=";
                        break;
                }
                break;
            case 300:
                strURLShow = "../JSP/CS_Show301.jsp?doc_id=";
                break;
            case 302:
                strURLShow = "../JSP/CS_Show303.jsp?doc_id=";
                break;
            case 304:
                strURLShow = "../JSP/CS_Show305.jsp?doc_id=";
                break;
            case 306:
                strURLShow = "../JSP/CS_Show307.jsp?doc_id=,../JSP/CS_Show308.jsp?doc_id=";
                break;
            case 309:
                strURLShow = "../JSP/CS_Show310.jsp?doc_id=";
                break;
            case 313:
                strURLShow = "../JSP/CS_ShowD_carbon_out_analysis.jsp?doc_id=";
                break;
            case 314:
                strURLShow = "../JSP/CS_ShowD_carbon_out_analysis_New.jsp?doc_id=";
                break;
            case 322:
                strURLShow = "../JSP/CS_Show032_2.jsp?doc_id=,../JSP/CS_Show033_2.jsp?doc_id=";
                break;
            default:
                break;
        }

        return strURLShow;
    }
}
