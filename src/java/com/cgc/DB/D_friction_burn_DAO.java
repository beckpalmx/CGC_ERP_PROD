package com.cgc.DB;

import com.cgc.bean.DataBeanD_carbon_friction_burn;
import java.sql.*;

public class D_friction_burn_DAO {

    private int Returnvalue;

    public int insert(DataBeanD_carbon_friction_burn dataBean) throws Exception {
        Returnvalue = 0;
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        String sql = "insert into d_carbon_friction_burn_detail "
                + "(doc_id,doc_date,product_id,weight_carbon_in,weight_carbon_friction,weight_carbon_dust,"
                + "weight_carbon_iron,weight_carbon_total,"
                + "weight_carbon_bigbag,weight_carbon_burn_in,"
                + "weight_carbon_real_lost,percent_carbon_real_lost,"
                + "weight_carbon_lost,percent_carbon_lost,burn_no,channel,"
                + "wh_id,location_id,remark,percent_moisture,rawmat_emp_id,product_emp_id,"
                + "create_date,create_by,"                
                + "weight_carbon_burn_in_2,weight_carbon_burn_in_3,weight_carbon_burn_in_4,weight_carbon_burn_in_5,"
                + "channel_2,channel_3,channel_4,channel_5,burn_no_2,burn_no_3,burn_no_4,burn_no_5,weight_carbon_burn_in_total,"                
                + "burn_date_1,burn_date_2,burn_date_3,burn_date_4,burn_date_5,"                                
                + "burn_date_6,burn_date_7,burn_date_8,burn_date_9,burn_date_10,"      
                + "channel_6,channel_7,channel_8,channel_9,channel_10,burn_no_6,burn_no_7,burn_no_8,burn_no_9,burn_no_10,"
                + "weight_carbon_burn_in_6,weight_carbon_burn_in_7,weight_carbon_burn_in_8,weight_carbon_burn_in_9,weight_carbon_burn_in_10)"
                + "values(?,?,?,?,?,?,?,?,?,?,"
                + "?,?,?,?,?,?,?,?,?,?,"
                + "?,?,?,?,?,?,?,?,?,?,"                
                + "?,?,?,?,?,?,?,"
                + "?,?,?,?,?,"              
                + "?,?,?,?,?,"
                + "?,?,?,?,?,?,?,?,?,?,"
                + "?,?,?,?,?)";
        
        System.out.println("Insert sql = " + sql );
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getDoc_id());
            p.setString(2, dataBean.getDoc_date());
            p.setString(3, dataBean.getProduct_id());
            p.setString(4, dataBean.getWeight_carbon_in());
            p.setString(5, dataBean.getWeight_carbon_friction());
            p.setString(6, dataBean.getWeight_carbon_dust());
            p.setString(7, dataBean.getWeight_carbon_iron());
            p.setString(8, dataBean.getWeight_carbon_total());
            p.setString(9, dataBean.getWeight_carbon_bigbag());
            p.setString(10, dataBean.getWeight_carbon_burn_in());
            p.setString(11, dataBean.getWeight_carbon_real_lost());
            p.setString(12, dataBean.getPercent_carbon_real_lost());
            p.setString(13, dataBean.getWeight_carbon_lost());
            p.setString(14, dataBean.getPercent_carbon_lost());
            p.setString(15, dataBean.getBurn_no());
            p.setString(16, dataBean.getChannel());   
            p.setString(17, dataBean.getWh_id());   
            p.setString(18, dataBean.getLocation_id());   
            p.setString(19, dataBean.getRemark());   
            p.setString(20, dataBean.getPercent_moisture());   
            p.setString(21, dataBean.getRawmat_emp_id());   
            p.setString(22, dataBean.getProduct_emp_id());   
            p.setTimestamp(23, dataBean.getDate());
            p.setString(24, dataBean.getBy());            
            p.setString(25, dataBean.getWeight_carbon_burn_in_2());      
            p.setString(26, dataBean.getWeight_carbon_burn_in_3());      
            p.setString(27, dataBean.getWeight_carbon_burn_in_4());      
            p.setString(28, dataBean.getWeight_carbon_burn_in_5());      
            p.setString(29, dataBean.getChannel_2());      
            p.setString(30, dataBean.getChannel_3());      
            p.setString(31, dataBean.getChannel_4());      
            p.setString(32, dataBean.getChannel_5());      
            p.setString(33, dataBean.getBurn_no_2());      
            p.setString(34, dataBean.getBurn_no_3());      
            p.setString(35, dataBean.getBurn_no_4());      
            p.setString(36, dataBean.getBurn_no_5());      
            p.setString(37, dataBean.getWeight_carbon_burn_in_total());                  
            p.setString(38, dataBean.getBurn_date_1());  
            p.setString(39, dataBean.getBurn_date_2());  
            p.setString(40, dataBean.getBurn_date_3());  
            p.setString(41, dataBean.getBurn_date_4());  
            p.setString(42, dataBean.getBurn_date_5());
            p.setString(43, dataBean.getBurn_date_6());  
            p.setString(44, dataBean.getBurn_date_7());  
            p.setString(45, dataBean.getBurn_date_8());  
            p.setString(46, dataBean.getBurn_date_9());  
            p.setString(47, dataBean.getBurn_date_10());        
            p.setString(48, dataBean.getChannel_6());                  
            p.setString(49, dataBean.getChannel_7());      
            p.setString(50, dataBean.getChannel_8());      
            p.setString(51, dataBean.getChannel_9());      
            p.setString(52, dataBean.getChannel_10());                  
            p.setString(53, dataBean.getBurn_no_6());                  
            p.setString(54, dataBean.getBurn_no_7());      
            p.setString(55, dataBean.getBurn_no_8());      
            p.setString(56, dataBean.getBurn_no_9());      
            p.setString(57, dataBean.getBurn_no_10());      
            p.setString(58, dataBean.getWeight_carbon_burn_in_6());      
            p.setString(59, dataBean.getWeight_carbon_burn_in_7());      
            p.setString(60, dataBean.getWeight_carbon_burn_in_8());      
            p.setString(61, dataBean.getWeight_carbon_burn_in_9());      
            p.setString(62, dataBean.getWeight_carbon_burn_in_10());                  
            
            //p.setString(25, dataBean.getComplete_flag());  
            Returnvalue = p.executeUpdate();
        } finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }

        }

        return Returnvalue;
    }

    public int update(DataBeanD_carbon_friction_burn dataBean) throws Exception {
        Returnvalue = 0;
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "update d_carbon_friction_burn_detail set "
                + "product_id=?,weight_carbon_in=?,weight_carbon_friction=?,weight_carbon_dust=?,"
                + "weight_carbon_iron=?,weight_carbon_total=?,weight_carbon_bigbag=?,weight_carbon_burn_in=?,"
                + "weight_carbon_real_lost=?,percent_carbon_real_lost=?,weight_carbon_lost=?,percent_carbon_lost=?,"
                + "burn_no=?,channel=?,wh_id=?,location_id=?,remark=?,percent_moisture=?,rawmat_emp_id=?,product_emp_id=?,"
                + "update_date=?,update_by=?,complete_flag=?,"
                + "weight_carbon_burn_in_2=?,weight_carbon_burn_in_3=?,weight_carbon_burn_in_4=?,weight_carbon_burn_in_5=?,"
                + "channel_2=?,channel_3=?,channel_4=?,channel_5=?,burn_no_2=?,burn_no_3=?,burn_no_4=?,burn_no_5=?,weight_carbon_burn_in_total=?,"                
                + "burn_date_1=?,burn_date_2=?,burn_date_3=?,burn_date_4=?,burn_date_5=?,"
                + "burn_date_6=?,burn_date_7=?,burn_date_8=?,burn_date_9=?,burn_date_10=?,"
                + "channel_6=?,channel_7=?,channel_8=?,channel_9=?,channel_10=?,"
                + "burn_no_6=?,burn_no_7=?,burn_no_8=?,burn_no_9=?,burn_no_10=?,"
                + "weight_carbon_burn_in_6=?,weight_carbon_burn_in_7=?,weight_carbon_burn_in_8=?,weight_carbon_burn_in_9=?,weight_carbon_burn_in_10=? "                
                + "where doc_id=? and delete_flag = 'N' and complete_flag = 'N'";            
        
        System.out.println("Update sql = " + sql );        
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);            
            p.setString(1, dataBean.getProduct_id());
            p.setString(2, dataBean.getWeight_carbon_in());
            p.setString(3, dataBean.getWeight_carbon_friction());
            p.setString(4, dataBean.getWeight_carbon_dust());
            p.setString(5, dataBean.getWeight_carbon_iron());
            p.setString(6, dataBean.getWeight_carbon_total());
            p.setString(7, dataBean.getWeight_carbon_bigbag());
            p.setString(8, dataBean.getWeight_carbon_burn_in());
            p.setString(9, dataBean.getWeight_carbon_real_lost());
            p.setString(10, dataBean.getPercent_carbon_real_lost());
            p.setString(11, dataBean.getWeight_carbon_lost());
            p.setString(12, dataBean.getPercent_carbon_lost());
            p.setString(13, dataBean.getBurn_no());
            p.setString(14, dataBean.getChannel());   
            p.setString(15, dataBean.getWh_id());   
            p.setString(16, dataBean.getLocation_id());   
            p.setString(17, dataBean.getRemark());   
            p.setString(18, dataBean.getPercent_moisture());   
            p.setString(19, dataBean.getRawmat_emp_id());   
            p.setString(20, dataBean.getProduct_emp_id());   
            p.setTimestamp(21, dataBean.getDate());
            p.setString(22, dataBean.getBy());      
            p.setString(23, dataBean.getComplete_flag());  
            p.setString(24, dataBean.getWeight_carbon_burn_in_2());      
            p.setString(25, dataBean.getWeight_carbon_burn_in_3());      
            p.setString(26, dataBean.getWeight_carbon_burn_in_4());      
            p.setString(27, dataBean.getWeight_carbon_burn_in_5());      
            p.setString(28, dataBean.getChannel_2());      
            p.setString(29, dataBean.getChannel_3());      
            p.setString(30, dataBean.getChannel_4());      
            p.setString(31, dataBean.getChannel_5());      
            p.setString(32, dataBean.getBurn_no_2());      
            p.setString(33, dataBean.getBurn_no_3());      
            p.setString(34, dataBean.getBurn_no_4());      
            p.setString(35, dataBean.getBurn_no_5());      
            p.setString(36, dataBean.getWeight_carbon_burn_in_total());                  
            p.setString(37, dataBean.getBurn_date_1());  
            p.setString(38, dataBean.getBurn_date_2());  
            p.setString(39, dataBean.getBurn_date_3());  
            p.setString(40, dataBean.getBurn_date_4());  
            p.setString(41, dataBean.getBurn_date_5());            
            p.setString(42, dataBean.getBurn_date_6());  
            p.setString(43, dataBean.getBurn_date_7());  
            p.setString(44, dataBean.getBurn_date_8());  
            p.setString(45, dataBean.getBurn_date_9());  
            p.setString(46, dataBean.getBurn_date_10());        
            p.setString(47, dataBean.getChannel_6());                  
            p.setString(48, dataBean.getChannel_7());      
            p.setString(49, dataBean.getChannel_8());      
            p.setString(50, dataBean.getChannel_9());      
            p.setString(51, dataBean.getChannel_10());                  
            p.setString(52, dataBean.getBurn_no_6());                  
            p.setString(53, dataBean.getBurn_no_7());      
            p.setString(54, dataBean.getBurn_no_8());      
            p.setString(55, dataBean.getBurn_no_9());      
            p.setString(56, dataBean.getBurn_no_10());      
            p.setString(57, dataBean.getWeight_carbon_burn_in_6());      
            p.setString(58, dataBean.getWeight_carbon_burn_in_7());      
            p.setString(59, dataBean.getWeight_carbon_burn_in_8());      
            p.setString(60, dataBean.getWeight_carbon_burn_in_9());      
            p.setString(61, dataBean.getWeight_carbon_burn_in_10());               
            p.setString(62, dataBean.getDoc_id());                  
            Returnvalue = p.executeUpdate();
        } finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }

        }
        return Returnvalue;

    }

    public int UpDel(DataBeanD_carbon_friction_burn dataBean) throws Exception {
        Returnvalue = 0;
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "update d_carbon_friction_burn_detail set delete_flag = ?,delete_date=?,delete_by=? where doc_id=? and delete_flag = 'N' and complete_flag = 'N'";
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, "Y");
            p.setTimestamp(2, dataBean.getDate());
            p.setString(3, dataBean.getBy());
            p.setString(4, dataBean.getDoc_id());
            Returnvalue = p.executeUpdate();

        } finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
        }
        return Returnvalue;
    }
    public int UpCompeteFlag(String doc_id) throws Exception {
        Returnvalue = 0;
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "update d_carbon_friction_burn_detail set complete_flag = 'Y' where doc_id=? ";
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, doc_id);
            Returnvalue = p.executeUpdate();

        } finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
        }
        return Returnvalue;
    }
}
