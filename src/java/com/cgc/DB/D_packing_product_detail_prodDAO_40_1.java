/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.cgc.DB;

import com.cgc.Util.ThaiUtil;
import com.cgc.Util.UtiDatabase;
import com.cgc.bean.DataBeanD_packing_product_detail_prod;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


/**
 *
 * @author Beckpalmx No7
 */
public class D_packing_product_detail_prodDAO_40_1 {
    private int Returnvalue;

    public int insert(DataBeanD_packing_product_detail_prod dataBean) throws Exception {
        Returnvalue = 0;
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        String sql = "insert into d_packing_product_detail_prod "
                + "(doc_id,line_no,wh_id,product_id,size,i2,bag,weight,remark,create_date,create_by,weight_unit,product_no,pack_repacking_status,carbon_trap_status,doc_type) "
                + "values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getDoc_id());
            p.setString(2, dataBean.getLine_no());
            p.setString(3, dataBean.getWh_id());
            p.setString(4, dataBean.getProduct_id());
            p.setString(5, dataBean.getSize());
            p.setString(6, dataBean.getI2());
            p.setString(7, dataBean.getBag());
            p.setString(8, dataBean.getWeight());
            p.setString(9, dataBean.getRemark());
            p.setTimestamp(10, dataBean.getDate());
            p.setString(11, dataBean.getBy());
            p.setString(12, dataBean.getWeight_unit());
            p.setString(13, dataBean.getProduct_no());            
            p.setString(14, dataBean.getPack_repacking_status());
            p.setString(15, dataBean.getCarbon_trap_status());
            p.setString(16, dataBean.getDoc_type());
            Returnvalue = p.executeUpdate();
        } finally {
            //JOptionPane.showConfirmDialog(null, "test");
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }

        }

        return Returnvalue;
    }

    public int update(DataBeanD_packing_product_detail_prod dataBean) throws Exception {
        Returnvalue = 0;
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql =
                "update d_packing_product_detail_prod set  "
                + "update_date=?,update_by=?,doc_type=?  "
                + ",pack_repacking_status=?,carbon_trap_status=? "
                + "where doc_id=? and line_no=? and delete_flag <> 'Y'";
        System.out.println("SQL Update Detail Prod = "  + sql);
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            p.setTimestamp(1, dataBean.getDate());
            p.setString(2, dataBean.getBy());            
            p.setString(3, dataBean.getDoc_type());
            p.setString(4, dataBean.getPack_repacking_status());
            p.setString(5, dataBean.getCarbon_trap_status());
            p.setString(6, dataBean.getDoc_id());
            p.setString(7, dataBean.getLine_no());
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

    public DataBeanD_packing_product_detail_prod ReturnEdit(String Doc_id, String Line_no, DataBeanD_packing_product_detail_prod bean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        //JOptionPane.showConfirmDialog(null, Doc_id);

        String SQL = "Select doc_id,line_no,wh_id,product_id,size,i2,bag,weight,remark,weight_unit,product_no,warehouse_name,"
                + "(select m_carbon_size.name_t from m_carbon_size where m_carbon_size.size_id = to_number(vd_packing_product_detail_prod.size,'99999')) as size_name,pack_repacking_status,carbon_trap_status,doc_type"
                + " from vd_packing_product_detail_prod "
                + "where doc_id = '" + Doc_id + "' and line_no ='" + Line_no + "' and delete_flag <> 'Y' ";
        ResultSet  rs = con.createStatement().executeQuery(SQL);
        try {
            while (rs.next()) {
                bean.setDoc_id(rs.getString("doc_id"));
                bean.setLine_no(rs.getString("line_no"));
                bean.setWh_id(rs.getString("wh_id"));
                bean.setProduct_id(rs.getString("product_id"));
                bean.setSize(rs.getString("size"));
                bean.setI2(rs.getString("i2"));
                bean.setBag(rs.getString("bag"));
                bean.setWeight(rs.getString("weight"));
                bean.setRemark(rs.getString("remark"));
                bean.setWeight_unit(rs.getString("weight_unit"));
                bean.setProduct_no(rs.getString("product_no"));
                bean.setSize_name(rs.getString("size_name"));
                bean.setWh_name(rs.getString("warehouse_name"));
                bean.setPack_repacking_status(rs.getString("pack_repacking_status"));
                bean.setCarbon_trap_status(rs.getString("carbon_trap_status"));
                bean.setDoc_type(rs.getString("doc_type"));
                System.out.println("pack_repacking_status = " + rs.getString("pack_repacking_status"));
                System.out.println("carbon_trap_status = " + rs.getString("carbon_trap_status"));
            }
        } finally {
            try {
                rs.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
        }
        //JOptionPane.showConfirmDialog(null, bean.getDoc_id());
        return bean;
    }
    //ทำการลบ Line_no ตามบรรทัดที่เลื่อกแล้วทำการ update ข

    public String DeleteLine_no(String inputarry, DataBeanD_packing_product_detail_prod bean) throws Exception {
        UtiDatabase objuti = new UtiDatabase();
        boolean ckclose = false;
        boolean pclose = false;
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        int count = 1;
        String strTotal="0,0";
        int total = 0;
        int total2 = 0;
        ResultSet rs = null;
        PreparedStatement p = null;
        String sql, sql2 = "";
        try {

            if (inputarry.length() != 0) {
                String[] strarry = inputarry.split(",");
                for (int i = 0; i < strarry.length; i++) {

                    sql = "update d_packing_product_detail_prod set delete_flag=?,delete_date=?,delete_by=? where doc_id=? and line_no=? and delete_flag <> 'Y' and complete_flag <> 'Y'";
                    p = con.prepareStatement(sql);
                    p.setString(1, "Y");
                    p.setTimestamp(2, bean.getDate());
                    p.setString(3, bean.getBy());
                    p.setString(4, bean.getDoc_id());
                    p.setString(5, strarry[i]);
                    p.executeUpdate();
                }
                pclose = true;
                if (strarry.length != -1) {
                    sql = "select count(doc_id) as num from d_packing_product_detail_prod where doc_id ='" + bean.getDoc_id() + "' and delete_flag <> 'Y' and complete_flag <> 'Y'";
                    if(objuti.numRowdatabase(sql) != 0){
                    p = null;
                    sql2 = "Select line_no,runno from  d_packing_product_detail_prod where doc_id ='" + bean.getDoc_id() + "' and delete_flag <> 'Y' and complete_flag <> 'Y' order by runno ";
                    rs = con.createStatement().executeQuery(sql2);
                    while (rs.next()) {
                        sql = "update d_packing_product_detail_prod set line_no=? where doc_id=? and line_no=? and runno=?";
                        p = con.prepareStatement(sql);
                        p.setString(1, Integer.toString(count));
                        p.setString(2, bean.getDoc_id());
                        p.setString(3, rs.getString("line_no"));
                        p.setInt(4, rs.getInt("runno"));
                        p.executeUpdate();
                        count = count + 1;
                    }
                    sql2= "select bag,weight from d_packing_product_detail_prod where doc_id ='" + bean.getDoc_id() + "' and delete_flag <> 'Y' and complete_flag <> 'Y' order by runno ";
                    rs = null;
                    rs = con.createStatement().executeQuery(sql2);
                    while(rs.next())
                    {
                        total = total + Integer.parseInt(rs.getString("bag"));
                        total2 = total2+Integer.parseInt(rs.getString("weight"));
                    }
                    strTotal = Integer.toString(total) +","+ Integer.toString(total2);
                    ckclose = true;
                    }else{
                        strTotal="0,0";
                    }
                }

            }else{
                strTotal="-1";
            }

        } finally {
            try {
                if (ckclose) {
                    rs.close();
                }
                if(pclose){
                    p.close();
                    con.close();
                }
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
        }
        return strTotal;
        //JOptionPane.showConfirmDialog(null, total);

    }

    public String Delete_line_no_All(DataBeanD_packing_product_detail_prod dataBean) throws Exception {
        String strTotal="0,0";
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sqldetail = "update d_packing_product_detail_prod set delete_flag = ?,delete_date=?,delete_by=? where doc_id=? and delete_flag <> 'Y' and complete_flag <> 'Y'";
        PreparedStatement p = null;
        try {

            p = con.prepareStatement(sqldetail);
            p.setString(1, "Y");
            p.setTimestamp(2, dataBean.getDate());
            p.setString(3, dataBean.getBy());
            p.setString(4, dataBean.getDoc_id());
            p.executeUpdate();

        } finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
        }
        return strTotal;
    }
    public String showDetail(String doc_id)throws Exception{
        ThaiUtil objth = new ThaiUtil();
        UtiDatabase objuti = new UtiDatabase();
        String SQL1,SQL = "";
        String strOutput = "";
        System.out.println("2 doc_id = " + doc_id);
        strOutput += "<table width='100%' align='center' border='0' cellpadding='0' cellspacing='1' class='inner'>";
        
        strOutput += "<tr>";
        strOutput += "<td class=\"row3\" width=\"3%\"><input type=\"checkbox\" name=\"chk_all2\" value=\"chk_all2\" id=\"chk_all2\" onClick=\"javascript:ckall2(this.checked);\"/></td>";
        strOutput += "<td class=\"row3\" width=\"7%\">ลำดับ&nbsp;</td>";
        strOutput += "<td class=\"row3\" width=\"15%\">คลัง&nbsp;</td>";
        strOutput += "<td class=\"row3\" width=\"10%\">ชนิดถ่าน&nbsp;</td>";
        strOutput += "<td class=\"row3\" width=\"10%\">ขนาด&nbsp;</td>";
        strOutput += "<td class=\"row3\" width=\"5%\">I2&nbsp;</td>";
        strOutput += "<td class=\"row3\" width=\"10%\">รหัสผลิต&nbsp;</td>";
        strOutput += "<td class=\"row3\" width=\"15%\">น้ำหนัก/หน่วย<br>(กิโลกรัม)&nbsp;</td>";
        strOutput += "<td class=\"row3\" width=\"10%\">จำนวนถุง&nbsp;</td>";
        strOutput += "<td class=\"row3\" width=\"15%\">น้ำหนัก<br>(กิโลกรัม)&nbsp;</td>";
        strOutput += "<td class=\"row3\" width=\"3%\"><br>&nbsp;</td>";
        strOutput += "</tr>";                
        
        //SQL1 = "Select Count(doc_id) As num from  d_packing_product_detail_prod where doc_id ='"+objth.EncodeTexttoTIS(doc_id)+"' and delete_flag <> 'Y' and complete_flag <> 'Y' ";
        SQL1 = "Select Count(doc_id) As num from  d_packing_product_detail_prod where doc_id ='"+objth.EncodeTexttoTIS(doc_id)+"' and delete_flag <> 'Y' ";
        int a = objuti.numRowdatabase(SQL1);
	//SQL = "Select doc_id,line_no,wh_id,product_id,size,i2,bag,weight,size_desc,weight_unit,warehouse_name,product_no,pack_repacking_status,carbon_trap_status,doc_type from vd_packing_product_detail_prod where doc_id ='"+objth.EncodeTexttoTIS(doc_id)+"' and delete_flag <> 'Y' and complete_flag <> 'Y' order by runno";
	SQL = "Select doc_id,line_no,wh_id,product_id,size,i2,bag,weight,size_desc,weight_unit,warehouse_name,product_no,pack_repacking_status,carbon_trap_status,doc_type from vd_packing_product_detail_prod where doc_id ='"+objth.EncodeTexttoTIS(doc_id)+"' and delete_flag <> 'Y' order by runno";
        System.out.println("SQL1 = " + SQL1);
        System.out.println("SQL = " + SQL);
        DBConnect objcon = new DBConnect();
	Connection con =objcon.openNewConnection();
	ResultSet rs = null;
        rs =con.createStatement().executeQuery(SQL);
	while(rs.next())
	{

	strOutput += "<tr>";
        strOutput += "<td class='forborder' width='3px'><input type='checkbox' id='ckbox2' name='ckbox2' onclick=\"cancle_chkboxAll('chk_all2',this.checked)\"></td>";
        strOutput += "<td class='forborder' width='7%'><a href=\"#\"  class='link_data_transparent' onclick=\"OpenEdit(URLsend('line_no_"+rs.getString("line_no")+",doc_id,total_bag,total_weight,username','../SCREEN/CS_044_1.jsp'))\"><input type='hidden' id='line_no_"+rs.getString("line_no")+"' value=\""+rs.getString("line_no")+"\"><input type='hidden' id='doc_id' value=\""+rs.getString("doc_id")+"\">"+rs.getString("line_no")+"</a></td>";
        strOutput += "<td class='forborder' width='15%'>"+rs.getString("warehouse_name")+"&nbsp;</td>";
        strOutput += "<td class='forborder' width='10%'>"+rs.getString("product_id")+"&nbsp;</td>";
        strOutput += "<td class='forborder' width='10%'>"+rs.getString("size_desc")+"&nbsp;</td>";
	strOutput += "<td class='forborder' width='5%'>"+rs.getString("i2")+"&nbsp;</td>";
        strOutput += "<td class='forborder' width='10%'>"+rs.getString("product_no")+"&nbsp;</td>";
        strOutput += "<td class='forborder' width='15%'>"+rs.getString("weight_unit")+"&nbsp;</td>";
        strOutput += "<td class='forborder' width='10%'>"+rs.getString("bag")+"&nbsp;</td>";        
        strOutput += "<td class='forborder' width='15%'>"+rs.getString("weight")+"&nbsp;</td>";
        strOutput += "<td class='forborder' width='3%'>"+rs.getString("doc_type")+"&nbsp;</td>";                
	strOutput += "</tr>";
	}
	rs.close();
        con.close();
        strOutput += "</table>";
        return strOutput;

    }
}
