/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.cgc.DB;

import com.cgc.Util.ThaiUtil;
import com.cgc.Util.UtiDatabase;
import com.cgc.bean.DataBeanD_requisition_product_detail;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author Beck
 */
public class D_requisition_product_detail_whDAO {
    private int Returnvalue;

    public int insert(DataBeanD_requisition_product_detail dataBean) throws Exception {
        Returnvalue = 0;
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        String sql = "insert into d_requisition_product_detail_wh "
                + "(doc_id,line_no,product_id,weight,bag,lot_no,remark,wh_in,wh_out,doc_date,create_date,create_by,quantity,job_id)"
                + " values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getDoc_id());
            p.setString(2, dataBean.getLine_no());
            p.setString(3, dataBean.getProduct_id());
            p.setString(4, dataBean.getWeight());
            p.setString(5, dataBean.getBag());
            p.setString(6, dataBean.getLot_no());
            p.setString(7, dataBean.getRemark());
            p.setString(8, dataBean.getWh_in());
            p.setString(9, dataBean.getWh_out());
            p.setString(10, dataBean.getDoc_date());
            p.setTimestamp(11, dataBean.getDate());
            p.setString(12, dataBean.getBy());
            p.setString(13, dataBean.getQuantity());
            p.setString(14, dataBean.getJob_id());
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

    public int update(DataBeanD_requisition_product_detail dataBean) throws Exception {
        Returnvalue = 0;
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();

        String sql =
                "update d_requisition_product_detail_wh set  "
                + "product_id=?,weight=?,bag=?,lot_no=?,remark=?,wh_in=?,wh_out=?,doc_date=?,update_date=?,update_by=?,quantity=?,job_id=?"
                + " where doc_id=? and line_no=? and delete_flag <> 'Y' and complete_flag <> 'Y'";
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            //p.setString(1, dataBean.getDoc_date());
            p.setString(1, dataBean.getProduct_id());
            p.setString(2, dataBean.getWeight());
            p.setString(3, dataBean.getBag());
            p.setString(4, dataBean.getLot_no());
            p.setString(5, dataBean.getRemark());
            p.setString(6, dataBean.getWh_in());
            p.setString(7, dataBean.getWh_out());
            p.setString(8, dataBean.getDoc_date());
            p.setTimestamp(9, dataBean.getDate());
            p.setString(10, dataBean.getBy());
            p.setString(11, dataBean.getQuantity());
            p.setString(12, dataBean.getJob_id());
            p.setString(13, dataBean.getDoc_id());
            p.setString(14, dataBean.getLine_no());
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

    public DataBeanD_requisition_product_detail ReturnEdit(String Doc_id, String Line_no, DataBeanD_requisition_product_detail bean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        UtiDatabase objuti = new UtiDatabase();
        String SQL = "Select doc_id,doc_date,line_no,product_id,prod_name,wh_in,wh_out,lot_no,bag,weight,remark,quantity,job_id,(select vd_job_order_header.cust_name from vd_job_order_header where vd_job_order_header.doc_id = vd_requisition_product_detail_wh.job_id) as job_id_desc from vd_requisition_product_detail_wh where doc_id = '" + Doc_id + "' and line_no ='" + Line_no + "' and delete_flag <> 'Y' and complete_flag <> 'Y'";
        ResultSet  rs = con.createStatement().executeQuery(SQL);
        try {
            while (rs.next()) {
                bean.setDoc_id(rs.getString("doc_id"));
                bean.setDoc_date(rs.getString("doc_date"));
                bean.setLine_no(rs.getString("line_no"));
                bean.setProduct_id(rs.getString("product_id"));
                bean.setProd_name(rs.getString("prod_name"));
                bean.setWh_in(rs.getString("wh_in"));
                bean.setWh_out(rs.getString("wh_out"));
                bean.setLot_no(rs.getString("lot_no"));
                bean.setBag(rs.getString("bag"));
                bean.setWeight(rs.getString("weight"));
                bean.setRemark(rs.getString("remark"));
                bean.setRemark(objuti.EncodeNewLine(rs.getString("remark")));
                bean.setQuantity(rs.getString("quantity"));
                bean.setJob_id(rs.getString("job_id"));
                bean.setJob_id_desc(rs.getString("job_id_desc"));
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

    public int DeleteLine_no(String inputarry, DataBeanD_requisition_product_detail bean) throws Exception {
        UtiDatabase objuti = new UtiDatabase();
        boolean ckclose = false;
        boolean pclose = false;
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        int count = 1;
        int total = 0;
        ResultSet rs = null;
        PreparedStatement p = null;
        String sql, sql2 = "";
        try {

            if (inputarry.length() != 0) {
                String[] strarry = inputarry.split(",");
                for (int i = 0; i < strarry.length; i++) {
                    //JOptionPane.showConfirmDialog(null,strarry[i]);

                    sql = "update d_requisition_product_detail_wh set delete_flag=?,delete_date=?,delete_by=? where doc_id=? and line_no=? and delete_flag <> 'Y' and complete_flag <> 'Y'";
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
                    ///strarryMem_line_no.clear();
                    //JOptionPane.showConfirmDialog(null, bean.getDoc_id().length());
                    sql = "select count(doc_id) as num from d_requisition_product_detail_wh where doc_id ='" + bean.getDoc_id() + "' and delete_flag <> 'Y' and complete_flag <> 'Y'";
                    if(objuti.numRowdatabase(sql) != 0){
                    p = null;
                    sql2 = "Select line_no from  d_requisition_product_detail_wh where doc_id ='" + bean.getDoc_id() + "' and delete_flag <> 'Y' and complete_flag <> 'Y' order by runno ";
                    rs = con.createStatement().executeQuery(sql2);
                    while (rs.next()) {
                        sql = "update d_requisition_product_detail_wh set line_no=? where doc_id=? and line_no=?";
                        p = con.prepareStatement(sql);
                        p.setString(1, Integer.toString(count));
                        p.setString(2, bean.getDoc_id());
                        p.setString(3, rs.getString("line_no"));
                        p.executeUpdate();
                        count = count + 1;
                    }
                    sql2= "select weight,bag from vd_requisition_product_detail_wh where doc_id ='" + bean.getDoc_id() + "' and delete_flag <> 'Y' and complete_flag <> 'Y' order by runno ";
                    rs = null;
                    rs = con.createStatement().executeQuery(sql2);
                    while(rs.next())
                    {
                        total = total + (Integer.parseInt(rs.getString("weight")));
                    }
                    ckclose = true;
                    }
                }

            }else{
                total = -1;
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
        //JOptionPane.showConfirmDialog(null, total);
        return total;

    }

    public int Delete_line_no_All(DataBeanD_requisition_product_detail dataBean) throws Exception {
        int total = 0;
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sqldetail = "update d_requisition_product_detail_wh set delete_flag = ?,delete_date=?,delete_by=? where doc_id=? and delete_flag <> 'Y' and complete_flag <> 'Y'";
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
        return total;
    }
    public String showDetail(String doc_id)throws Exception{
        ThaiUtil objth = new ThaiUtil();
        UtiDatabase objuti = new UtiDatabase();
        String SQL1,SQL = "";
        String strOutput ="";
        strOutput += "<table width='100%' align='center' border='0' cellpadding='0' cellspacing='1' class='inner'>";


        SQL1 = "Select Count(doc_id) As num from  d_requisition_product_detail_wh where doc_id ='"+objth.EncodeTexttoTIS(doc_id)+"' and delete_flag <> 'Y' and complete_flag <> 'Y' ";
        int a = objuti.numRowdatabase(SQL1);
	SQL = "Select doc_id,line_no,prod_name,weight,bag,lot_no,remark,quantity from vd_requisition_product_detail_wh where doc_id ='"+objth.EncodeTexttoTIS(doc_id)+"' and delete_flag <> 'Y' and complete_flag <> 'Y' order by runno";
	DBConnect objcon = new DBConnect();
	Connection con =objcon.openNewConnection();
	ResultSet rs = null;
        rs =con.createStatement().executeQuery(SQL);
	while(rs.next())
	{

	strOutput += "<tr>";
        strOutput += "<td class='forborder' width='3px'><input type='checkbox' id='ckbox' name='ckbox' onclick=\"cancle_chkboxAll('chk_all',this.checked)\"></td>";
        strOutput += "<td class='forborder' width='7%'><a href=\"#\"  class='link_data_transparent' onclick=\"OpenEdit(URLsend('line_no_"+rs.getString("line_no")+",doc_id,net_weight,username','../SCREEN/CS_310.jsp'))\"><input type='hidden' id='line_no_"+rs.getString("line_no")+"' value=\""+rs.getString("line_no")+"\"><input type='hidden' id='doc_id' value=\""+rs.getString("doc_id")+"\">"+rs.getString("line_no")+"</a></td>";
        strOutput += "<td class='forborder' width='20%'>"+rs.getString("prod_name")+"&nbsp;</td>";
        strOutput += "<td class='forborder' width='15%'>"+rs.getString("quantity")+"&nbsp;</td>";
        strOutput += "<td class='forborder' width='15%'>"+rs.getString("bag")+"&nbsp;</td>";
	strOutput += "<td class='forborder' width='10%'>"+rs.getString("lot_no")+"&nbsp;</td>";
        strOutput += "<td class='forborder' width='30%'>"+objuti.EncodeNewLine(rs.getString("remark"))+"&nbsp;</td>";
	strOutput += "</tr>";
	}
	rs.close();
        con.close();
        strOutput += "</table>";
        return strOutput;
    }
}
