/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.cgc.DB;

import com.cgc.Util.ThaiUtil;
import com.cgc.Util.UtiDatabase;
import com.cgc.bean.DataBeanD_carbon_withdraw_detail;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author Beck
 */
public class D_carbon_withdraw_detail_whDAO {
    private int Returnvalue;

    public int insert(DataBeanD_carbon_withdraw_detail dataBean) throws Exception {
        Returnvalue = 0;
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        String sql = "insert into d_carbon_withdraw_detail_wh (doc_id,line_no,pcat_id,size_use,grd_io_ctc,weight,machine,job_id,remark,create_date,create_by,bag,palate_no,wh_id,location_id,product_id) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getDoc_id());
            p.setString(2, dataBean.getLine_no());
            p.setString(3, dataBean.getPcat_id());
            p.setString(4, dataBean.getSize_use());
            p.setString(5, dataBean.getGrd_io_ctc());
            p.setString(6, dataBean.getWeight());
            p.setString(7, dataBean.getMachine());
            p.setString(8, dataBean.getJob_id());
            p.setString(9, dataBean.getRemark());
            p.setTimestamp(10, dataBean.getDate());
            p.setString(11, dataBean.getBy());
            p.setString(12,dataBean.getBag());
            p.setString(13, dataBean.getPalate_no());
            p.setString(14, dataBean.getWh_id());
            p.setString(15, dataBean.getLocation_id());
            p.setString(16, dataBean.getProduct_id());
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

    public int update(DataBeanD_carbon_withdraw_detail dataBean) throws Exception {
        Returnvalue = 0;
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();

        String sql =
                "update d_carbon_withdraw_detail_wh set  pcat_id=?,size_use=?,grd_io_ctc=?,weight=?,machine=?,job_id=?,remark=?,update_date=?,bag=?,update_by=?,palate_no=?,wh_id=?,location_id=?,product_id=? where doc_id=? and line_no=? and delete_flag <> 'Y' and complete_flag <> 'Y'";
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            //p.setString(1, dataBean.getDoc_date());
            p.setString(1, dataBean.getPcat_id());
            p.setString(2, dataBean.getSize_use());
            p.setString(3, dataBean.getGrd_io_ctc());
            p.setString(4, dataBean.getWeight());
            p.setString(5, dataBean.getMachine());
            p.setString(6, dataBean.getJob_id());
            p.setString(7, dataBean.getRemark());
            p.setTimestamp(8, dataBean.getDate());
            p.setString(9, dataBean.getBag());
            p.setString(10, dataBean.getBy());
            p.setString(11, dataBean.getPalate_no());
            p.setString(12, dataBean.getWh_id());
            p.setString(13, dataBean.getLocation_id()); 
            p.setString(14, dataBean.getProduct_id());
            p.setString(15, dataBean.getDoc_id());
            p.setString(16, dataBean.getLine_no());
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

    public DataBeanD_carbon_withdraw_detail ReturnEdit(String Doc_id, String Line_no, DataBeanD_carbon_withdraw_detail bean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        //JOptionPane.showConfirmDialog(null, "test");
        String SQL = "Select doc_id,doc_date,line_no,pcat_id,cat_name,size_use,grd_io_ctc,weight,machine,remark,vd_carbon_withdraw_detail_wh.job_id,bag,(select vd_job_order_header.cust_name from vd_job_order_header where vd_job_order_header.doc_id = vd_carbon_withdraw_detail_wh.job_id) as cust_name,palate_no,wh_id,location_id,product_id"
                + ",(select wh.name_t from mwarehouse wh where wh.warehouse_id = vd_carbon_withdraw_detail_wh.wh_id and wh.delete_flag <> 'Y') as wh_id_desc  from vd_carbon_withdraw_detail_wh where doc_id = '" + Doc_id + "' and line_no ='" + Line_no + "' and delete_flag <> 'Y' and complete_flag <> 'Y'";
        System.out.println("SQL = " + SQL);
        ResultSet rs = con.createStatement().executeQuery(SQL);
        try {
            while (rs.next()) {
                bean.setDoc_id(rs.getString("doc_id"));
                bean.setDoc_date(rs.getString("doc_date"));
                bean.setLine_no(rs.getString("line_no"));
                bean.setPcat_id(rs.getString("pcat_id"));
                bean.setCat_name(rs.getString("cat_name"));
                bean.setSize_use(rs.getString("size_use"));
                bean.setGrd_io_ctc(rs.getString("grd_io_ctc"));
                bean.setWeight(rs.getString("weight"));
                bean.setMachine(rs.getString("machine"));
                bean.setRemark(rs.getString("remark"));
                bean.setJob_id(rs.getString("job_id"));
                bean.setBag(rs.getString("bag"));
                bean.setCust_name(rs.getString("cust_name"));
                bean.setPalate_no(rs.getString("palate_no"));
                bean.setWh_id(rs.getString("wh_id"));
                //bean.setWh_id(rs.getString("wh_id").equals("")||rs.getString("wh_id")==null?"-":rs.getString("wh_id"));
                //bean.setLocation_id(rs.getString("location_id").equals("")||rs.getString("location_id")==null?"-":rs.getString("location_id"));
                bean.setLocation_id(rs.getString("location_id"));
                bean.setProduct_id(rs.getString("product_id"));
                bean.setWh_id_desc(rs.getString("wh_id_desc"));
                //bean.setWh_id_desc(rs.getString("wh_id_desc").equals("")||rs.getString("wh_id_desc")==null?"-":rs.getString("wh_id_desc"));
            }
        } finally {
            try {
                rs.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
        }
        return bean;
    }
    //ทำการลบ Line_no ตามบรรทัดที่เลื่อกแล้วทำการ update ข

    public void DeleteLine_no(String inputarry, DataBeanD_carbon_withdraw_detail bean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        boolean rclose = false;
        boolean pclose = false;
        int count = 1;
        ResultSet rs = null;
        PreparedStatement p = null;
        String sql, sql2 = "";
        try {
            if (inputarry.length() != 0) {
                String[] strarry = inputarry.split(",");
                for (int i = 0; i < strarry.length; i++) {
                    sql = "update d_carbon_withdraw_detail_wh set delete_flag=?,delete_date=?,delete_by=? where doc_id=? and line_no=? and delete_flag <> 'Y' and complete_flag <> 'Y'";
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
                    p = null;
                    sql2 = "Select line_no from  d_carbon_withdraw_detail_wh where doc_id ='" + bean.getDoc_id() + "' and delete_flag <> 'Y' and complete_flag <> 'Y' order by runno ";
                    rs = con.createStatement().executeQuery(sql2);
                    while (rs.next()) {
                        sql = "update d_carbon_withdraw_detail_wh set line_no=? where doc_id=? and line_no=?";
                        p = con.prepareStatement(sql);
                        p.setString(1, Integer.toString(count));
                        p.setString(2, bean.getDoc_id());
                        p.setString(3, rs.getString("line_no"));
                        p.executeUpdate();
                        count = count + 1;
                    }
                    rclose = true;
                }
            }
        } finally {
            try {
                if (rclose)
                {
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

    }

    public void Delete_line_no_All(DataBeanD_carbon_withdraw_detail dataBean) throws Exception {

        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sqldetail = "update d_carbon_withdraw_detail_wh set delete_flag = ?,delete_date=?,delete_by=? where doc_id=? and delete_flag <> 'Y' and complete_flag <> 'Y'";
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

    }
    public String showDetail(String doc_id)throws  Exception{
        ThaiUtil objth = new ThaiUtil();
        UtiDatabase objuti = new UtiDatabase();
        String SQL1,SQL,strOutput = "";
        strOutput += "<table width='100%' align='center' border='0' cellpadding='0' cellspacing='1' class='inner'>";
        
        strOutput += "<tr>";
        strOutput += "<td class=\"row3\" width=\"3%\"><input type=\"checkbox\" name=\"chk_all\" id=\"chk_all\" value=\"chk_all\" onClick=\"javascript:ckall(this.checked);\"/></td>";
        strOutput += "<td class=\"row3\" width=\"7%\">ลำดับ&nbsp;</td>";
        strOutput += "<td class=\"row3\" width=\"15%\">รหัสถ่าน</td>";
        strOutput += "<td class=\"row3\" width=\"5%\">ชนิดถ่าน&nbsp;</td>";
        strOutput += "<td class=\"row3\" width=\"15%\">ขนาดถ่าน&nbsp;</td>";
        strOutput += "<td class=\"row3\" width=\"15%\">เกรดไอโอดีน&nbsp;</td>";
        strOutput += "<td class=\"row3\" width=\"10%\">กระสอบ&nbsp;</td>";
        strOutput += "<td class=\"row3\" width=\"10%\">น้ำหนัก&nbsp;</td>";
        strOutput += "<td class=\"row3\" width=\"10%\">เครื่องผลิต&nbsp;</td>";        
        strOutput += "<td class=\"row3\" width=\"15%\">ใบแจ้งผลิต&nbsp;</td>";                
        strOutput += "<td class=\"row3\" width=\"15%\">โกดัง&nbsp;</td>";        
        strOutput += "<td class=\"row3\" width=\"15%\">กอง&nbsp;</td>";        
        strOutput += "</tr>";        
        


        SQL1 = "Select Count(doc_id) As num from  d_carbon_withdraw_detail_wh where doc_id ='"+objth.EncodeTexttoTIS(doc_id)+"' and delete_flag <> 'Y' and complete_flag <> 'Y' ";
        int a = objuti.numRowdatabase(SQL1);
	SQL = "Select doc_id,product_id,line_no,pcat_id,size_use,grd_io_ctc,weight,machine,job_id,bag,wh_id,location_id from vd_carbon_withdraw_detail_wh where doc_id ='"+objth.EncodeTexttoTIS(doc_id)+"' and delete_flag <> 'Y' and complete_flag <> 'Y' order by runno";
	DBConnect objcon = new DBConnect();
	Connection con =objcon.openNewConnection();
	ResultSet rs = null;
        rs =con.createStatement().executeQuery(SQL);
	while(rs.next())
	{

	strOutput += "<tr>";
        strOutput +="<td class='forborder' width='3px'><input type='checkbox' id='ckbox' name='ckbox' onclick=\"cancle_chkboxAll('chk_all',this.checked)\"></td>";
        strOutput +="<td class='forborder' width='7%'><a href=\"#\"  class='link_data_transparent' onclick=\"OpenEdit(URLsend('line_no_"+rs.getString("line_no")+",doc_id,username','../SCREEN/CS_303.jsp'))\"><input type='hidden' id='line_no_"+rs.getString("line_no")+"' value=\""+rs.getString("line_no")+"\"><input type='hidden' id='doc_id' value=\""+rs.getString("doc_id")+"\">"+rs.getString("line_no")+"</a></td>";
        strOutput +="<td class='forborder' width='15%'>"+rs.getString("product_id")+"&nbsp;</td>";
        strOutput +="<td class='forborder' width='5%'>"+rs.getString("pcat_id")+"&nbsp;</td>";
        strOutput +="<td class='forborder' width='15%'>"+rs.getString("size_use")+"&nbsp;</td>";
        strOutput +="<td class='forborder' width='15%'>"+rs.getString("grd_io_ctc")+"&nbsp;</td>";
        strOutput +="<td class='forborder' width='10%'>"+rs.getString("bag")+"&nbsp;</td>";
	strOutput +="<td class='forborder' width='10%'>"+rs.getString("weight")+"&nbsp;</td>";
        strOutput +="<td class='forborder' width='10%'>"+rs.getString("machine")+"&nbsp;</td>";
	strOutput +="<td class='forborder' width='15%'>"+rs.getString("job_id")+"&nbsp;</td>";
        strOutput +="<td class='forborder' width='15%'>"+ (rs.getString("wh_id")==null||rs.getString("wh_id").equals("") ? "-" : rs.getString("wh_id")) + "</td>";
        strOutput +="<td class='forborder' width='15%'>"+ (rs.getString("location_id")==null||rs.getString("wh_id").equals("") ? "-" : rs.getString("location_id")) + "</td>";        
	strOutput +="</tr>";
	}
	rs.close();
        con.close();
        strOutput +="</table>";
        return strOutput;
    }
    
}
