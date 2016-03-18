<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="java.sql.Date"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@page import="com.cgc.bean.DataBean_D_rawmatt_receive"%>
<%@page import="com.cgc.DB.D_rawmatt_receiveDAO"%>
<%@page import="com.cgc.Calculator.D_rawmatt_receive_Calculat"%>
<%@page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>
<%@page import="java.sql.*"%>
<%!    ThaiUtil en = new ThaiUtil();
    DataBean_D_rawmatt_receive objdb = new DataBean_D_rawmatt_receive();
    D_rawmatt_receiveDAO objex = new D_rawmatt_receiveDAO();
    UtiDatabase uti = new UtiDatabase();
    Timestamp ts;
    D_rawmatt_receive_Calculat objcal = new D_rawmatt_receive_Calculat();
%>
<%

    int statusck = 0;
    int statusnum = 0;
    System.out.println("statusck = " + request.getParameter("status_d"));
    if (request.getParameter("status_d") == null && request.getParameter("status_cal") == null) {
        statusnum = uti.numRowdatabase("Select Count(doc_id) As num from  d_rawmatt_receive where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id").trim()) + "' and delete_flag <> 'Y' and complete_flag <> 'Y'");
        if (statusnum == 0) {
            if (uti.numRowdatabase("Select Count(doc_id) As num from  d_rawmatt_receive where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id").trim()) + "' and delete_flag = 'N' and complete_flag = 'Y'") == 1) {
                statusck = -1;
            } else {
                statusck = 1;
            }
            //statusck = 1;

        } else if (statusnum == 1) {
            statusck = 2;
        } else {
            statusck = -1;
        }
    } else if (request.getParameter("status_cal") != null) {
        statusck = 4;
    } else {
        statusck = Integer.parseInt(request.getParameter("status_d"));
        System.out.println("statusck = " + request.getParameter("status_d"));
        System.out.println("statusck = " + statusck);
        System.out.println("status_cal = " + request.getParameter("status_cal"));
    }

    if (request.getParameter("status_cal") == null && statusck != 3) {
        if (request.getParameter("doc_date") != null) {
            objdb.setDoc_date(en.EncodeTexttoTIS(request.getParameter("doc_date")));
        }

        if (request.getParameter("wh_in") != null) {
            objdb.setWh_in(en.EncodeTexttoTIS(request.getParameter("wh_in")));
            objdb.setWh_in(en.EncodeTexttoTIS(request.getParameter("wh_in")));

        }
        if (request.getParameter("supplier_id") != null) {
            objdb.setSupplier_id(en.EncodeTexttoTIS(request.getParameter("supplier_id")));
        }
        if (request.getParameter("position_no") != null) {
            objdb.setPosition_no(en.EncodeTexttoTIS(request.getParameter("position_no").trim()));
        }
        if (request.getParameter("car_no") != null) {
            objdb.setCar_no(en.EncodeTexttoTIS(request.getParameter("car_no")));
        }
        if (request.getParameter("driver_name") != null) {
            objdb.setDriver_name(en.EncodeTexttoTIS(request.getParameter("driver_name")));
        }
        if (request.getParameter("type_prod") != null) {
            objdb.setType_prod(en.EncodeTexttoTIS(request.getParameter("type_prod")));
        }
        if (request.getParameter("product_id") != null) {
            objdb.setProduct_id(en.EncodeTexttoTIS(request.getParameter("product_id")));
        }
        if (request.getParameter("total_weight") != null) {
            objdb.setTotal_weight(en.EncodeTexttoTIS(request.getParameter("total_weight")));
        }
        if (request.getParameter("bag_weight") != null) {
            objdb.setBag_weight(en.EncodeTexttoTIS(request.getParameter("bag_weight")));
        }
        if (request.getParameter("car_date_in") != null) {
            objdb.setCar_date_in(en.EncodeTexttoTIS(request.getParameter("car_date_in")));
        }
        if (request.getParameter("bag_total") != null) {
            objdb.setBag_total(en.EncodeTexttoTIS(request.getParameter("bag_total")));
        }

        //car_date_in,bag_total
        if (request.getParameter("etc_val") != null) {
            objdb.setEtc_val(request.getParameter("etc_val"));
        }
        if (request.getParameter("ashes_percent") != null) {
            if (request.getParameter("ashes_percent").equals("")) {
                objdb.setAshes_percent("0");
            } else {
                objdb.setAshes_percent(request.getParameter("ashes_percent"));
            }
            //objdb.setAshes_percent(request.getParameter("ashes_percent"));
        }
        if (request.getParameter("ashes_weight") != null) {
            if (request.getParameter("ashes_weight").equals("")) {
                objdb.setAshes_weight("0");
            } else {
                objdb.setAshes_weight(request.getParameter("ashes_weight"));
            }
            //objdb.setAshes_weight(request.getParameter("ashes_weight"));
        }
        if (request.getParameter("dust_percent") != null) {
            if (request.getParameter("dust_percent").equals("")) {
                objdb.setDust_percent("0");
            } else {
                objdb.setDust_percent(request.getParameter("dust_percent"));
            }
            //objdb.setDust_percent(request.getParameter("dust_percent"));
        }
        if (request.getParameter("dust_weight") != null) {
            if (request.getParameter("dust_weight").equals("")) {
                objdb.setDust_weight("0");
            } else {
                objdb.setDust_weight(request.getParameter("dust_weight"));
            }
            //objdb.setDust_weight(request.getParameter("dust_weight"));
        }
        if (request.getParameter("volatile_percent") != null) {
            if (request.getParameter("volatile_percent").equals("")) {
                objdb.setVolatile_percent("0");
            } else {
                objdb.setVolatile_percent(request.getParameter("volatile_percent"));
            }
            //objdb.setVolatile_percent(request.getParameter("volatile_percent"));
        }
        if (request.getParameter("volatile_weight") != null) {
            if (request.getParameter("volatile_weight").equals("")) {
                objdb.setVolatile_weight("0");
            } else {
                objdb.setVolatile_weight(request.getParameter("volatile_weight"));
            }
            //objdb.setVolatile_weight(request.getParameter("volatile_weight"));
        }
        if (request.getParameter("moise_percent") != null) {
            if (request.getParameter("moise_percent").equals("")) {
                objdb.setMoise_percent("0");
            } else {
                objdb.setMoise_percent(request.getParameter("moise_percent"));
            }
            //objdb.setMoise_percent(request.getParameter("moise_percent"));
        }
        if (request.getParameter("moise_weight") != null) {
            if (request.getParameter("moise_weight").equals("")) {
                objdb.setMoise_weight("0");
            } else {
                objdb.setMoise_weight(request.getParameter("moise_weight"));
            }
            //objdb.setMoise_weight(request.getParameter("moise_weight"));
        }
        if (request.getParameter("contamination_percent") != null) {
            if (request.getParameter("contamination_percent").equals("")) {
                objdb.setContamination_percent("0");
            } else {
                objdb.setContamination_percent(request.getParameter("contamination_percent"));
            }
            //objdb.setContamination_percent(request.getParameter("contamination_percent"));
        }
        if (request.getParameter("contamination_weight") != null) {
            if (request.getParameter("contamination_weight").equals("")) {
                objdb.setContamination_weight("0");
            } else {
                objdb.setContamination_weight(request.getParameter("contamination_weight"));
            }
            //objdb.setContamination_weight(request.getParameter("contamination_weight"));
        }
        if (request.getParameter("net_weight") != null) {
            if (request.getParameter("net_weight").equals("")) {
                objdb.setNet_weight("0");
            } else {
                objdb.setNet_weight(request.getParameter("net_weight"));
            }
            //objdb.setNet_weight(request.getParameter("net_weight"));
        }

        objdb.setRemark(request.getParameter("remark") == null ? "" : en.EncodeTexttoTIS(request.getParameter("remark")));

        objdb.setTotal_price(request.getParameter("total_price") == null || request.getParameter("total_price").equals("") ? "0" : en.EncodeTexttoTIS(request.getParameter("total_price")));

        /*        
         if (request.getParameter("total_price") == null || request.getParameter("total_price").equals("")) {
         objdb.setTotal_price("0");
         } else {
         objdb.setTotal_price(request.getParameter("total_price"));
         }
         */
        //----
        if (request.getParameter("ashes_percent_ch") != null) {
            if (request.getParameter("ashes_percent_ch").equals("")) {
                objdb.setAshes_percent_ch("0");
            } else {
                objdb.setAshes_percent_ch(request.getParameter("ashes_percent_ch"));
            }
            //objdb.setAshes_percent_ch(request.getParameter("ashes_percent_ch"));
        }
        if (request.getParameter("ashes_weight_ch") != null) {
            if (request.getParameter("ashes_weight_ch").equals("")) {
                objdb.setAshes_weight_ch("0");
            } else {
                objdb.setAshes_weight_ch(request.getParameter("ashes_weight_ch"));
            }
            //objdb.setAshes_weight_ch(request.getParameter("ashes_weight_ch"));
        }
        if (request.getParameter("dust_percent_ch") != null) {
            if (request.getParameter("dust_percent_ch").equals("")) {
                objdb.setDust_percent_ch("0");
            } else {
                objdb.setDust_percent_ch(request.getParameter("dust_percent_ch"));
            }
            //objdb.setDust_percent_ch(request.getParameter("dust_percent_ch"));
        }
        if (request.getParameter("dust_weight_ch") != null) {
            if (request.getParameter("dust_weight_ch").equals("")) {
                objdb.setDust_weight_ch("0");
            } else {
                objdb.setDust_weight_ch(request.getParameter("dust_weight_ch"));
            }
            //objdb.setDust_weight_ch(request.getParameter("dust_weight_ch"));
        }
        if (request.getParameter("volatile_percent_ch") != null) {
            if (request.getParameter("volatile_percent_ch").equals("")) {
                objdb.setVolatile_percent_ch("0");
            } else {
                objdb.setVolatile_percent_ch(request.getParameter("volatile_percent_ch"));
            }
            //objdb.setVolatile_percent_ch(request.getParameter("volatile_percent_ch"));
        }
        if (request.getParameter("volatile_weight_ch") != null) {
            if (request.getParameter("volatile_weight_ch").equals("")) {
                objdb.setVolatile_weight_ch("0");
            } else {
                objdb.setVolatile_weight_ch(request.getParameter("volatile_weight_ch"));
            }
            //objdb.setVolatile_weight_ch(request.getParameter("volatile_weight_ch"));
        }
        if (request.getParameter("moise_percent_ch") != null) {
            if (request.getParameter("moise_percent_ch").equals("")) {
                objdb.setMoise_percent_ch("0");
            } else {
                objdb.setMoise_percent_ch(request.getParameter("moise_percent_ch"));
            }
            //objdb.setMoise_percent_ch(request.getParameter("moise_percent_ch"));
        }
        if (request.getParameter("moise_weight_ch") != null) {
            if (request.getParameter("moise_weight_ch").equals("")) {
                objdb.setMoise_weight_ch("0");
            } else {
                objdb.setMoise_weight_ch(request.getParameter("moise_weight_ch"));
            }
            //objdb.setMoise_weight_ch(request.getParameter("moise_weight_ch"));
        }
        if (request.getParameter("contamination_percent_ch") != null) {
            if (request.getParameter("contamination_percent_ch").equals("")) {
                objdb.setContamination_percent_ch("0");
            } else {
                objdb.setContamination_percent_ch(request.getParameter("contamination_percent_ch"));
            }
            //objdb.setContamination_percent_ch(request.getParameter("contamination_percent_ch"));
        }
        if (request.getParameter("contamination_weight_ch") != null) {
            if (request.getParameter("contamination_weight_ch").equals("")) {
                objdb.setContamination_weight_ch("0");
            } else {
                objdb.setContamination_weight_ch(request.getParameter("contamination_weight_ch"));
            }
            //objdb.setContamination_weight_ch(request.getParameter("contamination_weight_ch"));
        }
        if (request.getParameter("net_weight_ch") != null) {
            if (request.getParameter("net_weight_ch").equals("")) {
                objdb.setNet_weight_ch("0");
            } else {
                objdb.setNet_weight_ch(request.getParameter("net_weight_ch"));
            }
            //objdb.setNet_weight_ch(request.getParameter("net_weight_ch"));
        }

        if (request.getParameter("lab_not_check") != null || !(request.getParameter("lab_not_check").equals(""))) {
            objdb.setLab_not_check(request.getParameter("lab_not_check"));
        }

        System.out.println(request.getParameter("lab_not_check"));

        objdb.setBranch_id(request.getParameter("select_mbranch"));
        objdb.setCar_cbag_weight(request.getParameter("car_cbag_weight"));
        objdb.setCar_weight(request.getParameter("car_weight"));
        objdb.setBag_net(request.getParameter("bag_net"));
        objdb.setCarbon_net(request.getParameter("carbon_net"));
        objdb.setPrice_unit(request.getParameter("price_unit"));
    }

    objdb.setDoc_id(en.EncodeTexttoTIS(request.getParameter("doc_id").trim()));
    if (request.getParameter("scale_no") != null) {
        objdb.setScale_no(en.EncodeTexttoTIS(request.getParameter("scale_no")));
    }
    ts = new Timestamp(new java.util.Date().getTime());
    objdb.setDate(ts);
    objdb.setBy(en.EncodeTexttoTIS(request.getParameter("username")));
    objdb.setLine_no(1);

    //JOptionPane.showConfirmDialog(null, request.getParameter("status_cal"));
    System.out.println("Final statusck = " + statusck);

    switch (statusck) {
        case -1:
            out.print("ไม่สามารถบันทึกข้อมูลนี้ได้เนื่องจากมีเลขที่เอกสารที่สมบูรณ์แล้ว");
            break;
        case 1:
            if (objex.insert(objdb) != -1) {
                out.print("บันทึกสำเร็จ");
            }
            break;
        case 2:
            if (request.getParameter("confirm") != null && request.getParameter("confirm").equals("true")) {
                objex.update(objdb);
                out.print("แก้ไขสำเร็จ");
            } else {
                out.print("edit");
            }
            break;
        case 3:
            if (objex.UpDel(objdb) != -1) {
                out.print("ลบข้อมูลสำเร็จ");
            }
            break;
        case 4:
            //JOptionPane.showConfirmDialog(null, request.getParameter("scale_no"));
            out.print(objcal.Page_D_rawmat_receive_Cal(en.EncodeTexttoTIS(request.getParameter("scale_no")), en.EncodeTexttoTIS(request.getParameter("product_id"))));
            break;
        default:
            out.print("No Statment");
    }
%>