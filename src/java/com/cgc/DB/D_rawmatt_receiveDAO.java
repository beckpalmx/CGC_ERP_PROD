package com.cgc.DB;

import com.cgc.Util.UtiDatabase;
import com.cgc.bean.DataBean_D_rawmatt_receive;
import java.sql.*;

//
//CS_022
public class D_rawmatt_receiveDAO {

    private int Returnvalue;

    public int insert(DataBean_D_rawmatt_receive dataBean) throws Exception {
        Returnvalue = 0;
        UtiDatabase objuti = new UtiDatabase();
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        String sql = "insert into d_rawmatt_receive (doc_id,doc_date,wh_in,supplier_id,position_no,etc_val,scale_no,car_no,driver_name,type_prod,product_id,total_weight,bag_weight,create_date,ashes_percent,ashes_weight,dust_percent,dust_weight,volatile_percent,volatile_weight,moise_percent,moise_weight,contamination_percent,contamination_weight,net_weight,remark,total_price,create_by,doc_type,car_date_in,bag_total,ashes_percent_ch,ashes_weight_ch,dust_percent_ch,dust_weight_ch,volatile_percent_ch,volatile_weight_ch,moise_percent_ch,moise_weight_ch,contamination_percent_ch,contamination_weight_ch,net_weight_ch,car_cbag_weight,car_weight,bag_net,carbon_net,location_id2,price_unit,ashes_percent_acc,ashes_weight_acc,dust_percent_acc,dust_weight_acc,volatile_percent_acc,volatile_weight_acc,moise_percent_acc,moise_weight_acc,contamination_percent_acc,contamination_weight_acc,net_weight_acc,lab_not_check,friction_house,line_no) "
                + "values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        //ashes_percent_ch,ashes_weight_ch,dust_percent_ch,dust_weight_ch,volatile_percent_ch,volatile_weight_ch,moise_percent_ch,moise_weight_ch,contamination_percent_ch,contamination_weight_ch,net_weight_ch
        PreparedStatement p;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getDoc_id());
            p.setString(2, dataBean.getDoc_date());
            p.setString(3, dataBean.getWh_in());
            p.setString(4, dataBean.getSupplier_id());
            p.setString(5, dataBean.getPosition_no());
            p.setString(6, dataBean.getEtc_val());
            p.setString(7, dataBean.getScale_no());
            p.setString(8, dataBean.getCar_no());
            p.setString(9, dataBean.getDriver_name());
            p.setString(10, dataBean.getType_prod());
            p.setString(11, dataBean.getProduct_id());
            p.setString(12, dataBean.getTotal_weight());
            p.setString(13, dataBean.getBag_weight());
            p.setTimestamp(14, dataBean.getDate());
            p.setString(15, dataBean.getAshes_percent());
            p.setString(16, dataBean.getAshes_weight());
            p.setString(17, dataBean.getDust_percent());
            p.setString(18, dataBean.getDust_weight());
            p.setString(19, dataBean.getVolatile_percent());
            p.setString(20, dataBean.getVolatile_weight());
            p.setString(21, dataBean.getMoise_percent());
            p.setString(22, dataBean.getMoise_weight());
            p.setString(23, dataBean.getContamination_percent());
            p.setString(24, dataBean.getContamination_weight());
            p.setString(25, dataBean.getNet_weight());
            //p.setString(26, dataBean.getRemark());
            p.setString(26, objuti.EncodeNewLine(dataBean.getRemark()));
            p.setString(27, dataBean.getTotal_price());
            p.setString(28, dataBean.getBy());
            p.setString(29, "N");
            p.setString(30, dataBean.getCar_date_in());
            p.setString(31, dataBean.getBag_total());
            p.setString(32, dataBean.getAshes_percent_ch());
            p.setString(33, dataBean.getAshes_weight_ch());
            p.setString(34, dataBean.getDust_percent_ch());
            p.setString(35, dataBean.getDust_weight_ch());
            p.setString(36, dataBean.getVolatile_percent_ch());
            p.setString(37, dataBean.getVolatile_weight_ch());
            p.setString(38, dataBean.getMoise_percent_ch());
            p.setString(39, dataBean.getMoise_weight_ch());
            p.setString(40, dataBean.getContamination_percent_ch());
            p.setString(41, dataBean.getContamination_weight_ch());
            p.setString(42, dataBean.getNet_weight_ch());
            p.setString(43, dataBean.getCar_cbag_weight());
            p.setString(44, dataBean.getCar_weight());
            p.setString(45, dataBean.getBag_net());
            p.setString(46, dataBean.getCarbon_net());
            p.setString(47, dataBean.getBranch_id());
            p.setString(48, dataBean.getPrice_unit());
            p.setString(49, dataBean.getAshes_percent_ch());
            p.setString(50, dataBean.getAshes_weight_ch());
            p.setString(51, dataBean.getDust_percent_ch());
            p.setString(52, dataBean.getDust_weight_ch());
            p.setString(53, dataBean.getVolatile_percent_ch());
            p.setString(54, dataBean.getVolatile_weight_ch());
            p.setString(55, dataBean.getMoise_percent_ch());
            p.setString(56, dataBean.getMoise_weight_ch());
            p.setString(57, dataBean.getContamination_percent_ch());
            p.setString(58, dataBean.getContamination_weight_ch());
            p.setString(59, dataBean.getNet_weight_ch());
            p.setString(60, dataBean.getLab_not_check());
            p.setString(61, dataBean.getFriction_house());
            p.setInt(62, dataBean.getLine_no());
            Returnvalue = p.executeUpdate();

            sql = "select count(location_id) as num from mlocation where location_id ='" + dataBean.getPosition_no() + "' and delete_flag <> 'Y' ";
            if (objuti.numRowdatabase(sql) == 0) {
                sql = "insert into mlocation (location_id,create_by,create_date,name_t,location_type) "
                        + "values (?,?,?,?,?)";
                p = con.prepareStatement(sql);
                p.setString(1, dataBean.getPosition_no());
                p.setString(2, dataBean.getBy());
                p.setTimestamp(3, dataBean.getDate());
                p.setString(4, dataBean.getPosition_no());
                p.setString(5, "R");
                p.executeUpdate();
            }

            Update_Scale_No(dataBean);

        } finally {
            //JOptionPane.showConfirmDialog(null, "test");
            try {
                //p.close();
                con.close();
            } catch (SQLException e) {
                e.printStackTrace(System.out);
            }

        }

        return Returnvalue;
    }

    public int update(DataBean_D_rawmatt_receive dataBean) throws Exception {
        Returnvalue = 0;
        UtiDatabase objuti = new UtiDatabase();
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql
                = //                "update d_rawmatt_receive set  doc_date=?,wh_in=?,supplier_id=?,position_no=?,etc_val=?,scale_no=?,driver_name=?,type_prod=?,product_id=?,update_date=?,ashes_percent=?,ashes_weight=?,dust_percent=?,dust_weight=?,volatile_percent=?,volatile_weight=?,moise_percent=?,moise_weight=?,contamination_percent=?,contamination_weight=?,net_weight=?,remark=?,total_weight=?,bag_weight=?,car_no=?,update_by=?,car_date_in=?,bag_total=?,ashes_percent_ch=?,ashes_weight_ch=?,dust_percent_ch=?,dust_weight_ch=?,volatile_percent_ch=?,volatile_weight_ch=?,moise_percent_ch=?,moise_weight_ch=?,contamination_percent_ch=?,contamination_weight_ch=?,net_weight_ch=?,car_cbag_weight=?,car_weight=?,bag_net=?,carbon_net=?,location_id2=?,price_unit=?,ashes_percent_acc=?,ashes_weight_acc=?,dust_percent_acc=?,dust_weight_acc=?,volatile_percent_acc=?,volatile_weight_acc=?,moise_percent_acc=?,moise_weight_acc=?,contamination_percent_acc=?,contamination_weight_acc=?,net_weight_acc=?,lab_not_check=? where doc_id=? and delete_flag = 'N' and complete_flag = 'N'";
                "update d_rawmatt_receive set  doc_date=?,wh_in=?,supplier_id=?,position_no=?,etc_val=?,scale_no=?,driver_name=?,type_prod=?,product_id=?,update_date=?,ashes_percent=?,ashes_weight=?,dust_percent=?,dust_weight=?,volatile_percent=?,volatile_weight=?,moise_percent=?,moise_weight=?,contamination_percent=?,contamination_weight=?,net_weight=?,total_weight=?,bag_weight=?,car_no=?,update_by=?,car_date_in=?,bag_total=?,ashes_percent_ch=?,ashes_weight_ch=?,dust_percent_ch=?,dust_weight_ch=?,volatile_percent_ch=?,volatile_weight_ch=?,moise_percent_ch=?,moise_weight_ch=?,contamination_percent_ch=?,contamination_weight_ch=?,net_weight_ch=?,car_cbag_weight=?,car_weight=?,bag_net=?,carbon_net=?,location_id2=?,price_unit=?,ashes_percent_acc=?,ashes_weight_acc=?,dust_percent_acc=?,dust_weight_acc=?,volatile_percent_acc=?,volatile_weight_acc=?,moise_percent_acc=?,moise_weight_acc=?,contamination_percent_acc=?,contamination_weight_acc=?,net_weight_acc=?,lab_not_check=?,friction_house=? where doc_id=? and delete_flag = 'N' and complete_flag = 'N'";
        PreparedStatement p;
        try {
            p = con.prepareStatement(sql);

            p.setString(1, dataBean.getDoc_date());
            p.setString(2, dataBean.getWh_in());
            p.setString(3, dataBean.getSupplier_id());
            p.setString(4, dataBean.getPosition_no());
            p.setString(5, dataBean.getEtc_val());
            p.setString(6, dataBean.getScale_no());
            p.setString(7, dataBean.getDriver_name());
            p.setString(8, dataBean.getType_prod());
            p.setString(9, dataBean.getProduct_id());
            p.setTimestamp(10, dataBean.getDate());
            p.setString(11, dataBean.getAshes_percent());
            p.setString(12, dataBean.getAshes_weight());
            p.setString(13, dataBean.getDust_percent());
            p.setString(14, dataBean.getDust_weight());
            p.setString(15, dataBean.getVolatile_percent());
            p.setString(16, dataBean.getVolatile_weight());
            p.setString(17, dataBean.getMoise_percent());
            p.setString(18, dataBean.getMoise_weight());
            p.setString(19, dataBean.getContamination_percent());
            p.setString(20, dataBean.getContamination_weight());
            p.setString(21, dataBean.getNet_weight());
            //p.setString(22, dataBean.getRemark());
            //p.setString(23, dataBean.getTotal_price());
            p.setString(22, dataBean.getTotal_weight());
            p.setString(23, dataBean.getBag_weight());
            p.setString(24, dataBean.getCar_no());
            p.setString(25, dataBean.getBy());
            //____________________
            p.setString(26, dataBean.getCar_date_in());
            p.setString(27, dataBean.getBag_total());
            p.setString(28, dataBean.getAshes_percent_ch());
            p.setString(29, dataBean.getAshes_weight_ch());
            p.setString(30, dataBean.getDust_percent_ch());
            p.setString(31, dataBean.getDust_weight_ch());
            p.setString(32, dataBean.getVolatile_percent_ch());
            p.setString(33, dataBean.getVolatile_weight_ch());
            p.setString(34, dataBean.getMoise_percent_ch());
            p.setString(35, dataBean.getMoise_weight_ch());
            p.setString(36, dataBean.getContamination_percent_ch());
            p.setString(37, dataBean.getContamination_weight_ch());
            p.setString(38, dataBean.getNet_weight_ch());
            p.setString(39, dataBean.getCar_cbag_weight());
            p.setString(40, dataBean.getCar_weight());
            p.setString(41, dataBean.getBag_net());
            p.setString(42, dataBean.getCarbon_net());
            //______________________________________
            p.setString(43, dataBean.getBranch_id());
            p.setString(44, dataBean.getPrice_unit());
            p.setString(45, dataBean.getAshes_percent_ch());
            p.setString(46, dataBean.getAshes_weight_ch());
            p.setString(47, dataBean.getDust_percent_ch());
            p.setString(48, dataBean.getDust_weight_ch());
            p.setString(49, dataBean.getVolatile_percent_ch());
            p.setString(50, dataBean.getVolatile_weight_ch());
            p.setString(51, dataBean.getMoise_percent_ch());
            p.setString(52, dataBean.getMoise_weight_ch());
            p.setString(53, dataBean.getContamination_percent_ch());
            p.setString(54, dataBean.getContamination_weight_ch());
            p.setString(55, dataBean.getNet_weight_ch());
            p.setString(56, dataBean.getLab_not_check());
            p.setString(57, dataBean.getFriction_house());
            //_____________________________________
            p.setString(58, dataBean.getDoc_id());
            Returnvalue = p.executeUpdate();

            sql = "select count(location_id) as num from mlocation where location_id ='" + dataBean.getPosition_no() + "' and delete_flag <> 'Y' ";
            if (objuti.numRowdatabase(sql) == 0) {
                sql = "insert into mlocation (location_id,create_by,create_date,name_t,location_type) "
                        + "values (?,?,?,?,?)";
                p = con.prepareStatement(sql);
                p.setString(1, dataBean.getPosition_no());
                p.setString(2, dataBean.getBy());
                p.setTimestamp(3, dataBean.getDate());
                p.setString(4, dataBean.getPosition_no());
                p.setString(5, "R");
                p.executeUpdate();
            }

            Update_Scale_No(dataBean);
            Update_Car_No(dataBean);

        } finally {
            try {
                //p.close();
                con.close();
            } catch (SQLException e) {
                e.printStackTrace(System.out);
            }

        }
        return Returnvalue;

    }

    public int UpDel(DataBean_D_rawmatt_receive dataBean) throws Exception {
        Returnvalue = 0;
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "update d_rawmatt_receive set delete_flag = ?,delete_date=?,delete_by=? where doc_id=? and delete_flag = 'N' and complete_flag = 'N'";
        PreparedStatement p;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, "Y");
            p.setTimestamp(2, dataBean.getDate());
            p.setString(3, dataBean.getBy());
            p.setString(4, dataBean.getDoc_id());

            Update_Del_Scale_No(dataBean);

            Returnvalue = p.executeUpdate();

        } finally {
            try {
                //p.close();
                con.close();
            } catch (SQLException e) {
                e.printStackTrace(System.out);
            }
        }
        return Returnvalue;
    }

    public int UpCompeteFlag(String doc_id) throws Exception {
        Returnvalue = 0;
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "update d_rawmatt_receive set complete_flag = 'Y' where doc_id=? ";
        PreparedStatement p;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, doc_id);
            Returnvalue = p.executeUpdate();

        } finally {
            try {
                //p.close();
                con.close();
            } catch (SQLException e) {
                e.printStackTrace(System.out);
            }
        }
        return Returnvalue;
    }

    public void update_price(DataBean_D_rawmatt_receive DataBean) throws Exception {
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        PreparedStatement p;
        try {
            p = con.prepareStatement("update d_rawmatt_receive set price_flag = ? ,price_unit=?,total_price=?,update_by=?,update_date=?,payment_method=?,payment_no=?,bank_id=?,text_price=?,cheque_no=?,bank_acc_no=?,net_weight_payment=? where doc_id = ? and delete_flag = 'N' and doc_type = 'Y'");
            p.setString(1, DataBean.getPrice_flag());
            p.setString(2, DataBean.getPrice_unit());
            p.setString(3, DataBean.getTotal_price());
            p.setString(4, DataBean.getBy());
            p.setTimestamp(5, DataBean.getDate());
            p.setString(6, DataBean.getPayment_method());
            p.setString(7, DataBean.getPayment_no());
            p.setString(8, DataBean.getBank_id());
            p.setString(9, DataBean.getText_price());
            p.setString(10, DataBean.getCheque_no());
            p.setString(11, DataBean.getBank_acc_no());
            p.setString(12, DataBean.getNet_weight());
            p.setString(13, DataBean.getDoc_id());
            p.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace(System.out);
        } finally {
            if (con != null) {
                con.close();
            }
        }
    }

    public void Update_Acc(DataBean_D_rawmatt_receive DataBean) throws Exception {
        Connection con = new DBConnect().openNewConnection();
        PreparedStatement p;
        try {
            p = con.prepareStatement("Update d_rawmatt_receive set ashes_percent_acc=?,ashes_weight_acc=?,dust_percent_acc=?,dust_weight_acc=?,volatile_percent_acc=?,volatile_weight_acc=?,moise_percent_acc=?,moise_weight_acc=?,contamination_percent_acc=?,contamination_weight_acc=?,net_weight_acc=?"
                    + " Where doc_id =? and delete_flag = 'N' ");
            p.setString(1, DataBean.getAshes_percent());
            p.setString(2, DataBean.getAshes_weight());
            p.setString(3, DataBean.getDust_percent());
            p.setString(4, DataBean.getDust_weight());
            p.setString(5, DataBean.getVolatile_percent());
            p.setString(6, DataBean.getVolatile_weight());
            p.setString(7, DataBean.getMoise_percent());
            p.setString(8, DataBean.getMoise_weight());
            p.setString(9, DataBean.getContamination_percent());
            p.setString(10, DataBean.getContamination_weight());
            p.setString(11, DataBean.getNet_weight());
            p.setString(12, DataBean.getDoc_id());
            p.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace(System.out);
        } finally {
            if (con != null) {
                con.close();
            }
        }
    }

    public String At_Payment(String doc_id) throws Exception {
        Connection con = new DBConnect().openNewConnection();
        ResultSet rs = null;
        String str_return = null;
        try {
            rs = con.createStatement().executeQuery("Select net_weight_acc from d_rawmatt_receive where doc_id = '" + doc_id + "' and delete_flag = 'N' ");
            while (rs.next()) {
                str_return = rs.getString("net_weight_acc");
            }
        } catch (SQLException e) {
            e.printStackTrace(System.out);
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return str_return;
    }

    public int Update_Scale_No(DataBean_D_rawmatt_receive DataBean) throws Exception {
        Returnvalue = 0;
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "update d_ticketbuy_carbon set remark = ?,complete_flag='Y' where ticket_text = ? ";
        PreparedStatement p;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, DataBean.getDoc_id());
            p.setString(2, DataBean.getScale_no());
            Returnvalue = p.executeUpdate();

        } finally {
            try {
                //p.close();
                con.close();
            } catch (SQLException e) {
                e.printStackTrace(System.out);
            }
        }
        return Returnvalue;
    }
    
    public int Update_Car_No(DataBean_D_rawmatt_receive DataBean) throws Exception {
        Returnvalue = 0;
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "update d_rawmatt_analyze_header set car_no = ? , car_date_in = ? , sender_id = ? where doc_id = ? ";
        
        PreparedStatement p;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, DataBean.getCar_no());
            p.setString(2, DataBean.getCar_date_in());
            p.setString(3, DataBean.getSupplier_id());            
            p.setString(4, DataBean.getDoc_id());            
            Returnvalue = p.executeUpdate();
        } finally {
            try {
                //p.close();
                con.close();
            } catch (SQLException e) {
                e.printStackTrace(System.out);
            }
        }
        return Returnvalue;
    }    

    public int Update_Del_Scale_No(DataBean_D_rawmatt_receive DataBean) throws Exception {
        Returnvalue = 0;
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "update d_ticketbuy_carbon set remark = '-',complete_flag='N' where ticket_text = ? ";
        PreparedStatement p;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, DataBean.getScale_no());
            System.out.println("Update Del = " + sql + " DataBean.getScale_no() = " + DataBean.getScale_no());
            Returnvalue = p.executeUpdate();

        } finally {
            try {
                //p.close();
                con.close();
            } catch (SQLException e) {
                e.printStackTrace(System.out);
            }
        }
        return Returnvalue;
    }

}
